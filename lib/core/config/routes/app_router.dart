import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../features/auth/presentation/pages/login/email_login_page.dart';
import '../../../features/auth/presentation/pages/login/login_page.dart';
import 'route_names.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    initialLocation: RouteNames.onboarding,
    debugLogDiagnostics: true,
    routes: [
      // Auth Routes
      GoRoute(
        path: RouteNames.onboarding,
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