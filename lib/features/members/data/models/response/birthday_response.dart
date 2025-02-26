import 'package:freezed_annotation/freezed_annotation.dart';

part 'birthday_response.freezed.dart';
part 'birthday_response.g.dart';

@freezed
class BirthdayResponse with _$BirthdayResponse {
  const factory BirthdayResponse({
    required String birthday,
  }) = _BirthdayResponse;

  factory BirthdayResponse.fromJson(Map<String, dynamic> json) =>
      _$BirthdayResponseFromJson(json);
}
