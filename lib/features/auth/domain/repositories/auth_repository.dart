import 'dart:io';

import '../entities/user.dart';

abstract class AuthRepository {
  Future<User> signup({
    required String email,
    required String nickname,
    required String birthDate,
    required String provider,
    required bool privacyPolicyAgreed,
    bool? marketingAgreed, // 필수 아님
    required bool termsOfServiceAgreed,
    String? password,
    String? providerId,
    File? profileImage, // File 타입으로 변경
  });

  Future<User> login({
    required String email,
    required String provider,
    String? password,
    String? providerId,
  });

  Future<String> sendCode(String email);

  Future<String> verifyCode(String email, int code);

  Future<String> logout();

  Future<String> resetPasswordRequest(String email);

  Future<String> resetPassword(
      String email, String password, String passwordConfirm);

  Future<bool> checkToken(String token); // 토큰 유효성 확인 추가

  Future<String> emailDuplication(String email);
}
