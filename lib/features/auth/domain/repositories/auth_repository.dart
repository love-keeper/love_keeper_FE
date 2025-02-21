import '../entities/user.dart';

import '../entities/user.dart';

abstract class AuthRepository {
  Future<User> signup({
    required String email,
    required String nickname,
    required String birthDate,
    required String provider,
    String? password,
    String? providerId,
    String? profileImage,
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
}
