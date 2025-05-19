import 'dart:io';
import 'package:love_keeper/features/members/domain/entities/member_info.dart'; // MemberInfo 임포트

abstract class MembersRepository {
  Future<MemberInfo> getMemberInfo(); // 추가
  Future<String> deleteMember();
  Future<String> updateNickname(String nickname);
  Future<String> updateBirthday(String birthday);

  // 비밀번호 업데이트 메서드 시그니처만 정의 (구현 없음)
  Future<String> updatePassword(
    String currentPassword,
    String newPassword,
    String newPasswordConfirm,
  );

  Future<String> updateProfileImage(File? profileImage);
  Future<String> sendEmailCode(String email);
  Future<String> verifyEmailCode(String email, String code);
}
