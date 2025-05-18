import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper/features/members/presentation/pages/birthdate_edit_page.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../features/onboarding/pages/splash_screen.dart';
import '../../../features/onboarding/pages/login_page.dart';
import '../../../features/auth/presentation/pages/email_login_page.dart';
import '../../../features/auth/presentation/pages/pw_finding_page.dart';
import '../../../features/auth/presentation/pages/password_edit_page.dart';
import '../../../features/auth/presentation/pages/signup_page.dart';
import '../../../features/auth/presentation/pages/email_password_input_page.dart';
import '../../../features/auth/presentation/pages/profile_registration_page.dart';
import '../../../features/auth/presentation/pages/terms_of_service_page.dart'; // 이용약관 페이지 import 추가
import '../../../features/auth/presentation/pages/privacy_policy_page.dart';
import '../../../features/couples/presentation/pages/code_connect_page.dart';
import '../../../features/couples/presentation/pages/dday_page.dart';
import '../../../features/couples/presentation/pages/storage_page.dart';
import '../../../features/couples/presentation/pages/disconnect_page.dart';
import '../../../features/couples/presentation/pages/disconnected_screen.dart';
import '../../../features/couples/presentation/pages/relationship_start_edit_page.dart';
import '../../../features/main/presentation/pages/main_page.dart';
import '../../../features/main/presentation/pages/notification_page.dart';
import '../../../features/main/presentation/widgets/tab_bar.dart';
import '../../../features/calendar/presentation/pages/calendar_page.dart';
import '../../../features/calendar/presentation/pages/detail_page.dart';
import '../../../features/letters/presentation/pages/send_letter_screen.dart';
import '../../../features/letters/presentation/pages/send_letter_page.dart';
import '../../../features/letters/presentation/pages/reply_letter_page.dart';
import '../../../features/letters/presentation/pages/received_letter_page.dart';
import '../../../features/members/presentation/pages/my_page.dart';
import '../../../features/members/presentation/pages/settings_page.dart';
import '../../../features/members/presentation/pages/nickname_edit_page.dart';
import '../../../features/members/presentation/pages/new_email_input_page.dart';
import '../../../features/members/presentation/pages/new_email_certification.dart';
import '../../../features/members/presentation/pages/my_password_edit_page.dart';
import 'route_names.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    initialLocation: RouteNames.onboarding,
    debugLogDiagnostics: true,
    routes: [
      // Onboarding Routes
      GoRoute(
        path: RouteNames.splashScreen,
        name: RouteNames.splashScreen,
        pageBuilder:
            (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const SplashScreen(),
            ),
      ),
      GoRoute(
        path: RouteNames.onboarding,
        name: RouteNames.onboarding,
        pageBuilder:
            (context, state) =>
                NoTransitionPage(key: state.pageKey, child: const LoginPage()),
      ),

      // Auth Routes
      GoRoute(
        path: RouteNames.emailLoginPage,
        name: RouteNames.emailLoginPage,
        pageBuilder:
            (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const EmailLoginPage(),
            ),
      ),
      GoRoute(
        path: RouteNames.pwFindingPage,
        name: RouteNames.pwFindingPage,
        pageBuilder:
            (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const PwFindingPage(),
            ),
      ),
      GoRoute(
        path: RouteNames.passwordEditPage,
        name: RouteNames.passwordEditPage,
        pageBuilder: (context, state) {
          final email = state.uri.queryParameters['email'] ?? '';
          final code = state.uri.queryParameters['code'] ?? '';
          return NoTransitionPage(
            key: state.pageKey,
            child: PasswordEditPage(email: email, code: code),
          );
        },
      ),
      GoRoute(
        path: RouteNames.signupPage,
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          debugPrint('GoRouter received extra: $extra');
          return NoTransitionPage(
            key: state.pageKey,
            child: SignupPage(extraEmail: extra?['email'] as String?),
          );
        },
      ),
      GoRoute(
        path: RouteNames.emailPasswordInputPage,
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          debugPrint('GoRouter received extra: $extra');
          return NoTransitionPage(
            key: state.pageKey,
            child: EmailPasswordInputPage(email: extra?['email'] as String?),
          );
        },
      ),
      GoRoute(
        path: RouteNames.profileRegistrationPage,
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          debugPrint('GoRouter received extra: $extra');
          return NoTransitionPage(
            key: state.pageKey,
            child: ProfileRegistrationPage(
              email: extra?['email'] as String?,
              provider: extra?['provider'] as String?,
              providerId: extra?['providerId'] as String?,
            ),
          );
        },
      ),

      GoRoute(
        path: RouteNames.codeConnectPage,
        name: RouteNames.codeConnectPage,
        pageBuilder:
            (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const CodeConnectPage(),
            ),
      ),

      GoRoute(
        path: RouteNames.termsOfServicePage,
        name: 'termsOfService',
        pageBuilder:
            (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const TermsOfServicePage(),
            ),
      ),

      GoRoute(
        path: RouteNames.privacyPolicyPage,
        name: 'privacyPolicy',
        pageBuilder:
            (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const PrivacyPolicyPage(),
            ),
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
            pageBuilder:
                (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const MainPage(),
                ),
          ),
          GoRoute(
            path: '/storage',
            name: 'storage',
            pageBuilder:
                (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const StoragePage(),
                ),
          ),
          GoRoute(
            path: RouteNames.myPage,
            name: RouteNames.myPage,
            pageBuilder:
                (context, state) =>
                    NoTransitionPage(key: state.pageKey, child: const MyPage()),
          ),
        ],
      ),

      // Other Main Routes
      GoRoute(
        path: RouteNames.notificationPage,
        name: RouteNames.notificationPage,
        pageBuilder:
            (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const NotificationPage(),
            ),
      ),
      GoRoute(
        path: '/calendar',
        name: 'calendar',
        pageBuilder:
            (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const CalendarPage(),
            ),
      ),
      GoRoute(
        path: '/dday',
        name: 'dday',
        pageBuilder:
            (context, state) =>
                NoTransitionPage(key: state.pageKey, child: const DdayPage()),
      ),
      GoRoute(
        path: '/detail/:type/:month/:day',
        name: 'detail',
        pageBuilder: (context, state) {
          final type = state.pathParameters['type']!;
          final month = int.parse(state.pathParameters['month']!);
          final day = int.parse(state.pathParameters['day']!);
          final selectedDay = DateTime(DateTime.now().year, month, day);
          return NoTransitionPage(
            key: state.pageKey,
            child: DetailPage(selectedDay: selectedDay, type: type),
          );
        },
      ),

      // Letter Routes
      GoRoute(
        path: RouteNames.sendLetter,
        name: RouteNames.sendLetter,
        pageBuilder:
            (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const SendLetterPage(),
            ),
      ),
      GoRoute(
        path: RouteNames.replyLetter,
        name: RouteNames.replyLetter,
        pageBuilder:
            (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const ReplyLetterPage(),
            ),
      ),

      GoRoute(
        path: RouteNames.sendLetterScreen,
        name: RouteNames.sendLetterScreen,
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final letterData = extra['letterData'] as Map<String, dynamic>? ?? {};
          final onComplete = extra['onComplete'] as VoidCallback? ?? () {};

          return NoTransitionPage(
            key: state.pageKey,
            child: SendLetterScreen(
              receiverName: (letterData['receiver'] as String?) ?? '상대방',
              letterContent: (letterData['content'] as String?) ?? '',
              onComplete: onComplete,
            ),
          );
        },
      ),

      // app_router.dart에서 receivedLetterPage 라우트 수정
      GoRoute(
        path: RouteNames.receivedLetterPage,
        name: RouteNames.receivedLetterPage,
        pageBuilder: (context, state) {
          final Map<String, dynamic>? letterData =
              state.extra as Map<String, dynamic>?;
          if (letterData == null) {
            // 오류 처리: 편지 데이터가 없는 경우
            return NoTransitionPage(
              key: state.pageKey,
              child: Scaffold(body: Center(child: Text('편지 데이터를 찾을 수 없습니다.'))),
            );
          }
          return NoTransitionPage(
            key: state.pageKey,
            child: ReceivedLetterPage(letterData: letterData),
          );
        },
      ),

      // My Page Routes
      GoRoute(
        path: RouteNames.settingsPage,
        name: RouteNames.settingsPage,
        pageBuilder:
            (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const SettingsPage(),
            ),
      ),
      GoRoute(
        path: RouteNames.disconnectPage,
        name: RouteNames.disconnectPage,
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          return NoTransitionPage(
            key: state.pageKey,
            child: DisconnectPage(
              appBarTitle: extra['appBarTitle'] as String? ?? '연결끊기',
              richTextPrefix: extra['richTextPrefix'] as String? ?? '상대방',
              richTextSuffix:
                  extra['richTextSuffix'] as String? ?? ' 님과\n연결을 끊으시겠어요?',
              imagePath:
                  extra['imagePath'] as String? ??
                  'assets/images/my_page/Img_Disconnect.png',
              imageWidth: extra['imageWidth'] as double? ?? 223.0,
              imageHeight: extra['imageHeight'] as double? ?? 176.0,
              bottomText:
                  extra['bottomText'] as String? ??
                  '기록된 데이터는 모두 삭제돼요.\n데이터는 30일 이내에 복구할 수 있어요.',
              actionButtonText: extra['actionButtonText'] as String? ?? '연결 끊기',
              gapBetweenImageAndText1:
                  extra['gapBetweenImageAndText1'] as double? ?? 78,
              gapBetweenImageAndText2:
                  extra['gapBetweenImageAndText2'] as double? ?? 69,
              dialogTitle: extra['dialogTitle'] as String? ?? '정말 연결을 끊으시겠어요?',
              dialogContent:
                  extra['dialogContent'] as String? ??
                  '연결 끊기 선택 시, 기록된 데이터는\n모두 삭제되며 복구할 수 없습니다.',
              dialogExitText: extra['dialogExitText'] as String? ?? '연결 끊기',
              dialogSaveText: extra['dialogSaveText'] as String? ?? '돌아가기',
              onDialogExit: extra['onDialogExit'] as VoidCallback? ?? () {},
              onDialogSave: extra['onDialogSave'] as VoidCallback? ?? () {},
            ),
          );
        },
      ),
      GoRoute(
        path: RouteNames.disconnectedScreen,
        name: RouteNames.disconnectedScreen,
        pageBuilder:
            (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const DisconnectedScreen(),
            ),
      ),
      GoRoute(
        path: RouteNames.nicknameEditPage,
        name: RouteNames.nicknameEditPage,
        pageBuilder:
            (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const NicknameEditPage(),
            ),
      ),
      GoRoute(
        path: RouteNames.birthdateEditPage,
        name: RouteNames.birthdateEditPage,
        pageBuilder:
            (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const BirthdateEditPage(),
            ),
      ),
      GoRoute(
        path: RouteNames.relationshipStartEditPage,
        name: RouteNames.relationshipStartEditPage,
        pageBuilder:
            (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const RelationshipStartEditPage(),
            ),
      ),
      GoRoute(
        path: RouteNames.newEmailInputPage,
        name: RouteNames.newEmailInputPage,
        pageBuilder:
            (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const NewEmailInputPage(),
            ),
      ),
      GoRoute(
        path: RouteNames.newEmailCertification,
        name: RouteNames.newEmailCertification,
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final email = extra['email'] as String? ?? '';
          return NoTransitionPage(
            key: state.pageKey,
            child: NewEmailCertification(email: email),
          );
        },
      ),
      GoRoute(
        path: RouteNames.myPasswordEditPage,
        name: RouteNames.myPasswordEditPage,
        pageBuilder:
            (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const MyPasswordEditPage(),
            ),
      ),
    ],

    errorPageBuilder:
        (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: Scaffold(
            body: Center(child: Text('페이지를 찾을 수 없습니다: ${state.error}')),
          ),
        ),
  );
}

// 커스텀 NavigatorObserver 추가
class _CustomNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print('Navigator didPush: ${route.settings.name}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print('Navigator didPop: ${route.settings.name}');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    print('Navigator didReplace: ${newRoute?.settings.name}');
  }
}

int _calculateCurrentIndex(String location) {
  if (location.startsWith(RouteNames.myPage)) return 2;
  if (location.startsWith('/storage')) return 1;
  return 0;
}
