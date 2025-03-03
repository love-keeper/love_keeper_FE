import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper_fe/features/members/presentation/pages/birthdate_edit_page.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../features/onboarding/pages/splash_screen.dart';
import '../../../features/onboarding/pages/login_page.dart';
import '../../../features/auth/presentation/pages/email_login_page.dart';
import '../../../features/auth/presentation/pages/pw_finding_page.dart';
import '../../../features/auth/presentation/pages/password_edit_page.dart';
import '../../../features/auth/presentation/pages/signup_page.dart';
import '../../../features/auth/presentation/pages/email_password_input_page.dart';
import '../../../features/auth/presentation/pages/profile_registration_page.dart';
import '../../../features/couples/presentation/pages/code_connect_page.dart';
import '../../../features/main/presentation/pages/main_page.dart';
import '../../../features/main/presentation/pages/notification_page.dart';
import '../../../features/calendar/presentation/pages/calendar_page.dart';
import '../../../features/couples/presentation/pages/storage_page.dart';
import '../../../features/calendar/presentation/pages/detail_page.dart';
import '../../../features/couples/presentation/pages/dday_page.dart';
import '../../../features/main/presentation/widgets/tab_bar.dart';
import '../../../features/letters/presentation/pages/send_letter_screen.dart';
import '../../../features/letters/presentation/pages/send_letter_page.dart';
import '../../../features/letters/presentation/pages/reply_letter_page.dart';
import '../../../features/members/presentation/pages/my_page.dart';
import '../../../features/members/presentation/pages/settings_page.dart';
import '../../../features/couples/presentation/pages/disconnect_page.dart';
import '../../../features/couples/presentation/pages/disconnected_screen.dart';
import '../../../features/members/presentation/pages/nickname_edit_page.dart';
import '../../../features/couples/presentation/pages/relationship_start_edit_page.dart';
//import '../../../features/members/presentation/pages/email_edit_page.dart'; // 사용 안함
import '../../../features/members/presentation/pages/new_email_input_page.dart';
import '../../../features/members/presentation/pages/new_email_certification.dart';
import '../../../features/members/presentation/pages/my_password_edit_page.dart';
import 'route_names.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    initialLocation: RouteNames.splashScreen,
    debugLogDiagnostics: true,
    routes: [
      // Onboarding Routes
      GoRoute(
        path: RouteNames.splashScreen,
        name: RouteNames.splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RouteNames.onboarding,
        name: RouteNames.onboarding,
        builder: (context, state) => const LoginPage(),
      ),

      // Auth Routes
      GoRoute(
        path: RouteNames.emailLoginPage,
        name: RouteNames.emailLoginPage,
        builder: (context, state) => const EmailLoginPage(),
      ),
      GoRoute(
        path: RouteNames.pwFindingPage,
        name: RouteNames.pwFindingPage,
        builder: (context, state) => const PwFindingPage(),
      ),
      GoRoute(
        path: RouteNames.passwordEditPage,
        name: RouteNames.passwordEditPage,
        builder: (context, state) {
          final email = state.uri.queryParameters['email'] ?? '';
          final code = state.uri.queryParameters['code'] ?? '';
          return PasswordEditPage(email: email, code: code);
        },
      ),
      GoRoute(
        path: RouteNames.signupPage,
        name: RouteNames.signupPage,
        builder: (context, state) => const SignupPage(),
      ),
      GoRoute(
        path: RouteNames.emailPasswordInputPage,
        name: RouteNames.emailPasswordInputPage,
        builder: (context, state) => const EmailPasswordInputPage(),
      ),
      GoRoute(
        path: RouteNames.profileRegistrationPage,
        name: RouteNames.profileRegistrationPage,
        builder: (context, state) => const ProfileRegistrationPage(),
      ),
      GoRoute(
        path: RouteNames.codeConnectPage,
        name: RouteNames.codeConnectPage,
        builder: (context, state) => const CodeConnectPage(),
      ),

      // ShellRoute: Main, Storage, My Page with TabBar
      ShellRoute(
        pageBuilder: (context, state, child) {
          int currentIndex = _calculateCurrentIndex(state.uri.toString());
          return NoTransitionPage(
            key: state.pageKey,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              extendBody: true,
              body: child,
              bottomNavigationBar: TabBarWidget(
                currentIndex: currentIndex,
                onTabSelected: (index) {
                  switch (index) {
                    case 0:
                      context.go(RouteNames.mainPage);
                      break;
                    case 1:
                      context.go('/storage');
                      break;
                    case 2:
                      context.go('/my');
                      break;
                  }
                },
              ),
            ),
          );
        },
        routes: [
          GoRoute(
            path: RouteNames.mainPage,
            name: RouteNames.mainPage,
            builder: (context, state) => const MainPage(),
          ),
          GoRoute(
            path: '/storage',
            name: 'storage',
            builder: (context, state) => const StoragePage(),
          ),
          GoRoute(
            path: RouteNames.myPage,
            name: RouteNames.myPage,
            builder: (context, state) => const MyPage(),
          ),
        ],
      ),

      // Other Main Routes
      GoRoute(
        path: RouteNames.notificationPage,
        name: RouteNames.notificationPage,
        builder: (context, state) => const NotificationPage(),
      ),
      GoRoute(
        path: '/calendar',
        name: 'calendar',
        builder: (context, state) => const CalendarPage(),
      ),
      GoRoute(
        path: '/dday',
        name: 'dday',
        builder: (context, state) => const DdayPage(),
      ),
      GoRoute(
        path: '/detail/:type/:month/:day',
        name: 'detail',
        builder: (context, state) {
          final type = state.pathParameters['type']!;
          final month = int.parse(state.pathParameters['month']!);
          final day = int.parse(state.pathParameters['day']!);
          final selectedDay = DateTime(DateTime.now().year, month, day);
          return DetailPage(selectedDay: selectedDay, type: type);
        },
      ),

      // Letter Routes
      GoRoute(
        // SendLetterPage에서 전달받은 extra 값(예: draftContents)을 SendLetterPage 내부에서 GoRouterState.of(context).extra로 읽을 수 있도록 함
        path: RouteNames.sendLetter,
        name: RouteNames.sendLetter,
        builder: (context, state) => const SendLetterPage(),
      ),
      GoRoute(
        path: RouteNames.replyLetter,
        name: RouteNames.replyLetter,
        builder: (context, state) => const ReplyLetterPage(),
      ),
      GoRoute(
        path: RouteNames.sendLetterScreen,
        name: RouteNames.sendLetterScreen,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final letterData = extra['letterData'] as Map<String, dynamic>? ?? {};
          final Future<void> Function() onComplete =
              extra['onComplete'] as Future<void> Function()? ?? () async {};
          return SendLetterScreen(
            receiverName: (letterData['receiver'] as String?) ?? '상대방',
            onComplete: onComplete,
          );
        },
      ),

      // My Page Routes
      GoRoute(
        path: RouteNames.settingsPage,
        name: RouteNames.settingsPage,
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: RouteNames.disconnectPage,
        name: RouteNames.disconnectPage,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          return DisconnectPage(
            appBarTitle: extra['appBarTitle'] as String? ?? '연결끊기',
            richTextPrefix: extra['richTextPrefix'] as String? ?? '상대방',
            richTextSuffix:
                extra['richTextSuffix'] as String? ?? ' 님과\n연결을 끊으시겠어요?',
            imagePath: extra['imagePath'] as String? ??
                'assets/images/my_page/Img_Disconnect.png',
            imageWidth: extra['imageWidth'] as double? ?? 223.0,
            imageHeight: extra['imageHeight'] as double? ?? 176.0,
            bottomText: extra['bottomText'] as String? ??
                '기록된 데이터는 모두 삭제돼요.\n데이터는 30일 이내에 복구할 수 있어요.',
            actionButtonText: extra['actionButtonText'] as String? ?? '연결 끊기',
            gapBetweenImageAndText1:
                extra['gapBetweenImageAndText1'] as double? ?? 78,
            gapBetweenImageAndText2:
                extra['gapBetweenImageAndText2'] as double? ?? 69,
            dialogTitle: extra['dialogTitle'] as String? ?? '정말 연결을 끊으시겠어요?',
            dialogContent: extra['dialogContent'] as String? ??
                '연결 끊기 선택 시, 기록된 데이터는\n모두 삭제되며 복구할 수 없습니다.',
            dialogExitText: extra['dialogExitText'] as String? ?? '연결 끊기',
            dialogSaveText: extra['dialogSaveText'] as String? ?? '돌아가기',
            onDialogExit: extra['onDialogExit'] as VoidCallback? ?? () {},
            onDialogSave: extra['onDialogSave'] as VoidCallback? ?? () {},
          );
        },
      ),
      GoRoute(
        path: RouteNames.disconnectedScreen,
        name: RouteNames.disconnectedScreen,
        builder: (context, state) => const DisconnectedScreen(),
      ),
      GoRoute(
        path: RouteNames.nicknameEditPage,
        name: RouteNames.nicknameEditPage,
        builder: (context, state) => const NicknameEditPage(),
      ),
      GoRoute(
        path: RouteNames.birthdateEditPage,
        name: RouteNames.birthdateEditPage,
        builder: (context, state) => const BirthdateEditPage(),
      ),
      GoRoute(
        path: RouteNames.relationshipStartEditPage,
        name: RouteNames.relationshipStartEditPage,
        builder: (context, state) => const RelationshipStartEditPage(),
      ),
      GoRoute(
        path: RouteNames.newEmailInputPage,
        name: RouteNames.newEmailInputPage,
        builder: (context, state) => const NewEmailInputPage(),
      ),
      GoRoute(
        path: RouteNames.newEmailCertification,
        name: RouteNames.newEmailCertification,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final email = extra['email'] as String? ?? '';
          return NewEmailCertification(email: email);
        },
      ),
      GoRoute(
        path: RouteNames.myPasswordEditPage,
        name: RouteNames.myPasswordEditPage,
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

int _calculateCurrentIndex(String location) {
  if (location.startsWith(RouteNames.myPage)) return 2;
  if (location.startsWith('/storage')) return 1;
  return 0;
}
