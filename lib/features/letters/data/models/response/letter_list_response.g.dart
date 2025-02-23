// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'letter_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LetterListResponseImpl _$$LetterListResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$LetterListResponseImpl(
      letterList: (json['letterList'] as List<dynamic>)
          .map((e) => LetterResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      isFirst: json['isFirst'] as bool,
      isLast: json['isLast'] as bool,
      hasNext: json['hasNext'] as bool,
    );

Map<String, dynamic> _$$LetterListResponseImplToJson(
        _$LetterListResponseImpl instance) =>
    <String, dynamic>{
      'letterList': instance.letterList,
      'isFirst': instance.isFirst,
      'isLast': instance.isLast,
      'hasNext': instance.hasNext,
    };
