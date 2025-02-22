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
}
