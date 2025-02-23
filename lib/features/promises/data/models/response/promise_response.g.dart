// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promise_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PromiseResponseImpl _$$PromiseResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$PromiseResponseImpl(
      memberId: (json['memberId'] as num).toInt(),
      promiseId: (json['promiseId'] as num).toInt(),
      content: json['content'] as String,
      promisedAt: json['promisedAt'] as String,
    );

Map<String, dynamic> _$$PromiseResponseImplToJson(
        _$PromiseResponseImpl instance) =>
    <String, dynamic>{
      'memberId': instance.memberId,
      'promiseId': instance.promiseId,
      'content': instance.content,
      'promisedAt': instance.promisedAt,
    };
