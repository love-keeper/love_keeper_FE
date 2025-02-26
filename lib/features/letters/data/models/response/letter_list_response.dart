import 'package:freezed_annotation/freezed_annotation.dart';
import 'letter_response.dart';

part 'letter_list_response.freezed.dart';
part 'letter_list_response.g.dart';

@freezed
class LetterListResponse with _$LetterListResponse {
  const factory LetterListResponse({
    required List<LetterResponse> letterList,
    required bool isFirst,
    required bool isLast,
    required bool hasNext,
  }) = _LetterListResponse;

  factory LetterListResponse.fromJson(Map<String, dynamic> json) =>
      _$LetterListResponseFromJson(json);
}
