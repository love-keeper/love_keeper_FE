import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'dio_client.g.dart';

@riverpod
Dio dioClient(DioClientRef ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://lovekeeper.site/api',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final prefs = await SharedPreferences.getInstance();
        final accessToken = prefs.getString('accessToken');
        if (accessToken != null && accessToken.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $accessToken';
        }
        return handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          try {
            // Call refresh token API
            final response = await Dio().post(
              'https://lovekeeper.site/api/auth/reissue',
              options: Options(headers: {
                'Cookie': error.response?.headers['set-cookie']?[0]
              }),
            );

            if (response.statusCode == 200) {
              final newAccessToken =
                  response.headers['authorization']?[0].split(' ')[1];

              if (newAccessToken != null) {
                // Retry original request with new token
                error.requestOptions.headers['Authorization'] =
                    'Bearer $newAccessToken';
                return handler.resolve(await Dio().fetch(error.requestOptions));
              }
            }
          } catch (e) {
            // Refresh token failed, redirect to login
            // TODO: Implement navigation to login screen using GoRouter
          }
        }
        return handler.next(error);
      },
    ),
  );

  return dio;
}

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;
}

@riverpod
RestClient apiClient(ApiClientRef ref) {
  final dio = ref.watch(dioClientProvider);
  return RestClient(dio);
}
