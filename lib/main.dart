// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router/router.dart';

void main() {
  // 앱 시작 전 필요한 초기화를 수행합니다.
  WidgetsFlutterBinding.ensureInitialized();
  
  // ProviderScope로 앱을 감싸 Riverpod의 상태 관리를 활성화합니다.
  runApp(
    const ProviderScope(
      child: LoveKeeper(),
    ),
  );
}

class LoveKeeper extends ConsumerWidget {
  const LoveKeeper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 라우터 프로바이더를 구독하여 라우터 인스턴스를 가져옵니다.
    final router = ref.watch(routerProvider);
    
    return MaterialApp.router(
      title: 'Love Keeper',
      routerConfig: router,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        // Material 3 디자인을 활성화하여 최신 디자인 가이드라인을 따릅니다.
      ),
      debugShowCheckedModeBanner: false,  // 디버그 배너를 숨깁니다.
    );
  }
}