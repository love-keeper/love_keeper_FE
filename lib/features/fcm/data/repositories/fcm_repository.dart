import 'package:love_keeper/core/config/di/dio_module.dart';
import 'package:love_keeper/core/network/client/api_client.dart';
import 'package:love_keeper/core/models/api_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/fcm_models.dart'; // NotificationListResponse를 import
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'fcm_repository.g.dart';

abstract class FCMRepository {
  Future<void> registerToken(String token);
  Future<NotificationListResponse> getPushNotifications({int? page, int? size});
  Future<ApiResponse<String>> markNotificationAsRead(
    int notificationId,
  ); // 반환 타입 변경
}

class FCMRepositoryImpl implements FCMRepository {
  final ApiClient _apiClient;

  FCMRepositoryImpl(this._apiClient);

  @override
  Future<void> registerToken(String token) async {
    final request = FCMTokenRequest(token: token);
    final response = await _apiClient.registerFCMToken(request);
    _handleResponse(response);
  }

  @override
  Future<NotificationListResponse> getPushNotifications({
    int? page,
    int? size,
  }) async {
    try {
      // 기존 API 호출을 유지
      final apiResponse = await _apiClient.getPushNotifications(
        page ?? 0,
        size ?? 10,
      );
      _handleResponse(apiResponse);

      // Dio를 통해 직접 가져온 원본 응답 데이터 접근
      final dio = Dio();
      final accessToken = await _getAccessToken();
      dio.options.headers['Authorization'] = 'Bearer $accessToken';

      final rawResponse = await dio.get(
        'https://lovekeeper.site/api/fcm/notifications',
        queryParameters: {'page': page ?? 0, 'size': size ?? 10},
      );

      if (rawResponse.statusCode == 200) {
        final responseData = rawResponse.data as Map<String, dynamic>;

        if (responseData['code'] == 'COMMON200' &&
            responseData['result'] is Map<String, dynamic>) {
          final resultMap = responseData['result'] as Map<String, dynamic>;

          if (resultMap.containsKey('notifications')) {
            final notificationsList =
                resultMap['notifications'] as List<dynamic>;
            final notifications =
                notificationsList
                    .map(
                      (item) => PushNotificationResponse.fromJson(
                        item as Map<String, dynamic>,
                      ),
                    )
                    .toList();

            print('직접 파싱한 알림 수: ${notifications.length}');

            return NotificationListResponse(
              notifications: notifications,
              page: resultMap['page'] as int,
              size: resultMap['size'] as int,
              hasNext: resultMap['hasNext'] as bool,
              totalElementsFetched: resultMap['totalElementsFetched'] as int,
            );
          }
        }
      }

      // 기본값 반환
      return NotificationListResponse(
        notifications: [],
        page: page ?? 0,
        size: size ?? 10,
        hasNext: false,
        totalElementsFetched: 0,
      );
    } catch (e, stack) {
      print('알림 가져오기 오류: $e');
      print('스택 트레이스: $stack');
      return NotificationListResponse(
        notifications: [],
        page: page ?? 0,
        size: size ?? 10,
        hasNext: false,
        totalElementsFetched: 0,
      );
    }
  }

  // 액세스 토큰 가져오기
  Future<String> _getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token') ?? '';
  }

  // 구현 클래스에서:
  @override
  Future<ApiResponse<String>> markNotificationAsRead(int notificationId) async {
    return await _apiClient.markNotificationAsRead(notificationId);
  }

  void _handleResponse(ApiResponse<dynamic> response) {
    if (!['COMMON200', 'COMMON201'].contains(response.code)) {
      throw Exception('${response.code}: ${response.message}');
    }
  }
}

@riverpod
FCMRepository fcmRepository(FcmRepositoryRef ref) {
  final apiClient = ref.watch(apiClientProvider);
  return FCMRepositoryImpl(apiClient);
}
