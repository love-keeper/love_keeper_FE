// lib/features/members/domain/entities/member_info.dart
class MemberInfo {
  final int memberId;
  final String nickname;
  final String birthday;
  final String relationshipStartDate;
  final String email;
  final String? profileImageUrl;
  final String? coupleNickname;

  MemberInfo({
    required this.memberId,
    required this.nickname,
    required this.birthday,
    required this.relationshipStartDate,
    required this.email,
    this.profileImageUrl,
    this.coupleNickname,
  });

  factory MemberInfo.fromJson(Map<String, dynamic> json) {
    return MemberInfo(
      memberId: json['memberId'] as int? ?? 0,
      nickname: json['nickname']?.toString() ?? '',
      birthday: json['birthday']?.toString() ?? '',
      relationshipStartDate: json['relationshipStartDate']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      profileImageUrl: json['profileImageUrl']?.toString(),
      coupleNickname: json['coupleNickname']?.toString(),
    );
  }
}
