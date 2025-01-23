import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

part 'auth_local_datasource.g.dart';

abstract class AuthLocalDataSource {
  /// 사용자 정보를 로컬에 저장합니다.
  Future<void> saveUser(UserModel user);

  /// 저장된 사용자 정보를 가져옵니다.
  Future<UserModel?> getUser();

  /// 저장된 사용자 정보를 삭제합니다.
  Future<void> deleteUser();

  /// 인증 토큰을 저장합니다.
  Future<void> saveToken(String token);

  /// 저장된 인증 토큰을 가져옵니다.
  Future<String?> getToken();

  /// 저장된 인증 토큰을 삭제합니다.
  Future<void> deleteToken();

  /// 자동 로그인 설정을 저장합니다.
  Future<void> saveAutoLogin(bool value);

  /// 자동 로그인 설정을 가져옵니다.
  Future<bool> getAutoLogin();
}

@riverpod
AuthLocalDataSource authLocalDataSource(AuthLocalDataSourceRef ref) {
  return AuthLocalDataSourceImpl();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static const String _keyUser = 'user';
  static const String _keyToken = 'token';
  static const String _keyAutoLogin = 'auto_login';

  @override
  Future<void> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUser, jsonEncode(user.toJson()));
  }

  @override
  Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_keyUser);
    if (userJson == null) return null;

    try {
      // jsonDecode의 결과를 Map<String, dynamic>으로 캐스팅
      return UserModel.fromJson(jsonDecode(userJson) as Map<String, dynamic>);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> deleteUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUser);
  }

  @override
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyToken, token);
  }

  @override
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyToken);
  }

  @override
  Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyToken);
  }

  @override
  Future<void> saveAutoLogin(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyAutoLogin, value);
  }

  @override
  Future<bool> getAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyAutoLogin) ?? false;
  }
}
