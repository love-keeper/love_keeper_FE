import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../features/auth/presentation/pages/login/email_login_page.dart';
import '../../../features/auth/presentation/pages/login/login_page.dart';
// Letter 관련 페이지
//import '../../../features//auth/letter/presentation/pages/letter_page.dart';
import '../../../features/auth/letter/presentation/pages/send_letter_screen.dart';
import '../../../features/auth/letter/presentation/pages/send_letter_page.dart';
import '../../../features/auth/letter/presentation/pages/reply_letter_page.dart';
import 'route_names.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    // 디버깅용으로 편지 작성 플로우가 먼저 보이도록 초기 경로 설정함.
    initialLocation: RouteNames.replyLetter,
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
      // Letter Routes
      /*GoRoute(
        path: RouteNames.letter,
        name: 'letter',
        builder: (context, state) => const LetterPage(),
      ),*/
      GoRoute(
        path: RouteNames.sendLetterScreen,
        name: 'sendLetterScreen',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final letterData = extra['letterData'] as Map<String, dynamic>? ?? {};
          // onComplete 콜백을 extra에서 받아옵니다.
          final Future<void> Function() onComplete =
              extra['onComplete'] as Future<void> Function()? ?? () async {};

          return SendLetterScreen(
            receiverName: letterData['receiver'] ?? "상대방",
            onComplete: onComplete,
          );
        },
      ),

      //화해요청편지
      GoRoute(
        path: RouteNames.sendLetter,
        name: 'sendLetter',
        builder: (context, state) => const SendLetterPage(),
      ),
      //답장편지
      GoRoute(
        path: RouteNames.replyLetter,
        name: 'replyLetter',
        builder: (context, state) => const ReplyLetterPage(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('페이지를 찾을 수 없습니다: ${state.error}'),
      ),
    ),
  );
}
