// fcm_repository.dart 파일
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
    // Dio 기본 설정
    _dio.options.baseUrl = 'https://dev.lovekeeper.site/api';
    _dio.options.contentType = Headers.jsonContentType;
    _dio.options.responseType = ResponseType.json;
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);

    // Content-Type 디버깅용 인터셉터 추가
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('📤 Dio 요청: ${options.method} ${options.path}');
          print('📤 헤더: ${options.headers}');
          print('📤 데이터: ${options.data}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('📥 Dio 응답: ${response.statusCode}');
          print('📥 데이터: ${response.data}');
          return handler.next(response);
        },
        onError: (error, handler) {
          print('❌ Dio 오류: ${error.message}');
          if (error.response != null) {
            print('❌ 상태 코드: ${error.response?.statusCode}');
            print('❌ 응답 데이터: ${error.response?.data}');
          }
          return handler.next(error);
        },
      ),
    );
  }

  @override
  Future<void> registerToken(String token) async {
    try {
      // 액세스 토큰 가져오기
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');
      if (accessToken == null) {
        throw Exception('액세스 토큰이 없습니다');
      }

      // 1. 명시적으로 JSON 맵을 생성하여 사용
      final jsonMap = {"token": token};

      print('🔄 FCM 토큰 등록 시도: $token');
      print('🔄 액세스 토큰: $accessToken');

      // 2. 모든 헤더를 명시적으로 설정
      final response = await _dio.post(
        '/fcm/token',
        data: jsonMap,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode != 200) {
        throw Exception('FCM 토큰 등록 실패: ${response.statusCode}');
      }

      print('✅ FCM 토큰 등록 성공: $token');
      print('✅ 서버 응답: ${response.data}');
    } catch (e, stackTrace) {
      print('❌ FCM 토큰 등록 오류: $e');
      print('❌ 스택 트레이스: $stackTrace');
      rethrow;
    }
  }

  @override
  Future<NotificationListResponse> getPushNotifications({
    int? page,
    int? size,
  }) async {
    try {
      // 액세스 토큰 가져오기
      final accessToken = await _getAccessToken();

      final response = await _dio.get(
        '/fcm/notifications',
        queryParameters: {'page': page ?? 0, 'size': size ?? 10},
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;

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

            print('📋 알림 목록 가져오기 성공: ${notifications.length}개');

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

      print('⚠️ 알림 목록 가져오기: 응답 형식 불일치');
      return NotificationListResponse(
        notifications: [],
        page: page ?? 0,
        size: size ?? 10,
        hasNext: false,
        totalElementsFetched: 0,
      );
    } catch (e, stack) {
      print('❌ 알림 목록 가져오기 오류: $e');
      print('❌ 스택 트레이스: $stack');
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
    final token = prefs.getString('access_token') ?? '';
    if (token.isEmpty) {
      print('⚠️ 액세스 토큰이 없습니다');
    }
    return token;
  }

  @override
  Future<ApiResponse<String>> markNotificationAsRead(int notificationId) async {
    try {
      final accessToken = await _getAccessToken();

      final response = await _dio.put(
        '/fcm/notifications/$notificationId/read',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;
        return ApiResponse<String>(
          code: responseData['code'] as String,
          message: responseData['message'] as String,
          result: responseData['result'] as String?,
          timestamp: responseData['timestamp'] as String,
        );
      }

      throw Exception('알림 읽음 처리 실패: ${response.statusCode}');
    } catch (e) {
      print('❌ 알림 읽음 처리 오류: $e');
      rethrow;
    }
  }
}

// Factory 프로바이더
@riverpod
FCMRepository fcmRepository(FcmRepositoryRef ref) {
  final apiClient = ref.watch(apiClientProvider);
  return FCMRepositoryImpl(apiClient);
}
