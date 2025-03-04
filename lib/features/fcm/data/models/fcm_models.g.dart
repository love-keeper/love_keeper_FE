// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fcm_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FCMTokenRequestImpl _$$FCMTokenRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$FCMTokenRequestImpl(
      token: json['token'] as String,
    );

Map<String, dynamic> _$$FCMTokenRequestImplToJson(
        _$FCMTokenRequestImpl instance) =>
    <String, dynamic>{
      'token': instance.token,
    };

_$PushNotificationResponseImpl _$$PushNotificationResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$PushNotificationResponseImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      body: json['body'] as String,
      relativeTime: json['relativeTime'] as String,
    );

Map<String, dynamic> _$$PushNotificationResponseImplToJson(
        _$PushNotificationResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'relativeTime': instance.relativeTime,
    };
