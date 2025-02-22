import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/config/di/dio_module.dart';
import '../../../../core/models/api_response.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/request/login_request.dart';
import '../models/request/signup_request.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

part 'auth_repository_impl.g.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<User> signup({
    required String email,
    required String nickname,
    required String birthDate,
    required String provider,
    String? password,
    String? providerId,
    String? profileImage,
  }) async {
    final request = SignupRequest(
      email: email,
      nickname: nickname,
      birthDate: birthDate,
      provider: provider,
      password: password,
      providerId: providerId,
      profileImage: profileImage,
    );
    final response = await remoteDataSource.signup(request);
    _handleResponse(response);
    return User(
      memberId: response.result!.memberId,
      email: response.result!.email,
      role: response.result!.role,
      social: response.result!.social,
    );
  }

  @override
  Future<User> login({
    required String email,
    required String provider,
    String? password,
    String? providerId,
  }) async {
    final request = LoginRequest(
      email: email,
      provider: provider,
      password: password,
      providerId: providerId,
    );
    final response = await remoteDataSource.login(request);
    _handleResponse(response);
    return User(
      memberId: response.result!.memberId,
      email: response.result!.email,
      role: response.result!.role,
      social: response.result!.social,
    );
  }

  void _handleResponse(ApiResponse response) {
    if (!['COMMON200', 'COMMON201'].contains(response.code)) {
      throw Exception('${response.code}: ${response.message}');
    }
  }
}

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  final dio = ref.watch(dioProvider);
  return AuthRepositoryImpl(AuthRemoteDataSource(dio));
}
