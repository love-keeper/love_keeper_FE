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
    required BuildContext context,
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
      final loggedInUser = await login(
        email: email,
        provider: provider,
        password: password,
        providerId: providerId,
        context: context,
      );
      state = AsyncValue.data(loggedInUser);
      return loggedInUser;
    } on DioException catch (e, stackTrace) {
      final message = e.response?.data.toString();
      if (e.response?.statusCode == 500 &&
          message != null &&
          message.contains('이미 사용 중인 이메일')) {
        print('⚠️ 중복 이메일 감지됨 → 로그인 시도');
        try {
          final user = await login(
            email: email,
            provider: provider,
            password: password,
            providerId: providerId,
            context: context,
          );
          state = AsyncValue.data(user);
          return user;
        } catch (loginError, loginStack) {
          state = AsyncValue.error(loginError, loginStack);
          rethrow;
        }
      }
      state = AsyncValue.error(e, stackTrace);
      print('Signup error: $e');
      rethrow;
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
    required BuildContext context,
  }) async {
    state = const AsyncValue.loading();

    try {
      debugPrint(
        'Login params: email=$email, provider=$provider, password=$password, providerId=$providerId',
      );

      final user = await _repository.login(
        email: email,
        provider: provider,
        password: password,
        providerId: providerId,
      );

      await _saveTokens(user);

      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');
      if (accessToken == null) {
        throw Exception('Access token not stored after login');
      }

      await _updateFCMToken();

      // 커플 상태 확인
      if (!context.mounted) return user;

      final coupleInfo =
          await ref.read(couplesViewModelProvider.notifier).getCoupleInfo();

      if (coupleInfo != null) {
        final String? endedAtStr = coupleInfo.endedAt;
        final now = DateTime.now();

        if (coupleInfo.coupleStatus == 'DISCONNECTED' && endedAtStr != null) {
          final endedAt = DateTime.tryParse(endedAtStr);
          if (endedAt != null) {
            final daysSinceDisconnected = now.difference(endedAt).inDays;
            if (daysSinceDisconnected < 15) {
              if (!context.mounted) return user;
              context.go('/disconnectedScreen'); // 복구 가능
            } else {
              if (!context.mounted) return user;
              context.go('/codeConnect'); // 복구 불가능
            }
          } else {
            if (!context.mounted) return user;
            context.go('/codeConnect'); // endedAt 파싱 실패 → 복구 불가 처리
          }
        } else {
          if (!context.mounted) return user;
          context.go('/main'); // 커플 연결 유지 중
        }
      } else {
        // coupleInfo 자체가 null인 경우 → 복구 불가로 처리
        if (!context.mounted) return user;
        context.go('/codeConnect');
      }

      state = AsyncValue.data(user);
      return user;
    } catch (e) {
      String errorMessage =
          e is DioException && e.response?.statusCode == 401
              ? '로그인 실패: 계정 정보가 잘못되었습니다.'
              : '로그인 중 오류 발생: $e';
      debugPrint(errorMessage);
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
      } on DioException catch (e) {
        if (e.response?.statusCode == 409) {
          // 중복이면 로그인 시도
          await login(
            email: email,
            provider: provider,
            providerId: providerId,
            context: context,
          );
          final prefs = await SharedPreferences.getInstance();
          final accessToken = prefs.getString('access_token');
          print(
            'Social login successful: email=$email, accessToken=$accessToken',
          );
        } else {
          print('Email duplication check failed: ${e.response?.statusCode}');
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
