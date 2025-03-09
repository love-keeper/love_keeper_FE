// 파이어베이스 초기화가 계속 겹쳐서 만든 파일
// 메인 코드로 ㄱㄱ
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

class FirebaseInitializer {
  static Future<FirebaseApp>? _initialization;

  static Future<void> initialize() async {
    // 이미 초기화된 앱이 있다면 그냥 반환합니다.
    if (Firebase.apps.isNotEmpty) return;

    // _initialization이 null이면 초기화를 시도합니다.
    if (_initialization == null) {
      _initialization = Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ).catchError((error) {
        if (error is FirebaseException && error.code == 'duplicate-app') {
          // duplicate-app 오류가 발생하면 이미 초기화된 앱을 반환
          return Firebase.app();
        }
        throw error;
      });
    }
    try {
      await _initialization;
    } catch (error) {
      if (error is FirebaseException && error.code == 'duplicate-app') {
        // duplicate-app 오류는 무시하고 반환합니다.
        return;
      } else {
        rethrow;
      }
    }
  }
}
