// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginResponseImpl _$$LoginResponseImplFromJson(Map<String, dynamic> json) =>
    _$LoginResponseImpl(
      memberId: (json['memberId'] as num).toInt(),
      email: json['email'] as String,
      role: json['role'] as String,
      social: json['social'] as bool,
    );

Map<String, dynamic> _$$LoginResponseImplToJson(_$LoginResponseImpl instance) =>
    <String, dynamic>{
      'memberId': instance.memberId,
      'email': instance.email,
      'role': instance.role,
      'social': instance.social,
    };
