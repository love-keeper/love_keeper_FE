import 'dart:io';
import 'package:love_keeper_fe/core/network/client/api_client.dart';
import 'package:love_keeper_fe/features/auth/data/models/request/email_duplication_request.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/config/di/dio_module.dart';
import '../../../../core/models/api_response.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/request/login_request.dart';
import '../models/request/send_code_request.dart';
import '../models/request/verify_code_request.dart';
import '../models/request/password_reset_request.dart';

part 'auth_repository_impl.g.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient apiClient;

  AuthRepositoryImpl(this.apiClient);

  @override
  Future<User> signup({
    required String email,
    required String nickname,
    required String birthDate,
    required String provider,
    String? password,
    String? providerId,
    File? profileImage,
  }) async {
    final response = await apiClient.signup(
      email: email,
      nickname: nickname,
      birthDate: birthDate,
      provider: provider,
      password: password,
      providerId: providerId,
      profileImage: profileImage,
    );
    _handleResponse(response);
    return User(
      memberId: response.result!.memberId,
      email: response.result!.email,
      role: response.result!.role,
      social: response.result!.social,
    );
  }

  @override
  Future<User> login({
    required String email,
    required String provider,
    String? password,
    String? providerId,
  }) async {
    final request = LoginRequest(
      email: email,
      provider: provider,
      password: password,
      providerId: providerId,
    );
    final response = await apiClient.login(request);
    _handleResponse(response);
    return User(
      memberId: response.result!.memberId,
      email: response.result!.email,
      role: response.result!.role,
      social: response.result!.social,
    );
  }

  @override
  Future<String> sendCode(String email) async {
    final request = SendCodeRequest(email: email);
    final response = await apiClient.sendCode(request);
    _handleResponse(response);
    return response.result!.code; // "775050" 같은 인증 코드 반환
  }

  @override
  Future<String> verifyCode(String email, int code) async {
    final request = VerifyCodeRequest(email: email, code: code);
    final response = await apiClient.verifyCode(request);
    _handleResponse(response);
    return response.result!;
  }

  @override
  Future<String> logout() async {
    final response = await apiClient.logout();
    _handleResponse(response);
    return response.result!;
  }

  @override
  Future<String> resetPasswordRequest(String email) async {
    final request = SendCodeRequest(email: email);
    final response = await apiClient.resetPasswordRequest(request);
    _handleResponse(response);
    return response.result!;
  }

  @override
  Future<String> resetPassword(
      String email, String password, String passwordConfirm) async {
    final request = PasswordResetRequest(
      email: email,
      password: password,
      passwordConfirm: passwordConfirm,
    );
    final response = await apiClient.resetPassword(request);
    _handleResponse(response);
    return response.result!;
  }

  @override
  Future<bool> checkToken(String token) async {
    final response = await apiClient.checkToken('Bearer $token');
    return response.code == 'COMMON200';
  }

  @override
  Future<String> emailDuplication(String email) async {
    final request = EmailDuplicationRequest(email: email);
    final response = await apiClient.emailDuplication(request);
    _handleResponse(response);
    return response.result!;
  }

  void _handleResponse(ApiResponse<dynamic> response) {
    // 타입 명시
    if (!['COMMON200', 'COMMON201'].contains(response.code)) {
      throw Exception('${response.code}: ${response.message}');
    }
  }
}

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  final apiClient = ref.watch(apiClientProvider);
  return AuthRepositoryImpl(apiClient);
}
