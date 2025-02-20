import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../features/auth/presentation/pages/login/email_login_page.dart';
import '../../../features/onborading/pages/login_page.dart';
import 'package:love_keeper_fe/features/onborading/pages/splash_screen.dart';
import 'route_names.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    initialLocation: '/splash',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      // Auth Routes
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: RouteNames.emailLogin,
        name: 'emailLogin',
        builder: (context, state) => const EmailLoginPage(),
      ),
      // TODO: 추가 라우트 설정
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('페이지를 찾을 수 없습니다: ${state.error}'),
      ),
    ),
  );
}
