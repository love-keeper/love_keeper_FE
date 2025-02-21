import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../network/client/api_client.dart';

part 'dio_module.g.dart';

@Riverpod(keepAlive: true)
Dio dio(DioRef ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://lovekeeper.site',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      contentType: 'application/json', // 명시적으로 추가
      headers: {
        'Accept': 'application/json', // 서버 응답 타입도 명시
      },
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final prefs = await SharedPreferences.getInstance();
        final accessToken = prefs.getString('access_token');
        if (accessToken != null) {
          options.headers['Authorization'] = 'Bearer $accessToken';
        }
        // Content-Type 강제 설정 (필요 시)
        options.headers['Content-Type'] = 'application/json';
        handler.next(options);
      },
      onResponse: (response, handler) async {
        final refreshToken = response.headers['set-cookie']
            ?.firstWhere((cookie) => cookie.contains('refresh_token'),
                orElse: () => '')
            .split(';')
            .first
            .split('=')[1];
        if (refreshToken != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('refresh_token', refreshToken);
        }
        handler.next(response);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          final prefs = await SharedPreferences.getInstance();
          final refreshToken = prefs.getString('refresh_token');
          if (refreshToken != null) {
            try {
              final apiClient = ref.read(apiClientProvider);
              final newAccessToken = await apiClient.reissue(refreshToken);
              await prefs.setString('access_token', newAccessToken);
              final options = error.requestOptions;
              options.headers['Authorization'] = 'Bearer $newAccessToken';
              final retryResponse = await dio.fetch<Response<dynamic>>(options);
              handler.resolve(retryResponse);
            } catch (e) {
              handler.next(error);
            }
          } else {
            handler.next(error);
          }
        } else {
          handler.next(error);
        }
      },
    ),
  );

  return dio;
}

@Riverpod(keepAlive: true)
ApiClient apiClient(ApiClientRef ref) {
  final dio = ref.watch(dioProvider);
  return ApiClient(dio);
}
