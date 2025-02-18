//import 'package:love_keeper_fe/features/auth/presentation/pages/login/login_page.dart';
//import 'package:love_keeper_fe/features/auth/presentation/pages/login/email_login_page.dart';
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
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('accessToken');
      final isOnboarded = prefs.getBool('isOnboarded') ?? false;

      // Path that doesn't require authentication
      final isAuthPath = state.matchedLocation == Routes.login ||
          state.matchedLocation == Routes.signup ||
          state.matchedLocation == Routes.forgotPassword;

      // First time user: redirect to onboarding
      if (!isOnboarded &&
          !isAuthPath &&
          state.matchedLocation != Routes.onboarding) {
        return Routes.onboarding;
      }

      // Logged out: redirect to login except for auth paths
      if (accessToken == null &&
          !isAuthPath &&
          state.matchedLocation != Routes.onboarding) {
        return Routes.login;
      }

      // Logged in: redirect away from auth paths
      if (accessToken != null && isAuthPath) {
        return Routes.home;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        redirect: (_, __) => Routes.home,
      ),
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
      //   path: Routes.home,
      //   name: RouteNames.home,
      //   builder: (context, state) => const HomePage(),
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
