// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'draft_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DraftResponseImpl _$$DraftResponseImplFromJson(Map<String, dynamic> json) =>
    _$DraftResponseImpl(
      order: (json['order'] as num).toInt(),
      content: json['content'] as String,
      draftType: _draftTypeFromJson(json['draftType']),
    );

Map<String, dynamic> _$$DraftResponseImplToJson(_$DraftResponseImpl instance) =>
    <String, dynamic>{
      'order': instance.order,
      'content': instance.content,
      'draftType': _draftTypeToJson(instance.draftType),
    };
