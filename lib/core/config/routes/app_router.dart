// import 'package:love_keeper_fe/features/auth/presentation/pages/login/login_page.dart';
// import 'package:love_keeper_fe/features/auth/presentation/pages/login/email_login_page.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper_fe/features/main/presentation/pages/dday_page.dart';
import 'package:love_keeper_fe/features/main/presentation/pages/main_page.dart';
import 'package:love_keeper_fe/features/main/presentation/pages/calendar_page.dart';
import 'package:love_keeper_fe/features/main/presentation/pages/notification_page.dart';
import 'package:love_keeper_fe/features/main/presentation/pages/storage_page.dart';
import 'package:love_keeper_fe/features/main/presentation/pages/detail_page.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'route_names.dart';
part 'app_router.g.dart';

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    // 초기 경로를 메인 페이지로 설정
    initialLocation: '/main',
    debugLogDiagnostics: true,
    redirect: (context, state) async {
      // 로그인, 온보딩 등 조건에 관계없이 항상 null을 반환하여 리다이렉트 없이 현재 경로를 유지합니다.
      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        redirect: (_, __) => Routes.home,
      ),
      // 아래 로그인, 온보딩 관련 라우트는 주석처리되어 있습니다.
      // GoRoute(
      //   path: Routes.login,
      //   name: RouteNames.login,
      //   builder: (context, state) => const LoginPage(),
      // ),
      // GoRoute(
      //   path: Routes.signup,
      //   name: RouteNames.signup,
      //   builder: (context, state) => const SignupPage(),
      // ),
      // GoRoute(
      //   path: Routes.forgotPassword,
      //   name: RouteNames.forgotPassword,
      //   builder: (context, state) => const ForgotPasswordPage(),
      // ),
      // GoRoute(
      //   path: Routes.onboarding,
      //   name: RouteNames.onboarding,
      //   builder: (context, state) => const OnboardingPage(),
      // ),
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
  );
}

class LoginPage {
  const LoginPage();
}
