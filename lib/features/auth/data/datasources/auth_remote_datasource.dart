import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/network/dio_client.dart';
import '../models/user_model.dart';
import 'auth_api_client.dart';

part 'auth_remote_datasource.g.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({
    required String email,
    required String password,
  });

  Future<UserModel> register({
    required String email,
    required String password,
    required String nickname,
  });
}

@riverpod
AuthRemoteDataSource authRemoteDataSource(AuthRemoteDataSourceRef ref) {
  final dio = ref.watch(dioClientProvider);
  return AuthRemoteDataSourceImpl(AuthApiClient(dio));
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthApiClient _client;

  AuthRemoteDataSourceImpl(this._client);

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final response = await _client.login({
      'email': email,
      'password': password,
    });
    return response.data;
  }

  @override
  Future<UserModel> register({
    required String email,
    required String password,
    required String nickname,
  }) async {
    final response = await _client.register({
      'email': email,
      'password': password,
      'nickname': nickname,
    });
    return response.data;
  }
}