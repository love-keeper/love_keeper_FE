// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PromiseImpl _$$PromiseImplFromJson(Map<String, dynamic> json) =>
    _$PromiseImpl(
      memberId: (json['memberId'] as num).toInt(),
      promiseId: (json['promiseId'] as num).toInt(),
      content: json['content'] as String,
      promisedAt: json['promisedAt'] as String,
    );

Map<String, dynamic> _$$PromiseImplToJson(_$PromiseImpl instance) =>
    <String, dynamic>{
      'memberId': instance.memberId,
      'promiseId': instance.promiseId,
      'content': instance.content,
      'promisedAt': instance.promisedAt,
    };
