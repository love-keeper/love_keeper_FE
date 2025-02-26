// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_password_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UpdatePasswordRequestImpl _$$UpdatePasswordRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$UpdatePasswordRequestImpl(
      currentPassword: json['currentPassword'] as String,
      newPassword: json['newPassword'] as String,
      newPasswordConfirm: json['newPasswordConfirm'] as String,
    );

Map<String, dynamic> _$$UpdatePasswordRequestImplToJson(
        _$UpdatePasswordRequestImpl instance) =>
    <String, dynamic>{
      'currentPassword': instance.currentPassword,
      'newPassword': instance.newPassword,
      'newPasswordConfirm': instance.newPasswordConfirm,
    };
