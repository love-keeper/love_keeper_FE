import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../features/onboarding/pages/splash_screen.dart';
import '../../../features/onboarding/pages/login_page.dart'; //수정필요

// Login 관련 페이지
import '../../../features/auth/start_login_page/presentation/pages/email_login_page.dart';
import '../../../features/auth/start_login_page/presentation/pages/pw_finding_page.dart';
import '../../../features/auth/start_login_page/presentation/pages/password_edit_page.dart';
import '../../../features/auth/start_login_page/presentation/pages/signup_page.dart';
import '../../../features/auth/start_login_page/presentation/pages/email_password_input_page.dart';
import '../../../features/auth/start_login_page/presentation/pages/profile_registration_page.dart';
import '../../../features/auth/start_login_page/presentation/pages/code_connect_page.dart';
//main 관련 페이지
import 'package:love_keeper_fe/features/main/presentation/pages/main_page.dart';
import 'package:love_keeper_fe/features/main/presentation/pages/calendar_page.dart';
import 'package:love_keeper_fe/features/main/presentation/pages/storage_page.dart';
import 'package:love_keeper_fe/features/main/presentation/pages/detail_page.dart';
import 'package:love_keeper_fe/features/main/presentation/pages/dday_page.dart';
// Letter 관련 페이지
//import '../../../features//auth/letter/presentation/pages/letter_page.dart';
import '../../../features/auth/letter/presentation/pages/send_letter_screen.dart';
import '../../../features/auth/letter/presentation/pages/send_letter_page.dart';
import '../../../features/auth/letter/presentation/pages/reply_letter_page.dart';
//My_page 관련 페이지
import '../../../features/auth/my_page/presentation/pages/my_page.dart';
import '../../../features/auth/my_page/presentation/pages/settings_page.dart';
import '../../../features/auth/my_page/presentation/pages/disconnect_page.dart';
import '../../../features/auth/my_page/presentation/pages/disconnected_screen.dart';
import '../../../features/auth/my_page/presentation/pages/nickname_edit_page.dart';
import '../../../features/auth/my_page/presentation/pages/Birthdate_edit_page.dart';
import '../../../features/auth/my_page/presentation/pages/relationship_start_edit_page.dart';
import '../../../features/auth/my_page/presentation/pages/email_edit_page.dart';
import '../../../features/auth/my_page/presentation/pages/new_email_input_page.dart';
import '../../../features/auth/my_page/presentation/pages/new_email_ certification.dart';
import '../../../features/auth/my_page/presentation/pages/my_password_edit_page.dart';

