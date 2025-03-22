import 'package:love_keeper/core/config/di/dio_module.dart';
import 'package:love_keeper/core/network/client/api_client.dart';
import 'package:love_keeper/core/models/api_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/fcm_models.dart';

part 'fcm_repository.g.dart';

abstract class FCMRepository {
  Future<void> registerToken(String token);
  Future<void> removeToken(String token);
  Future<List<PushNotificationResponse>> getPushNotifications({
    int? page,
    int? size,
  });
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
  Future<void> removeToken(String token) async {
    final request = FCMTokenRequest(token: token);
    final response = await _apiClient.removeFCMToken(request);
    _handleResponse(response);
  }

  @override
  Future<List<PushNotificationResponse>> getPushNotifications({
    int? page,
    int? size,
  }) async {
    final response = await _apiClient.getPushNotifications(page, size);
    _handleResponse(response);
    return response.result ?? []; // null 안전성 추가
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
