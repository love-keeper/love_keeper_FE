// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_draft_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreateDraftRequestImpl _$$CreateDraftRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$CreateDraftRequestImpl(
      draftOrder: (json['draftOrder'] as num).toInt(),
      content: json['content'] as String,
      draftType: $enumDecode(_$DraftTypeEnumMap, json['draftType']),
    );

Map<String, dynamic> _$$CreateDraftRequestImplToJson(
        _$CreateDraftRequestImpl instance) =>
    <String, dynamic>{
      'draftOrder': instance.draftOrder,
      'content': instance.content,
      'draftType': _$DraftTypeEnumMap[instance.draftType]!,
    };

const _$DraftTypeEnumMap = {
  DraftType.conciliation: 'CONCILIATION',
  DraftType.answer: 'ANSWER',
};
