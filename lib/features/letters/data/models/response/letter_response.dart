import 'package:freezed_annotation/freezed_annotation.dart';

part 'letter_response.freezed.dart';
part 'letter_response.g.dart';

@freezed
class LetterResponse with _$LetterResponse {
  const factory LetterResponse({
    required String senderNickname,
    required String receiverNickname,
    required String content,
  }) = _LetterResponse;

  factory LetterResponse.fromJson(Map<String, dynamic> json) =>
      _$LetterResponseFromJson(json);
}
