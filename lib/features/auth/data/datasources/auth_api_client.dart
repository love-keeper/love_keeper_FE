import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/models/api_response.dart';
import '../models/user_model.dart';

part 'auth_api_client.g.dart';

@RestApi()
abstract class AuthApiClient {
  factory AuthApiClient(Dio dio) = _AuthApiClient;

  @POST('/auth/login')
  Future<ApiResponse<UserModel>> login(@Body() Map<String, dynamic> body);

  @POST('/auth/signup')
  Future<ApiResponse<UserModel>> register(@Body() Map<String, dynamic> body);
}