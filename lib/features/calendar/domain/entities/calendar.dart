import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:love_keeper_fe/features/calendar/data/models/response/calendar_item_response.dart';
import 'package:love_keeper_fe/features/calendar/data/models/response/calendar_response.dart';

part 'calendar.freezed.dart';

@freezed
class Calendar with _$Calendar {
  const factory Calendar({
    required List<CalendarItemResponse> letters,
    required List<CalendarItemResponse> promises,
    required int totalLetterCount,
    required int totalPromiseCount,
    required int dailyLetterCount,
    required int dailyPromiseCount,
  }) = _Calendar;

  factory Calendar.fromResponse(CalendarResponse response) => Calendar(
        letters: response.letters,
        promises: response.promises,
        totalLetterCount: response.totalLetterCount,
        totalPromiseCount: response.totalPromiseCount,
        dailyLetterCount: response.dailyLetterCount,
        dailyPromiseCount: response.dailyPromiseCount,
      );
}
