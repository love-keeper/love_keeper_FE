// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthResponseImpl _$$AuthResponseImplFromJson(Map<String, dynamic> json) =>
    _$AuthResponseImpl(
      memberId: (json['memberId'] as num).toInt(),
      email: json['email'] as String?,
      role: json['role'] as String?,
      social: json['social'] as bool?,
    );

Map<String, dynamic> _$$AuthResponseImplToJson(_$AuthResponseImpl instance) =>
    <String, dynamic>{
      'memberId': instance.memberId,
      'email': instance.email,
      'role': instance.role,
      'social': instance.social,
    };
