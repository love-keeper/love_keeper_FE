import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../../../../core/models/api_response.dart';
import '../models/request/login_request.dart';
import '../models/request/signup_request.dart';
import '../models/response/auth_response.dart';

part 'auth_remote_datasource.g.dart';

@RestApi()
abstract class AuthRemoteDataSource {
  factory AuthRemoteDataSource(Dio dio, {String baseUrl}) =
      _AuthRemoteDataSource;

  @POST('/api/auth/signup')
  Future<ApiResponse<AuthResponse>> signup(@Body() SignupRequest request);

  @POST('/api/auth/login')
  Future<ApiResponse<AuthResponse>> login(@Body() LoginRequest request);

  @POST('/api/auth/reissue')
  Future<String> reissue(@Body() String refreshToken);
}
