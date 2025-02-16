// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SocialLoginRequestImpl _$$SocialLoginRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$SocialLoginRequestImpl(
      email: json['email'] as String,
      provider: json['provider'] as String,
      providerId: json['providerId'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SocialLoginRequestImplToJson(
        _$SocialLoginRequestImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'provider': instance.provider,
      'providerId': instance.providerId,
      'runtimeType': instance.$type,
    };

_$LocalLoginRequestImpl _$$LocalLoginRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$LocalLoginRequestImpl(
      email: json['email'] as String,
      password: json['password'] as String,
      provider: json['provider'] as String? ?? "local",
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$LocalLoginRequestImplToJson(
        _$LocalLoginRequestImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'provider': instance.provider,
      'runtimeType': instance.$type,
    };
