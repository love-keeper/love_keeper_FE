// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CalendarResponseImpl _$$CalendarResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$CalendarResponseImpl(
      letters: (json['letters'] as List<dynamic>)
          .map((e) => CalendarItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      promises: (json['promises'] as List<dynamic>)
          .map((e) => CalendarItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$CalendarResponseImplToJson(
        _$CalendarResponseImpl instance) =>
    <String, dynamic>{
      'letters': instance.letters,
      'promises': instance.promises,
    };
