// lib/features/auth/view_models/auth_view_model.dart
import 'package:love_keeper/features/auth/models/auth_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:shared_preferences/shared_preferences.dart';

part 'auth_view_model.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  // SharedPreferences에서 사용할 키 값들을 상수로 정의합니다.
  static const String _isAuthenticatedKey = 'is_authenticated';
  static const String _userEmailKey = 'user_email';
  
  // SharedPreferences 인스턴스를 저장할 변수입니다.
  late final SharedPreferences _prefs;

  @override
  AuthState build() {
    // 앱 시작시 저장된 로그인 정보를 확인합니다.
    // build 메서드는 동기적으로 동작해야 하므로, 비동기 작업은 따로 처리합니다.
    _initializePrefs();
    return const AuthState();
  }

  // SharedPreferences를 초기화하고 저장된 로그인 정보를 확인하는 메서드입니다.
  Future<void> _initializePrefs() async {
    try {
      // SharedPreferences 인스턴스를 초기화합니다.
      _prefs = await SharedPreferences.getInstance();
      await _checkStoredAuth();
    } catch (e) {
      // 초기화 중 에러가 발생하면 에러 상태를 설정합니다.
      state = AuthState(error: e.toString());
    }
  }

  // 저장된 로그인 정보를 확인하는 메서드입니다.
  Future<void> _checkStoredAuth() async {
    try {
      // SharedPreferences에서 인증 상태와 이메일을 가져옵니다.
      final isAuthenticated = _prefs.getBool(_isAuthenticatedKey) ?? false;
      final email = _prefs.getString(_userEmailKey);

      // 저장된 정보를 바탕으로 상태를 업데이트합니다.
      state = AuthState(
        isAuthenticated: isAuthenticated,
        email: email,
        isLoading: false,
      );
    } catch (e) {
      state = AuthState(error: e.toString());
    }
  }

  // 로그인을 처리하는 메서드입니다.
  Future<void> login(String email) async {
    try {
      // 로딩 상태를 true로 설정합니다.
      state = AuthState(
        isAuthenticated: false,
        email: email,
        isLoading: true,
      );

      // 실제 로그인 API 호출이 들어갈 자리입니다.
      // 여기서는 예시로 지연시간만 추가합니다.
      await Future.delayed(const Duration(seconds: 1));

      // 로그인 정보를 SharedPreferences에 저장합니다.
      await _prefs.setBool(_isAuthenticatedKey, true);
      await _prefs.setString(_userEmailKey, email);

      // 상태를 인증됨으로 업데이트합니다.
      state = AuthState(
        isAuthenticated: true,
        email: email,
      );
    } catch (e) {
      // 에러가 발생하면 에러 상태를 설정합니다.
      state = AuthState(error: e.toString());
    }
  }

  // 로그아웃을 처리하는 메서드입니다.
  Future<void> logout() async {
    try {
      // 로그아웃 처리 중임을 표시합니다.
      state = state.copyWith(isLoading: true);

      // SharedPreferences에서 로그인 정보를 삭제합니다.
      await _prefs.remove(_isAuthenticatedKey);
      await _prefs.remove(_userEmailKey);

      // 상태를 비인증 상태로 업데이트합니다.
      state = const AuthState(
        isAuthenticated: false,
      );
    } catch (e) {
      state = AuthState(error: e.toString());
    }
  }

  // 에러를 초기화하는 메서드입니다.
  void clearError() {
    state = state.copyWith(error: null);
  }
}