import 'package:freezed_annotation/freezed_annotation.dart';

part 'signup_request.freezed.dart';
part 'signup_request.g.dart';

@freezed
class SignupRequest with _$SignupRequest {
  const factory SignupRequest.social({
    required String email,
    required String nickname,
    required String birthDate,
    required String provider,
    required String providerId,
    String? profileImage,
  }) = SocialSignupRequest;

  const factory SignupRequest.local({
    required String email,
    required String password,
    required String nickname,
    required String birthDate,
    @Default("local") String provider,
    String? profileImage,
  }) = LocalSignupRequest;

  factory SignupRequest.fromJson(Map<String, dynamic> json) =>
      _$SignupRequestFromJson(json);
}
