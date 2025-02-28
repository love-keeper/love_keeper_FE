import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_email_code_request.freezed.dart';
part 'send_email_code_request.g.dart';

@freezed
class SendEmailCodeRequest with _$SendEmailCodeRequest {
  const factory SendEmailCodeRequest({
    required String email,
  }) = _SendEmailCodeRequest;

  factory SendEmailCodeRequest.fromJson(Map<String, dynamic> json) =>
      _$SendEmailCodeRequestFromJson(json);
}
