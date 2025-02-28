import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_email_code_response.freezed.dart';
part 'send_email_code_response.g.dart';

@freezed
class SendEmailCodeResponse with _$SendEmailCodeResponse {
  const factory SendEmailCodeResponse({
    required String code,
  }) = _SendEmailCodeResponse;

  factory SendEmailCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$SendEmailCodeResponseFromJson(json);
}
