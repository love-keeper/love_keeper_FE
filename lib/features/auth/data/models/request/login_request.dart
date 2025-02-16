import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_request.freezed.dart';
part 'login_request.g.dart';

@freezed
class LoginRequest with _$LoginRequest {
  const factory LoginRequest.social({
    required String email,
    required String provider,
    required String providerId,
  }) = SocialLoginRequest;

  const factory LoginRequest.local({
    required String email,
    required String password,
    @Default("local") String provider,
  }) = LocalLoginRequest;

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);
}
