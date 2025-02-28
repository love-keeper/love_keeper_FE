import 'dart:io';

abstract class MembersRepository {
  Future<String> updateNickname(String nickname);
  Future<String> updateBirthday(String birthday);
  Future<String> updatePassword(
      String currentPassword, String newPassword, String newPasswordConfirm);
  Future<String> updateProfileImage(File profileImage);

  Future<String> sendEmailCode(String email); // 추가
  Future<String> verifyEmailCode(String email, String code); // 추가
}
