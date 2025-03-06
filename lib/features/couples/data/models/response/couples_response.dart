import 'package:json_annotation/json_annotation.dart';

part 'couples_response.g.dart';

@JsonSerializable()
class CoupleInfo {
  final int coupleId;
  final String partnerNickname;
  final String? myProfileImageUrl;
  final String? partnerProfileImageUrl;
  final String startedAt;
  final int days;

  CoupleInfo({
    required this.coupleId,
    required this.partnerNickname,
    this.myProfileImageUrl,
    this.partnerProfileImageUrl,
    required this.startedAt,
    required this.days,
  });

  factory CoupleInfo.fromJson(Map<String, dynamic> json) =>
      _$CoupleInfoFromJson(json);
  Map<String, dynamic> toJson() => _$CoupleInfoToJson(this);
  // 강제로 변경 감지되도록 주석 추가
}
