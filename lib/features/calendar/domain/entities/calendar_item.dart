import 'package:freezed_annotation/freezed_annotation.dart';

part 'calendar_item.freezed.dart';

@freezed
class CalendarItem with _$CalendarItem {
  const factory CalendarItem({
    required String date,
    required int count,
  }) = _CalendarItem;
}
