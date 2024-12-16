// lib/core/router/router.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper/features/auth/models/view_models/auth_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/views/login_screen.dart';
import '../../features/home/views/home_screen.dart';
import '../../features/splash/views/splash_screen.dart';

part 'router.g.dart';

// lib/core/router/router.dart
@riverpod
GoRouter router(Ref ref) {
  final authState = ref.watch(authViewModelProvider);

  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
    ],
    redirect: (context, state) {
      final currentPath = state.fullPath;
      
      // 스플래시 화면일 때는 리다이렉트하지 않습니다
      if (currentPath == '/') return null;

      final isAuthenticated = authState.isAuthenticated;
      final isLoggingIn = currentPath == '/login';

      // 인증되지 않은 경우의 처리
      if (!isAuthenticated) {
        // 로그인 화면이 아니면 로그인으로 리다이렉트
        return isLoggingIn ? null : '/login';
      }

      // 인증된 경우의 처리
      if (isLoggingIn) {
        // 이미 인증되었는데 로그인 화면이면 홈으로 리다이렉트
        return '/home';
      }

      return null;
    },
  );
}