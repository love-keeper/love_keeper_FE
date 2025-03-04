import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:love_keeper_fe/firebase_options.dart';
import 'core/config/routes/app_router.dart'; // 앱라우터 파일 경로에 맞게 수정

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  KakaoSdk.init(
      nativeAppKey: '4082411ebc9c7d9b7612cc9c7bee8da8'); // 네이티브 앱 키 입력

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Firebase initialized successfully');
    // 알림 권한 요청
    final settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    print('Notification permission status: ${settings.authorizationStatus}');
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      final token = await FirebaseMessaging.instance.getToken();
      print('Initial FCM Token: $token');
    } else {
      print('Permission not granted');
    }
  } catch (e) {
    print('Firebase initialization or token fetch failed: $e');
  }

  await FirebaseMessaging.instance.requestPermission(); // 알림 권한 요청
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 앱라우터 프로바이더를 통해 라우터 인스턴스를 가져옴
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'My App',
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Pretendard',
      ),
      // 로케일 설정
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko', 'KR'),
      ],
    );
  }
}
