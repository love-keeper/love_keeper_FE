import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../models/api_response.dart';
import '../../../features/auth/data/models/request/login_request.dart';
import '../../../features/auth/data/models/request/password_reset_request.dart';
import '../../../features/auth/data/models/request/send_code_request.dart';
import '../../../features/auth/data/models/request/signup_request.dart';
import '../../../features/auth/data/models/request/verify_code_request.dart';
import '../../../features/auth/data/models/response/auth_response.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST('/api/auth/reissue')
  Future<String> reissue(@Body() String refreshToken);

  @POST('/api/auth/signup')
  Future<ApiResponse<AuthResponse>> signup(@Body() SignupRequest request);

  @POST('/api/auth/login')
  Future<ApiResponse<AuthResponse>> login(@Body() LoginRequest request);

  @POST('/api/auth/send-code')
  Future<ApiResponse<String>> sendCode(@Body() SendCodeRequest request);

  @POST('/api/auth/verify-code')
  Future<ApiResponse<String>> verifyCode(@Body() VerifyCodeRequest request);

  @POST('/api/auth/logout')
  Future<ApiResponse<String>> logout();

  @POST('/api/auth/password/reset-request')
  Future<ApiResponse<String>> resetPasswordRequest(
      @Body() SendCodeRequest request);

  @POST('/api/auth/password/reset')
  Future<ApiResponse<String>> resetPassword(
      @Body() PasswordResetRequest request);
}
