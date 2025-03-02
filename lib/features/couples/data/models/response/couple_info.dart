import 'package:freezed_annotation/freezed_annotation.dart';

part 'couple_info.freezed.dart';
part 'couple_info.g.dart';

@freezed
class CoupleInfo with _$CoupleInfo {
  const factory CoupleInfo({
    required int memberId,
    required String nickname,
    required String birthday,
    required String relationshipStartDate,
    required String email,
    @Default(null) String? profileImageUrl, // null을 기본값으로 설정
    required String coupleNickname,
  }) = _CoupleInfo;

  factory CoupleInfo.fromJson(Map<String, dynamic> json) =>
      _$CoupleInfoFromJson(json);
}
