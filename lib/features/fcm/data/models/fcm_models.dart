import 'package:freezed_annotation/freezed_annotation.dart';

part 'fcm_models.freezed.dart';
part 'fcm_models.g.dart';

@freezed
class FCMTokenRequest with _$FCMTokenRequest {
  const factory FCMTokenRequest({required String token}) = _FCMTokenRequest;

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
    required bool read,
    Map<String, dynamic>? data,
  }) = _PushNotificationResponse;

  factory PushNotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$PushNotificationResponseFromJson(json);
}

// 일반 클래스로 변경
class NotificationsResponse {
  final List<PushNotificationResponse> notifications;
  final int page;
  final int size;
  final bool hasNext;
  final int totalElementsFetched;

  NotificationsResponse({
    required this.notifications,
    required this.page,
    required this.size,
    required this.hasNext,
    required this.totalElementsFetched,
  });

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) {
    return NotificationsResponse(
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

// 기존 NotificationListResponse 클래스는 유지
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
