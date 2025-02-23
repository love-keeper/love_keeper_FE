import 'package:freezed_annotation/freezed_annotation.dart';
import 'calendar_item.dart';

part 'calendar.freezed.dart';

@freezed
class Calendar with _$Calendar {
  const factory Calendar({
    required List<CalendarItem> letters,
    required List<CalendarItem> promises,
  }) = _Calendar;
}
