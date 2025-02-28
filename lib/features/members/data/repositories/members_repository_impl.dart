import 'dart:io';
import 'package:love_keeper_fe/core/network/client/api_client.dart';
import 'package:love_keeper_fe/features/members/data/models/request/send_email_code_request.dart';
import 'package:love_keeper_fe/features/members/data/models/request/verify_email_code_request.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/config/di/dio_module.dart';
import '../../../../core/models/api_response.dart';
import '../../domain/repositories/members_repository.dart';
import '../models/request/update_birthday_request.dart';
import '../models/request/update_nickname_request.dart';
import '../models/request/update_password_request.dart';

part 'members_repository_impl.g.dart';

class MembersRepositoryImpl implements MembersRepository {
  final ApiClient apiClient;

  MembersRepositoryImpl(this.apiClient);

  @override
  Future<String> updateNickname(String nickname) async {
    final request = UpdateNicknameRequest(nickname: nickname);
    final response = await apiClient.updateNickname(request);
    _handleResponse(response);
    return response.result!.nickname;
  }

  @override
  Future<String> updateBirthday(String birthday) async {
    final request = UpdateBirthdayRequest(birthday: birthday);
    final response = await apiClient.updateBirthday(request);
    _handleResponse(response);
    return response.result!.birthday;
  }

  @override
  Future<String> updatePassword(String currentPassword, String newPassword,
      String newPasswordConfirm) async {
    final request = UpdatePasswordRequest(
      currentPassword: currentPassword,
      newPassword: newPassword,
      newPasswordConfirm: newPasswordConfirm,
    );
    final response = await apiClient.updatePassword(request);
    _handleResponse(response);
    return response.result!;
  }

  @override
  Future<String> updateProfileImage(File profileImage) async {
    final response = await apiClient.updateProfileImage(profileImage);
    _handleResponse(response);
    return response.result!;
  }

  @override
  Future<String> sendEmailCode(String email) async {
    final request = SendEmailCodeRequest(email: email);
    final response = await apiClient.sendEmailCode(request);
    _handleResponse(response);
    return response.result!.code; // 반환값은 인증 코드
  }

  @override
  Future<String> verifyEmailCode(String email, String code) async {
    final request = VerifyEmailCodeRequest(email: email, code: code);
    final response = await apiClient.verifyEmailCode(request);
    _handleResponse(response);
    return response.result!; // "이메일 변경 성공" 반환
  }

  void _handleResponse(ApiResponse response) {
    if (response.code != 'COMMON200') {
      throw Exception('${response.code}: ${response.message}');
    }
  }
}

@riverpod
MembersRepository membersRepository(MembersRepositoryRef ref) {
  final apiClient = ref.watch(apiClientProvider);
  return MembersRepositoryImpl(apiClient);
}
