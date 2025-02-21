import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST('/api/auth/reissue')
  Future<String> reissue(@Body() String refreshToken);

  // 다른 API 엔드포인트도 여기에 추가 가능
}
