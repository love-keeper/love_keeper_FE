// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promise_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PromiseListResponseImpl _$$PromiseListResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$PromiseListResponseImpl(
      promiseList: (json['promiseList'] as List<dynamic>)
          .map((e) => PromiseResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      isFirst: json['isFirst'] as bool,
      isLast: json['isLast'] as bool,
      hasNext: json['hasNext'] as bool,
    );

Map<String, dynamic> _$$PromiseListResponseImplToJson(
        _$PromiseListResponseImpl instance) =>
    <String, dynamic>{
      'promiseList': instance.promiseList,
      'isFirst': instance.isFirst,
      'isLast': instance.isLast,
      'hasNext': instance.hasNext,
    };
