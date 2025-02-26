import 'package:freezed_annotation/freezed_annotation.dart';

part 'password_reset_request.freezed.dart';
part 'password_reset_request.g.dart';

@freezed
class PasswordResetRequest with _$PasswordResetRequest {
  const factory PasswordResetRequest({
    required String email,
    required String password,
    required String passwordConfirm,
  }) = _PasswordResetRequest;

  factory PasswordResetRequest.fromJson(Map<String, dynamic> json) =>
      _$PasswordResetRequestFromJson(json);
}
