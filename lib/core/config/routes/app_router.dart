import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper_fe/features/main/presentation/pages/dday_page.dart';
import 'package:love_keeper_fe/features/main/presentation/pages/notification_page.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:love_keeper_fe/features/auth/presentation/pages/login/login_page.dart';
import 'package:love_keeper_fe/features/auth/presentation/pages/login/email_login_page.dart';
import 'package:love_keeper_fe/features/main/presentation/pages/main_page.dart';
import 'package:love_keeper_fe/features/main/presentation/pages/calendar_page.dart';
import 'package:love_keeper_fe/features/main/presentation/pages/storage_page.dart';
import 'package:love_keeper_fe/features/main/presentation/pages/detail_page.dart';
import 'route_names.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    // 초기 경로를 메인 페이지로 설정
    initialLocation: '/main',
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
      // Main Page Route
      GoRoute(
        path: '/main',
        name: 'main',
        builder: (context, state) {
          final initialIndex =
              int.tryParse(state.uri.queryParameters['initialIndex'] ?? '0') ??
                  0;
          return MainPage(initialIndex: initialIndex);
        },
      ),
      // Calendar Page Route
      GoRoute(
        path: '/calendar',
        name: 'calendar',
        builder: (context, state) => const CalendarPage(),
      ),
      // Storage Page Route
      GoRoute(
        path: '/storage',
        name: 'storage',
        builder: (context, state) {
          final initialTab =
              int.tryParse(state.uri.queryParameters['initialTab'] ?? '0') ?? 0;
          return StoragePage(initialTab: initialTab);
        },
      ),
      // Detail Page Route
      GoRoute(
        path: '/detail/:type/:month/:day',
        name: 'detail',
        builder: (context, state) {
          final type = state.pathParameters['type']!;
          final month = int.parse(state.pathParameters['month']!);
          final day = int.parse(state.pathParameters['day']!);
          // 연도는 현재 연도로 가정합니다.
          final selectedDay = DateTime(DateTime.now().year, month, day);
          return DetailPage(
            selectedDay: selectedDay,
            type: type,
          );
        },
      ),
      GoRoute(
        path: '/notification',
        name: 'notification',
        builder: (context, state) => const NotificationPage(),
      ),
      GoRoute(
        path: '/dday',
        name: 'dday',
        builder: (context, state) => const DdayPage(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('페이지를 찾을 수 없습니다: ${state.error}'),
      ),
    ),
  );
}
