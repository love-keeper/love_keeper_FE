import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:love_keeper/core/network/client/api_client.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  // Dio 설정 및 ApiClient 생성
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://lovekeeper.site', // 실제 API 기본 URL로 변경
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ),
  );

  return ApiClient(dio);
});
