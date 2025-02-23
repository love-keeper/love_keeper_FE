import 'package:freezed_annotation/freezed_annotation.dart';

part 'calendar_item_response.freezed.dart';
part 'calendar_item_response.g.dart';

@freezed
class CalendarItemResponse with _$CalendarItemResponse {
  const factory CalendarItemResponse({
    required String date,
    required int count,
  }) = _CalendarItemResponse;

  factory CalendarItemResponse.fromJson(Map<String, dynamic> json) =>
      _$CalendarItemResponseFromJson(json);
}
