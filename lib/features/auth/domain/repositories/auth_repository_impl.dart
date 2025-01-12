import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

import 'package:love_keeper_fe/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:love_keeper_fe/features/auth/data/datasources/auth_remote_datasource.dart';

part 'auth_repository_impl.g.dart';

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  final remoteDataSource = ref.watch(authRemoteDataSourceProvider);
  final localDataSource = ref.watch(authLocalDataSourceProvider);
  return AuthRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
  );
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  const AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await _remoteDataSource.login(
        email: email,
        password: password,
      );
      
      // 로그인 성공 시 사용자 정보 로컬 저장
      await _localDataSource.saveUser(userModel);
      // TODO: 서버에서 받은 토큰 저장 구현 필요
      // await _localDataSource.saveToken(token);
      
      return Right(userModel.toEntity());
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          message: e.response?.data?['message'] ?? 'Login failed',
          code: e.response?.data?['code'],
        ),
      );
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> register({
    required String email,
    required String password,
    required String nickname,
  }) async {
    try {
      final userModel = await _remoteDataSource.register(
        email: email,
        password: password,
        nickname: nickname,
      );
      
      // 회원가입 성공 시 사용자 정보 로컬 저장
      await _localDataSource.saveUser(userModel);
      // TODO: 서버에서 받은 토큰 저장 구현 필요
      // await _localDataSource.saveToken(token);
      
      return Right(userModel.toEntity());
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          message: e.response?.data?['message'] ?? 'Registration failed',
          code: e.response?.data?['code'],
        ),
      );
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      // 로컬 데이터 삭제
      await Future.wait([
        _localDataSource.deleteUser(),
        _localDataSource.deleteToken(),
      ]);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    try {
      final userModel = await _localDataSource.getUser();
      if (userModel == null) {
        return const Right(null);
      }
      return Right(userModel.toEntity());
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<bool> isSignedIn() async {
    try {
      final token = await _localDataSource.getToken();
      return token != null;
    } catch (e) {
      return false;
    }
  }
}