import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/config/routes/app_router.dart'; // 앱라우터 파일 경로에 맞게 수정

void main() {
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
    );
  }
}
