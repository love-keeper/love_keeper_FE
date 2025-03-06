import 'package:freezed_annotation/freezed_annotation.dart';
import 'calendar_item_response.dart';

part 'calendar_response.freezed.dart';
part 'calendar_response.g.dart';

@freezed
class CalendarResponse with _$CalendarResponse {
  const factory CalendarResponse({
    required List<CalendarItemResponse> letters,
    required List<CalendarItemResponse> promises,
    required int totalLetterCount,
    required int totalPromiseCount,
    required int dailyLetterCount,
    required int dailyPromiseCount,
  }) = _CalendarResponse;

  factory CalendarResponse.fromJson(Map<String, dynamic> json) =>
      _$CalendarResponseFromJson(json);
}
