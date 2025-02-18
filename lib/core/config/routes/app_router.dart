// lib/core/config/routes/app_router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'route_names.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    initialLocation: '/',
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
      GoRoute(
        path: Routes.login,
        name: RouteNames.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: Routes.signup,
        name: RouteNames.signup,
        builder: (context, state) => const SignupPage(),
      ),
      GoRoute(
        path: Routes.forgotPassword,
        name: RouteNames.forgotPassword,
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: Routes.home,
        name: RouteNames.home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: Routes.onboarding,
        name: RouteNames.onboarding,
        builder: (context, state) => const OnboardingPage(),
      ),
    ],
  );
}
