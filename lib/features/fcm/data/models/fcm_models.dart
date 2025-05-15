// fcm_models.dart 파일
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fcm_models.freezed.dart';
part 'fcm_models.g.dart';

@freezed
class FCMTokenRequest with _$FCMTokenRequest {
  const factory FCMTokenRequest({required String token}) =
      _$FCMTokenRequestImpl;

  factory FCMTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$FCMTokenRequestFromJson(json);
}

// 모든 freezed 모델에 toMap 메서드 추가
extension FCMModelExtensions on FCMTokenRequest {
  Map<String, dynamic> toMap() {
    return {"token": token};
  }
}

@freezed
class PushNotificationResponse with _$PushNotificationResponse {
  const factory PushNotificationResponse({
    required int id,
    required String title,
    required String body,
    required String relativeTime,
    required bool read,
    Map<String, dynamic>? data,
  }) = _PushNotificationResponse;

  factory PushNotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$PushNotificationResponseFromJson(json);
}

class NotificationListResponse {
  final List<PushNotificationResponse> notifications;
  final int page;
  final int size;
  final bool hasNext;
  final int totalElementsFetched;

  NotificationListResponse({
    required this.notifications,
    required this.page,
    required this.size,
    required this.hasNext,
    required this.totalElementsFetched,
  });

  factory NotificationListResponse.fromJson(Map<String, dynamic> json) {
    return NotificationListResponse(
      notifications:
          (json['notifications'] as List)
              .map(
                (e) => PushNotificationResponse.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList(),
      page: json['page'] as int,
      size: json['size'] as int,
      hasNext: json['hasNext'] as bool,
      totalElementsFetched: json['totalElementsFetched'] as int,
    );
  }
}
