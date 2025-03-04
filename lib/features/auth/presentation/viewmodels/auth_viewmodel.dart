import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart'; // FCM 추가
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper_fe/core/config/routes/route_names.dart';
import 'package:love_keeper_fe/core/providers/auth_state_provider.dart';
import 'package:love_keeper_fe/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:love_keeper_fe/features/couples/presentation/viewmodels/couples_viewmodel.dart';
import 'package:love_keeper_fe/features/fcm/presentation/viewmodels/fcm_viewmodel.dart'; // FCMViewModel 추가
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
        password: password,
        providerId: providerId,
        profileImage: profileImage,
      );
      await _saveTokens(user);
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
      state = AsyncValue.data(user);
      // FCM 토큰 업데이트를 별도로 호출하지 않음
      return user;
    } catch (e) {
      String errorMessage = e is DioException && e.response?.statusCode == 401
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
            'providerId': providerId
          },
        );
      } on DioException catch (e) {
        if (e.response?.statusCode == 409) {
          final user = await login(
            email: email,
            provider: provider,
            providerId: providerId,
          );
          print('Logged in user: ${user.memberId}, ${user.email}');
          try {
            final coupleInfo = await ref
                .read(couplesViewModelProvider.notifier)
                .getCoupleInfo();
            print(
                'Navigating to main page with couple info: ${coupleInfo.coupleId}');
            context.go(RouteNames.mainPage);
          } on DioException catch (e) {
            print(
                'Couple info fetch failed - Status: ${e.response?.statusCode}, Data: ${e.response?.data}, Error: $e');
            context.go(RouteNames.codeConnectPage);
            // FCM 오류와 분리하기 위해 별도 처리
            rethrow;
          }
          // FCM 토큰 업데이트를 별도로 호출
          await _updateFCMToken();
        } else {
          print(
              'Email duplication check failed: ${e.response?.statusCode}, ${e.response?.data}');
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
      final fcmViewModel = ref.read(fCMViewModelProvider.notifier);
      final token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        await fcmViewModel.registerToken(token);
        print('FCM token updated after login');
      } else {
        print('FCM token not available');
      }
    } catch (e) {
      print('FCM token update failed: $e');
    }
  }

  // 나머지 메서드 (sendCode, verifyCode, logout 등)는 변경 없음
  Future<String> sendCode(String email) async {
    try {
      return await _repository.sendCode(email);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> verifyCode(String email, int code) async {
    try {
      return await _repository.verifyCode(email, code);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> logout() async {
    try {
      final result = await _repository.logout();
      await _clearTokens();
      state = const AsyncValue.data(null);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> resetPasswordRequest(String email) async {
    try {
      return await _repository.resetPasswordRequest(email);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> resetPassword(
      String email, String password, String passwordConfirm) async {
    try {
      return await _repository.resetPassword(email, password, passwordConfirm);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> checkToken(String token) async {
    try {
      final response = await _repository.checkToken(token);
      return response;
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
      return await _repository.emailDuplication(email);
    } catch (e) {
      print('Email duplication check error: $e');
      rethrow;
    }
  }

  Future<void> _saveTokens(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('memberId', user.memberId);
    final accessToken = prefs.getString('access_token');
    print(
        'Saved tokens - memberId: ${user.memberId}, accessToken: $accessToken');
  }

  Future<void> _clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
    await prefs.remove('memberId');
  }
}
