// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'letter_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LetterResponseImpl _$$LetterResponseImplFromJson(Map<String, dynamic> json) =>
    _$LetterResponseImpl(
      senderNickname: json['senderNickname'] as String,
      receiverNickname: json['receiverNickname'] as String,
      content: json['content'] as String,
      sentDate: json['sentDate'] as String,
    );

Map<String, dynamic> _$$LetterResponseImplToJson(
        _$LetterResponseImpl instance) =>
    <String, dynamic>{
      'senderNickname': instance.senderNickname,
      'receiverNickname': instance.receiverNickname,
      'content': instance.content,
      'sentDate': instance.sentDate,
    };
