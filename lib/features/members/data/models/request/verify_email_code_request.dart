import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_email_code_request.freezed.dart';
part 'verify_email_code_request.g.dart';

@freezed
class VerifyEmailCodeRequest with _$VerifyEmailCodeRequest {
  const factory VerifyEmailCodeRequest({
    required String email,
    required String code,
  }) = _VerifyEmailCodeRequest;

  factory VerifyEmailCodeRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyEmailCodeRequestFromJson(json);
}
