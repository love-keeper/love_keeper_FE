// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_item_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CalendarItemResponseImpl _$$CalendarItemResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$CalendarItemResponseImpl(
      date: json['date'] as String,
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$$CalendarItemResponseImplToJson(
        _$CalendarItemResponseImpl instance) =>
    <String, dynamic>{
      'date': instance.date,
      'count': instance.count,
    };
