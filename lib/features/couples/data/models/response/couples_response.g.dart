// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'couples_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoupleInfo _$CoupleInfoFromJson(Map<String, dynamic> json) => CoupleInfo(
      coupleId: (json['coupleId'] as num).toInt(),
      partnerNickname: json['partnerNickname'] as String,
      myProfileImageUrl: json['myProfileImageUrl'] as String?,
      partnerProfileImageUrl: json['partnerProfileImageUrl'] as String?,
      startedAt: json['startedAt'] as String,
      days: (json['days'] as num).toInt(),
    );

Map<String, dynamic> _$CoupleInfoToJson(CoupleInfo instance) =>
    <String, dynamic>{
      'coupleId': instance.coupleId,
      'partnerNickname': instance.partnerNickname,
      'myProfileImageUrl': instance.myProfileImageUrl,
      'partnerProfileImageUrl': instance.partnerProfileImageUrl,
      'startedAt': instance.startedAt,
      'days': instance.days,
    };
