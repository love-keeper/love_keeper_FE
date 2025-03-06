import 'package:freezed_annotation/freezed_annotation.dart';

part 'signup_request.freezed.dart';
part 'signup_request.g.dart';

@freezed
class SignupRequest with _$SignupRequest {
  const factory SignupRequest({
    required String email,
    required String nickname,
    required String birthDate,
    required String provider,
    required bool privacyPolicyAgreed,
    bool? marketingAgreed, // 필수 아님
    required bool termsOfServiceAgreed,
    String? password,
    String? providerId,
    String? profileImage,
  }) = _SignupRequest;

  factory SignupRequest.fromJson(Map<String, dynamic> json) =>
      _$SignupRequestFromJson(json);
}
