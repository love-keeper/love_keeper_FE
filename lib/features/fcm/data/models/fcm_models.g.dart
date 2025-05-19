// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fcm_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$$FCMTokenRequestImplImpl _$$$FCMTokenRequestImplImplFromJson(
        Map<String, dynamic> json) =>
    _$$FCMTokenRequestImplImpl(
      token: json['token'] as String,
    );

Map<String, dynamic> _$$$FCMTokenRequestImplImplToJson(
        _$$FCMTokenRequestImplImpl instance) =>
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
      read: json['read'] as bool,
      data: json['data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$PushNotificationResponseImplToJson(
        _$PushNotificationResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'relativeTime': instance.relativeTime,
      'read': instance.read,
      'data': instance.data,
    };
