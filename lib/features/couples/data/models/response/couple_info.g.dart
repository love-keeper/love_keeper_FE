// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'couple_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CoupleInfoImpl _$$CoupleInfoImplFromJson(Map<String, dynamic> json) =>
    _$CoupleInfoImpl(
      coupleId: (json['coupleId'] as num).toInt(),
      partnerNickname: json['partnerNickname'] as String,
      myProfileImageUrl: json['myProfileImageUrl'] as String? ?? null,
      partnerProfileImageUrl: json['partnerProfileImageUrl'] as String? ?? null,
      startedAt: json['startedAt'] as String,
      days: (json['days'] as num).toInt(),
    );

Map<String, dynamic> _$$CoupleInfoImplToJson(_$CoupleInfoImpl instance) =>
    <String, dynamic>{
      'coupleId': instance.coupleId,
      'partnerNickname': instance.partnerNickname,
      'myProfileImageUrl': instance.myProfileImageUrl,
      'partnerProfileImageUrl': instance.partnerProfileImageUrl,
      'startedAt': instance.startedAt,
      'days': instance.days,
    };
