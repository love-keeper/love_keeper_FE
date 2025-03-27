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

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print("백그라운드 메시지 수신: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  KakaoSdk.init(nativeAppKey: '4082411ebc9c7d9b7612cc9c7bee8da8');

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

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    // FCM 초기화 (권한 요청 및 리스너 설정만)
    ref.read(fCMViewModelProvider.notifier).initializeFCM();

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
