import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper/core/config/routes/route_names.dart';
import 'package:love_keeper/core/providers/auth_state_provider.dart';
import 'package:love_keeper/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:love_keeper/features/couples/presentation/viewmodels/couples_viewmodel.dart';
import 'package:love_keeper/features/fcm/presentation/viewmodels/fcm_viewmodel.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late final AuthRepository _repository;

  @override
  AsyncValue<User?> build() {
    _repository = ref.watch(authRepositoryProvider);
    _checkLoginStatus();
    return const AsyncValue.data(null);
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    print('Initial access token: $token');
  }

  Future<User> signup({
    required String email,
    required String nickname,
    required String birthDate,
    required String provider,
    required bool privacyPolicyAgreed,
    bool? marketingAgreed,
    required bool termsOfServiceAgreed,
    String? password,
    String? providerId,
    File? profileImage,
  }) async {
    state = const AsyncValue.loading();
    try {
      final user = await _repository.signup(
        email: email,
        nickname: nickname,
        birthDate: birthDate,
        provider: provider,
        privacyPolicyAgreed: privacyPolicyAgreed,
        marketingAgreed: marketingAgreed,
        termsOfServiceAgreed: termsOfServiceAgreed,
        password: password,
        providerId: providerId,
        profileImage: profileImage,
      );
      await _saveTokens(user);
      await _updateFCMToken();
      state = AsyncValue.data(user);
      return user;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      print('Signup error: $e');
      rethrow;
    }
  }

  Future<User> login({
    required String email,
    required String provider,
    String? password,
    String? providerId,
    required BuildContext context, // context 추가
  }) async {
    state = const AsyncValue.loading();
    try {
      final user = await _repository.login(
        email: email,
        provider: provider,
        password: password,
        providerId: providerId,
      );
      await _saveTokens(user);
      await _updateFCMToken();
      state = AsyncValue.data(user);

      // 로그인 후 커플 상태 체크
      try {
        final coupleInfo =
            await ref.read(couplesViewModelProvider.notifier).getCoupleInfo();
        if (coupleInfo != null) {
          print(
            'Couple info found: ${coupleInfo.coupleId}, navigating to MainPage',
          );
          context.go(RouteNames.mainPage);
        } else {
          print('No couple info found, navigating to CodeConnectPage');
          context.go(RouteNames.codeConnectPage);
        }
      } on DioException catch (e) {
        print('Couple info fetch failed: $e');
        context.go(RouteNames.codeConnectPage);
      }

      return user;
    } catch (e) {
      String errorMessage =
          e is DioException && e.response?.statusCode == 401
              ? '로그인 실패: 계정이 등록되지 않았거나 비밀번호가 잘못되었습니다.'
              : '로그인 중 오류 발생: $e';
      print(errorMessage);
      state = AsyncValue.error(errorMessage, StackTrace.current);
      rethrow;
    }
  }

  Future<void> handleSocialLogin({
    required String email,
    required String provider,
    required String providerId,
    required BuildContext context,
  }) async {
    state = const AsyncValue.loading();
    try {
      try {
        await _repository.emailDuplication(email);
        ref.read(authStateNotifierProvider.notifier).updateEmail(email);
        ref.read(authStateNotifierProvider.notifier).updateProvider(provider);
        ref
            .read(authStateNotifierProvider.notifier)
            .updateProviderId(providerId);

        context.pushNamed(
          RouteNames.profileRegistrationPage,
          extra: {
            'email': email,
            'provider': provider,
            'providerId': providerId,
          },
        );
      } on DioException catch (e) {
        if (e.response?.statusCode == 409) {
          final user = await login(
            email: email,
            provider: provider,
            providerId: providerId,
            context: context, // context 전달
          );
          print('Logged in user: ${user.memberId}, ${user.email}');
          // login 메서드에서 라우팅 처리하므로 여기서 추가 작업 불필요
        } else {
          print(
            'Email duplication check failed: ${e.response?.statusCode}, ${e.response?.data}',
          );
          rethrow;
        }
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      print('Social login handling error: $e');
      rethrow;
    } finally {
      state = AsyncValue.data(state.value);
    }
  }

  Future<void> _updateFCMToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');
      if (accessToken == null) {
        print('No access token available for FCM update');
        return;
      }

      final fcmViewModel = ref.read(fCMViewModelProvider.notifier);
      final token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        print('Updating FCM token with access token: $accessToken');
        await fcmViewModel.registerToken(token);
        print('FCM token updated after login');
      } else {
        print('FCM token not available');
      }
    } catch (e) {
      print('FCM token update failed: $e');
    }
  }

  Future<void> _saveTokens(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('memberId', user.memberId);
    final accessToken = prefs.getString('access_token');
    if (accessToken == null) {
      print('Warning: access_token not found after login/signup');
    }
    print(
      'Saved tokens - memberId: ${user.memberId}, accessToken: $accessToken',
    );
  }

  Future<void> _clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
    await prefs.remove('memberId');
  }

  Future<String> sendCode(String email) async =>
      await _repository.sendCode(email);
  Future<String> verifyCode(String email, int code) async =>
      await _repository.verifyCode(email, code);
  Future<String> logout() async {
    final result = await _repository.logout();
    await _clearTokens();
    state = const AsyncValue.data(null);
    return result;
  }

  Future<String> resetPasswordRequest(String email) async =>
      await _repository.resetPasswordRequest(email);
  Future<String> resetPassword(
    String email,
    String password,
    String passwordConfirm,
  ) async => await _repository.resetPassword(email, password, passwordConfirm);
  Future<bool> checkToken(String token) async {
    try {
      return await _repository.checkToken(token);
    } catch (e) {
      print('Check token error: $e');
      final prefs = await SharedPreferences.getInstance();
      final newAccessToken = prefs.getString('access_token');
      if (newAccessToken != null && newAccessToken != token) {
        return await _repository.checkToken(newAccessToken);
      }
      return false;
    }
  }

  Future<String> emailDuplication(String email) async {
    try {
      final result = await _repository.emailDuplication(email);
      return result;
    } catch (e) {
      print('Email duplication check error: $e');
      rethrow;
    }
  }
}
