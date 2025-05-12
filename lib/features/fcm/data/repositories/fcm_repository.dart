import 'package:love_keeper/core/config/di/dio_module.dart';
import 'package:love_keeper/core/network/client/api_client.dart';
import 'package:love_keeper/core/models/api_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/fcm_models.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'fcm_repository.g.dart';

abstract class FCMRepository {
  Future<void> registerToken(String token);
  Future<NotificationListResponse> getPushNotifications({int? page, int? size});
  Future<ApiResponse<String>> markNotificationAsRead(int notificationId);
}

class FCMRepositoryImpl implements FCMRepository {
  final ApiClient _apiClient;
  final Dio _dio;

  FCMRepositoryImpl(this._apiClient) : _dio = Dio() {
    // Dio 설정 - Content-Type 문제 해결
    _dio.options.contentType = 'application/json';
  }

  @override
  Future<void> registerToken(String token) async {
    try {
      final request = FCMTokenRequest(token: token);

      // 대안 1: 직접 JSON 맵을 만들어 사용 (Content-Type 문제 해결)
      final jsonMap = {"token": token};

      // 액세스 토큰 가져오기
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');
      if (accessToken == null) {
        throw Exception('액세스 토큰이 없습니다');
      }

      // Dio로 직접 요청
      final dioResponse = await _dio.post(
        'http://love-keeper-prod-temp-env.eba-vmdes9x6.ap-northeast-2.elasticbeanstalk.com/api/fcm/token',
        data: jsonMap,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (dioResponse.statusCode != 200) {
        throw Exception('FCM 토큰 등록 실패: ${dioResponse.statusCode}');
      }

      // 원래 방식도 시도 (백업)
      try {
        final response = await _apiClient.registerFCMToken(request);
        _handleResponse(response);
      } catch (e) {
        print('원래 방식의 FCM 토큰 등록 실패 (무시됨): $e');
      }
    } catch (e) {
      print('FCM 토큰 등록 중 오류: $e');
      rethrow;
    }
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
        'http://love-keeper-prod-temp-env.eba-vmdes9x6.ap-northeast-2.elasticbeanstalk.com/api/fcm/notifications',
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

// Factory 프로바이더로 변경 (순환 참조 문제 해결)
@riverpod
FCMRepository fcmRepository(FcmRepositoryRef ref) {
  final apiClient = ref.watch(apiClientProvider);
  return FCMRepositoryImpl(apiClient);
}
