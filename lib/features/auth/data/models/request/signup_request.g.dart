// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SignupRequestImpl _$$SignupRequestImplFromJson(Map<String, dynamic> json) =>
    _$SignupRequestImpl(
      email: json['email'] as String,
      nickname: json['nickname'] as String,
      birthDate: json['birthDate'] as String,
      provider: json['provider'] as String,
      privacyPolicyAgreed: json['privacyPolicyAgreed'] as bool,
      marketingAgreed: json['marketingAgreed'] as bool?,
      termsOfServiceAgreed: json['termsOfServiceAgreed'] as bool,
      password: json['password'] as String?,
      providerId: json['providerId'] as String?,
      profileImage: json['profileImage'] as String?,
    );

Map<String, dynamic> _$$SignupRequestImplToJson(_$SignupRequestImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'nickname': instance.nickname,
      'birthDate': instance.birthDate,
      'provider': instance.provider,
      'privacyPolicyAgreed': instance.privacyPolicyAgreed,
      'marketingAgreed': instance.marketingAgreed,
      'termsOfServiceAgreed': instance.termsOfServiceAgreed,
      'password': instance.password,
      'providerId': instance.providerId,
      'profileImage': instance.profileImage,
    };
