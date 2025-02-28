import 'dart:io';
import 'package:dio/dio.dart';
import 'package:love_keeper_fe/features/auth/data/repositories/auth_repository_impl.dart';
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

  Future<void> signup({
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
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> login({
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
      // DioException은 인터셉터에서 처리하므로 여기서 재시도 결과 기다림
      final prefs = await SharedPreferences.getInstance();
      final newAccessToken = prefs.getString('access_token');
      if (newAccessToken != null && newAccessToken != token) {
        // reissue로 새 토큰 발급된 경우 재시도
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
