import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:love_keeper/core/config/routes/app_router.dart';
import 'package:love_keeper/features/fcm/presentation/viewmodels/fcm_viewmodel.dart';
import 'package:love_keeper/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// 백그라운드 메시지 핸들러
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("백그라운드 메시지 수신: ${message.messageId}");
}
void initUniLinks() async {

  final initialLink = await getInitialLink();
  if (initialLink != null) {
    handleDeepLink(Uri.parse(initialLink));
  }


  linkStream.listen((String? link) {
    if (link != null) {
      handleDeepLink(Uri.parse(link));
    }
  });
}

void handleDeepLink(Uri uri) {
  if (uri.path == '/password-change') {
    final email = uri.queryParameters['email'];
    final code = uri.queryParameters['code'];
    
      navigatorKey.currentState?.pushNamed(
        '/passwordEdit',
          arguments: {'email': email, 'code': code},
      );
  }
}

void main() async {
  // Flutter 바인딩 초기화
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ SharedPreferences 초기화 (한 번만 실행하고, 나중엔 주석 처리)
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();

  // KakaoSDK 초기화
  KakaoSdk.init(nativeAppKey: '4082411ebc9c7d9b7612cc9c7bee8da8');

  // Firebase 초기화 - 완전히 재작성된 부분
  FirebaseApp? app;
  try {
    if (Firebase.apps.isEmpty) {
      app = await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      print("Firebase 초기화 성공: ${app.name}");
    } else {
      app = Firebase.app();
      print("기존 Firebase 앱 사용: ${app.name}");
    }

    // 백그라운드 메시지 핸들러 등록
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  } catch (e) {
    print("Firebase 초기화 오류: $e");
    // 오류 발생 시 더 이상 진행하지 않음
  }

  // 네이버 SDK 초기화
  try {
    await FlutterNaverLogin.initSdk(
      clientId: 'FFquqzHeG8Tb2cfhf5QW',
      clientSecret: 'gBNxBTnHK1',
      clientName: 'Love Keeper',
    );
    print('Naver SDK initialized successfully');
  } catch (e) {
    print('Naver SDK initialization failed: $e');
  }

  // 앱 실행
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    // FCM 초기화 - 한 번만 실행되도록 보장
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(fCMViewModelProvider.notifier).initializeFCM();
    });

    return MaterialApp.router(
      title: 'Love Keeper',
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Pretendard'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ko', 'KR')],
    );
  }
}

/*import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:love_keeper/core/config/routes/app_router.dart';
import 'package:love_keeper/features/fcm/presentation/viewmodels/fcm_viewmodel.dart';
import 'package:love_keeper/firebase_options.dart';

// 백그라운드 메시지 핸들러
@pragma('vm:entry-point') // 중요: Flutter 엔진이 이 함수를 보존하도록 함
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // 백그라운드 핸들러에서는 Firebase를 다시 초기화하지 않음
  // 단순히 메시지 처리만 수행
  print("백그라운드 메시지 수신: ${message.messageId}");
}

// Firebase 초기화 함수
Future<void> initializeFirebase() async {
  try {
    // 이미 초기화된 앱이 있는지 확인
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      print("Firebase 초기화 성공");
    } else {
      Firebase.app(); // 기존 앱 인스턴스 가져오기
      print("Firebase 이미 초기화됨");
    }

    // 백그라운드 메시지 핸들러 등록
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  } catch (e) {
    print("Firebase 초기화 오류: $e");
  }
}

void main() async {
  // Flutter 바인딩 초기화
  WidgetsFlutterBinding.ensureInitialized();

  // KakaoSDK 초기화
  KakaoSdk.init(nativeAppKey: '4082411ebc9c7d9b7612cc9c7bee8da8');

  // Firebase 초기화
  await Firebase.initializeApp();

  // 네이버 SDK 초기화
  try {
    await FlutterNaverLogin.initSdk(
      clientId: 'FFquqzHeG8Tb2cfhf5QW',
      clientSecret: 'gBNxBTnHK1',
      clientName: 'Love Keeper',
    );
    print('Naver SDK initialized successfully');
  } catch (e) {
    print('Naver SDK initialization failed: $e');
  }

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // 앱 실행
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    // FCM 초기화 (권한 요청 및 리스너 설정만)
    // 첫 빌드 후에만 실행되도록 설정
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(fCMViewModelProvider.notifier).initializeFCM();
    });

    return MaterialApp.router(
      title: 'Love Keeper',
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Pretendard'),

      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ko', 'KR')],
    );
  }
}
*/
