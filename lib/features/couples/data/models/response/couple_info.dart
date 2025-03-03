import 'package:freezed_annotation/freezed_annotation.dart';

part 'couple_info.freezed.dart';
part 'couple_info.g.dart';

@freezed
class CoupleInfo with _$CoupleInfo {
  const factory CoupleInfo({
    required int coupleId,
    required String partnerNickname,
    @Default(null) String? myProfileImageUrl,
    @Default(null) String? partnerProfileImageUrl,
    required String startedAt,
    required int days,
  }) = _CoupleInfo;

  factory CoupleInfo.fromJson(Map<String, dynamic> json) =>
      _$CoupleInfoFromJson(json);
}
