import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../network/client/api_client.dart'; // ApiClient 임포트 추가

part 'dio_module.g.dart';

@Riverpod(keepAlive: true)
Dio dio(DioRef ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://lovekeeper.site/api',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
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
              final retryResponse =
                  await dio.fetch<Response<dynamic>>(options); // 타입 명시
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
  return ApiClient(dio); // ApiClient 생성자 호출
}
