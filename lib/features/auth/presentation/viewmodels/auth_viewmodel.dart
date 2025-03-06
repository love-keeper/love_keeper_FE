import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper/core/config/routes/route_names.dart';
import 'package:love_keeper/core/providers/auth_state_provider.dart';
import 'package:love_keeper/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:love_keeper/features/couples/presentation/viewmodels/couples_viewmodel.dart';
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
    required bool privacyPolicyAgreed, // 필수
    bool? marketingAgreed, // 필수 아님
    required bool termsOfServiceAgreed, // 필수
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
        marketingAgreed: marketingAgreed, // nullable로 전달
        termsOfServiceAgreed: termsOfServiceAgreed,
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
      return user;
    } catch (e) {
      String errorMessage;
      if (e is DioException && e.response?.statusCode == 401) {
        errorMessage = '로그인 실패: 계정이 등록되지 않았거나 비밀번호가 잘못되었습니다.';
      } else {
        errorMessage = '로그인 중 오류 발생: $e';
      }
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
      // 1. 이메일 중복 체크
      try {
        await _repository.emailDuplication(email);
        // 중복이 아닌 경우 (200 응답) -> 프로필 등록으로 이동
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
          // 2. 409 Conflict: 이미 가입된 회원 -> 로그인 수행
          final user = await login(
            email: email,
            provider: provider,
            providerId: providerId,
          );

          // 3. 커플 정보 가져오기 시도
          try {
            final coupleInfo = await ref
                .read(couplesViewModelProvider.notifier)
                .getCoupleInfo();
            // 커플 정보가 성공적으로 불러와졌으면 메인 화면으로 이동
            context.go(RouteNames.mainPage);
          } on DioException catch (e) {
            // 커플 정보가 없는 경우 (예: COUPLE001, 404 등)
            print('Couple info not found: ${e.response?.data}');
            context.go(RouteNames.codeConnectPage);
          }
        } else {
          // 기타 DioException 처리
          rethrow;
        }
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      print('Social login handling error: $e');
      rethrow;
    } finally {
      state = AsyncValue.data(state.value); // 상태 복원
    }
  }

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
      final result = await _repository.emailDuplication(email);
      return result;
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
