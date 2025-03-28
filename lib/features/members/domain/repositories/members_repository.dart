import 'dart:io';
import 'package:love_keeper/features/members/domain/entities/member_info.dart'; // MemberInfo 임포트

abstract class MembersRepository {
  Future<MemberInfo> getMemberInfo(); // 추가
  Future<String> updateNickname(String nickname);
  Future<String> updateBirthday(String birthday);
  Future<String> updatePassword(
    String currentPassword,
    String newPassword,
    String newPasswordConfirm,
  );
  Future<String> updateProfileImage(File? profileImage);
  Future<String> sendEmailCode(String email);
  Future<String> verifyEmailCode(String email, String code);
}
