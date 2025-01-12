import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  /// 로그인을 수행합니다.
  /// 
  /// [email]과 [password]를 받아서 로그인을 시도합니다.
  /// 성공하면 [User] 정보를, 실패하면 [Failure]를 반환합니다.
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });

  /// 회원가입을 수행합니다.
  /// 
  /// [email], [password], [nickname]을 받아서 회원가입을 시도합니다.
  /// 성공하면 [User] 정보를, 실패하면 [Failure]를 반환합니다.
  Future<Either<Failure, User>> register({
    required String email,
    required String password,
    required String nickname,
  });

  /// 로그아웃을 수행합니다.
  /// 
  /// 로컬 저장소의 토큰과 사용자 정보를 삭제하고,
  /// 필요한 경우 서버에 로그아웃 요청을 보냅니다.
  Future<Either<Failure, void>> logout();
  
  /// 현재 로그인된 사용자 정보를 가져옵니다.
  /// 
  /// 로컬 저장소에서 사용자 정보를 가져오거나,
  /// 필요한 경우 서버에 요청하여 최신 정보를 가져옵니다.
  Future<Either<Failure, User?>> getCurrentUser();

  /// 자동 로그인 여부를 확인합니다.
  /// 
  /// 로컬 저장소에 유효한 토큰이 있는지 확인합니다.
  Future<bool> isSignedIn();
}