import 'route_names.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    initialLocation: RouteNames.mainPage,
    debugLogDiagnostics: true,
    routes: [
//onboarding Page Route
      GoRoute(
        path: RouteNames.onboarding,
        name: ' onboarding',
        builder: (context, state) => const LoginPage(), //수정필요
      ),
      GoRoute(
        path: RouteNames.splashScreen,
        name: ' splashScreen',
        builder: (context, state) => const SplashScreen(),
      ),
//loginPage Route
      GoRoute(
        path: RouteNames.emailLoginPage,
        name: ' emailLoginPage',
        builder: (context, state) => const EmailLoginPage(),
      ),
      GoRoute(
        path: RouteNames.pwFindingPage,
        name: ' pwFindingPage',
        builder: (context, state) => const PwFindingPage(),
      ),
      GoRoute(
        path: RouteNames.passwordEditPage,
        name: ' passwordEditPage',
        builder: (context, state) => const PasswordEditPage(),
      ),

      GoRoute(
        path: RouteNames.signupPage,
        name: ' signupPage',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final String email = (extra['email'] as String?) ?? "";

          return SignupPage(email: email);
        },
      ),

      GoRoute(
        path: RouteNames.emailPasswordInputPage,
        name: ' emailPasswordInputPage',
        builder: (context, state) => const EmailPasswordInputPage(),
      ),
      GoRoute(
        path: RouteNames.profileRegistrationPage,
        name: ' profileRegistration',
        builder: (context, state) => const ProfileRegistrationPage(),
      ),
      GoRoute(
        path: RouteNames.codeConnectPage,
        name: ' codeConnect',
        builder: (context, state) => const CodeConnectPage(),
      ),

      // Main Page Route
      GoRoute(
        path: RouteNames.mainPage,
        name: ' mainPage',
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
        builder: (context, state) => const StoragePage(),
      ),
      // D-day Page Route
      GoRoute(
        path: '/dday',
        name: 'dday',
        builder: (context, state) => const DdayPage(),
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
//letterPage Route

      GoRoute(
        path: RouteNames.sendLetter,
        name: 'sendLetter',
        builder: (context, state) => const SendLetterPage(),
      ),

      GoRoute(
        path: RouteNames.replyLetter,
        name: 'replyLetter',
        builder: (context, state) => const ReplyLetterPage(),
      ),

      GoRoute(
        path: RouteNames.sendLetterScreen,
        name: 'sendLetterScreen',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final letterData = extra['letterData'] as Map<String, dynamic>? ?? {};
          final Future<void> Function() onComplete =
              extra['onComplete'] as Future<void> Function()? ?? () async {};
          return SendLetterScreen(
            receiverName: (letterData['receiver'] as String?) ?? "상대방",
            onComplete: onComplete,
          );
        },
      ),
      // MyPage Route
      GoRoute(
        path: RouteNames.myPage,
        name: 'myPage',
        builder: (context, state) => const MyPage(),
      ),
      GoRoute(
        path: RouteNames.settingsPage,
        name: 'settingsPage',
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: RouteNames.disconnectPage,
        name: 'disconnectPage',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          return DisconnectPage(
            appBarTitle: (extra['appBarTitle'] as String?) ?? "연결끊기",
            richTextPrefix: (extra['richTextPrefix'] as String?) ?? "상대방",
            richTextSuffix:
                (extra['richTextSuffix'] as String?) ?? " 님과\n연결을 끊으시겠어요?",
            imagePath: (extra['imagePath'] as String?) ??
                'assets/images/my_page/Img_Disconnect.png',
            imageWidth: (extra['imageWidth'] as double?) ?? 223.0,
            imageHeight: (extra['imageHeight'] as double?) ?? 176.0,
            bottomText: (extra['bottomText'] as String?) ??
                "기록된 데이터는 모두 삭제돼요.\n데이터는 30일 이내에 복구할 수 있어요.",
            actionButtonText: (extra['actionButtonText'] as String?) ?? "연결 끊기",
            gapBetweenImageAndText1:
                (extra['gapBetweenImageAndText1'] as double?) ?? 78,
            gapBetweenImageAndText2:
                (extra['gapBetweenImageAndText2'] as double?) ?? 69,
            dialogTitle: (extra['dialogTitle'] as String?) ?? '정말 연결을 끊으시겠어요?',
            dialogContent: (extra['dialogContent'] as String?) ??
                '연결 끊기 선택 시, 기록된 데이터는\n모두 삭제되며 복구할 수 없습니다.',
            dialogExitText: (extra['dialogExitText'] as String?) ?? '연결 끊기',
            dialogSaveText: (extra[' dialogSaveText'] as String?) ?? '돌아가기',
            onDialogExit: extra['onDialogExit'] as VoidCallback? ?? () {},
            onDialogSave: extra['onDialogSave'] as VoidCallback? ?? () {},
          );
        },
      ),
      GoRoute(
        path: RouteNames.disconnectedScreen,
        name: ' disconnectedScreen',
        builder: (context, state) => const DisconnectedScreen(),
      ),
      GoRoute(
        path: RouteNames.nicknameEditPage,
        name: ' nicknameEditPage',
        builder: (context, state) => const NicknameEditPage(),
      ),
      GoRoute(
        path: RouteNames.birthdateEditPage,
        name: ' birthdateEditPage',
        builder: (context, state) => const BirthdateEditPage(),
      ),
      GoRoute(
        path: RouteNames.relationshipStartEditPage,
        name: ' relationshipStartEditPage',
        builder: (context, state) => const RelationshipStartEditPage(),
      ),
      GoRoute(
        path: RouteNames.emailEditPage,
        name: ' emailEditPage',
        builder: (context, state) => const EmailEditPage(),
      ),
      GoRoute(
        path: RouteNames.newEmailInputPage,
        name: ' newEmailInputPage',
        builder: (context, state) => const NewEmailInputPage(),
      ),
      GoRoute(
        path: RouteNames.newEmailcertification,
        name: ' newEmailcertification',
        builder: (context, state) => const NewEmailcertification(),
      ), //
      GoRoute(
        path: RouteNames.myPasswordEditPage,
        name: ' myPasswordEditPage',
        builder: (context, state) => const MyPasswordEditPage(),
      ),
    ],
    errorPageBuilder: (context, state) => MaterialPage<void>(
      key: state.pageKey,
      child: Scaffold(
        body: Center(
          child: Text('페이지를 찾을 수 없습니다: ${state.error}'),
        ),
      ),
    ),
  );
}
