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

extension CalendarExtension on Calendar {
  /// 편지와 약속 이벤트가 있는 날짜들의 리스트 반환
  List<DateTime> get eventDates {
    final dates = <DateTime>{};
    for (final letter in letters) {
      dates.add(DateTime.parse(letter.date)); // 날짜 포맷에 맞게 파싱 필요
    }
    for (final promise in promises) {
      dates.add(DateTime.parse(promise.date));
    }
    final list = dates.toList();
    list.sort();
    return list;
  }
}
