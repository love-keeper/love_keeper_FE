import 'package:freezed_annotation/freezed_annotation.dart';

part 'fcm_models.freezed.dart';
part 'fcm_models.g.dart';

@freezed
class FCMTokenRequest with _$FCMTokenRequest {
  const factory FCMTokenRequest({
    required String token,
  }) = _FCMTokenRequest;

  factory FCMTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$FCMTokenRequestFromJson(json);
}

@freezed
class PushNotificationResponse with _$PushNotificationResponse {
  const factory PushNotificationResponse({
    required int id,
    required String title,
    required String body,
    required String relativeTime,
  }) = _PushNotificationResponse;

  factory PushNotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$PushNotificationResponseFromJson(json);
}
