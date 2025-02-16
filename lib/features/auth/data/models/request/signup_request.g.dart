// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SocialSignupRequestImpl _$$SocialSignupRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$SocialSignupRequestImpl(
      email: json['email'] as String,
      nickname: json['nickname'] as String,
      birthDate: json['birthDate'] as String,
      provider: json['provider'] as String,
      providerId: json['providerId'] as String,
      profileImage: json['profileImage'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SocialSignupRequestImplToJson(
        _$SocialSignupRequestImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'nickname': instance.nickname,
      'birthDate': instance.birthDate,
      'provider': instance.provider,
      'providerId': instance.providerId,
      'profileImage': instance.profileImage,
      'runtimeType': instance.$type,
    };

_$LocalSignupRequestImpl _$$LocalSignupRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$LocalSignupRequestImpl(
      email: json['email'] as String,
      password: json['password'] as String,
      nickname: json['nickname'] as String,
      birthDate: json['birthDate'] as String,
      provider: json['provider'] as String? ?? "local",
      profileImage: json['profileImage'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$LocalSignupRequestImplToJson(
        _$LocalSignupRequestImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'nickname': instance.nickname,
      'birthDate': instance.birthDate,
      'provider': instance.provider,
      'profileImage': instance.profileImage,
      'runtimeType': instance.$type,
    };
