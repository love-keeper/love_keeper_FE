// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'couple_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CoupleInfoImpl _$$CoupleInfoImplFromJson(Map<String, dynamic> json) =>
    _$CoupleInfoImpl(
      memberId: (json['memberId'] as num).toInt(),
      nickname: json['nickname'] as String,
      birthday: json['birthday'] as String,
      relationshipStartDate: json['relationshipStartDate'] as String,
      email: json['email'] as String,
      profileImageUrl: json['profileImageUrl'] as String? ?? null,
      coupleNickname: json['coupleNickname'] as String,
    );

Map<String, dynamic> _$$CoupleInfoImplToJson(_$CoupleInfoImpl instance) =>
    <String, dynamic>{
      'memberId': instance.memberId,
      'nickname': instance.nickname,
      'birthday': instance.birthday,
      'relationshipStartDate': instance.relationshipStartDate,
      'email': instance.email,
      'profileImageUrl': instance.profileImageUrl,
      'coupleNickname': instance.coupleNickname,
    };
