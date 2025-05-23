import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper/core/config/routes/route_names.dart';
import 'package:love_keeper/core/providers/auth_state_provider.dart';
import 'package:love_keeper/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:love_keeper/features/couples/presentation/viewmodels/couples_viewmodel.dart';
import 'package:love_keeper/features/letters/presentation/widgets/custom_bottom_sheet_dialog.dart';
import 'package:love_keeper/features/members/presentation/viewmodels/members_viewmodel.dart';
import 'package:permission_handler/permission_handler.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});
  final String _enterIconPath = 'assets/images/my_page/Ic_Enter.png';
  final String appVersion = '0.1.1';

  Future<void> openNotificationSettings() async {
    final status = await Permission.notification.status;
    if (status.isDenied || status.isPermanentlyDenied) {
      await openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    const double baseWidth = 375.0;
    final double scaleFactor = deviceWidth / baseWidth;

    final partnerNickname =
        ref.watch(couplesViewModelProvider).value?.partnerNickname ?? '상대방';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,

        scrolledUnderElevation: 0, // 스크롤 시 그림자 효과 제거
        elevation: 0,
        centerTitle: true,
        surfaceTintColor:
            Colors.transparent, // 스크롤 시 surface tint 색상 제거 (Material 3)
        foregroundColor: const Color(0xFF27282C), // 앱바 콘텐츠 색상 설정
        title: Text(
          '설정',
          style: TextStyle(
            fontSize: 18 * scaleFactor,
            fontWeight: FontWeight.w600,
            height: 26 / 18,
            letterSpacing: -0.45 * scaleFactor,
            color: const Color(0xFF27282C),
          ),
        ),
        leading: Padding(
          padding: EdgeInsets.only(left: 0.0 * scaleFactor),
          child: IconButton(
            icon: Image.asset(
              'assets/images/letter_page/Ic_Back.png',
              width: 24 * scaleFactor,
              height: 24 * scaleFactor,
            ),
            constraints: const BoxConstraints(),
            padding: EdgeInsets.zero,
            onPressed: () => context.pop(),
          ),
        ),
      ),

      // 스크롤 가능하게 SingleChildScrollView로 감싸기
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16 * scaleFactor),
            _buildCategoryTitle('알림', scaleFactor),
            SizedBox(height: 16 * scaleFactor),
            _buildNotificationOption('푸시 알림', scaleFactor),
            SizedBox(height: 16 * scaleFactor),
            _buildNotificationOption('이메일 알림', scaleFactor),
            SizedBox(height: 16 * scaleFactor),
            _buildNotificationOption('마케팅 정보 알림', scaleFactor),
            SizedBox(height: 16 * scaleFactor),
            _buildDivider(deviceWidth, scaleFactor),
            _buildCategoryTitle('개인', scaleFactor),
            SizedBox(height: 16 * scaleFactor),
            _buildNavigationOption(
              '로그아웃',
              scaleFactor,
              onTap: () {
                _showLogoutDialog(context, ref, scaleFactor);
              },
            ),
            SizedBox(height: 16 * scaleFactor),
            _buildNavigationOption(
              '연결 끊기',
              scaleFactor,
              onTap: () {
                context.pushNamed(
                  '/disconnect',
                  extra: {
                    'appBarTitle': '연결끊기',
                    'richTextPrefix': '상대방',
                    'richTextSuffix': ' 님과\n연결을 끊으시겠어요?',
                    'imagePath': 'assets/images/my_page/Img_Disconnect.png',
                    'imageWidth': 223.0,
                    'imageHeight': 176.0,
                    'bottomText': '기록된 데이터는 모두 삭제돼요.\n데이터는 30일 이내에 복구할 수 있어요.',
                    'actionButtonText': '연결 끊기',
                    'gapBetweenImageAndText1': 78.0,
                    'gapBetweenImageAndText2': 69.0,
                    'dialogTitle': '정말 연결을 끊으시겠어요?',
                    'dialogContent':
                        '연결 끊기 선택 시, 기록된 데이터는\n모두 삭제되며 복구할 수 없습니다.',
                    'dialogExitText': '연결 끊기',
                    'dialogSaveText': '돌아가기',
                    'onDialogExit': () => context.go('/disconnected_SC'),
                    'onDialogSave': () => context.pop(),
                  },
                );
              },
            ),
            SizedBox(height: 16 * scaleFactor),
            _buildNavigationOption(
              '회원 탈퇴',
              scaleFactor,
              onTap: () {
                context.pushNamed(
                  RouteNames.disconnectPage,

                  extra: {
                    'appBarTitle': '회원탈퇴',
                    'richTextPrefix': '러브키퍼',
                    'richTextSuffix': '를\n정말 떠나시겠어요?',
                    'imagePath': 'assets/images/my_page/Img_Withdraw.png',
                    'imageWidth': 138.0,
                    'imageHeight': 138.0,
                    'bottomText':
                        '탈퇴 시, 상대방과의 연결이 끊어져요.\n기록된 데이터는 모두 삭제되며 복구할 수 없어요.',
                    'actionButtonText': '탈퇴하기',
                    'gapBetweenImageAndText1': 97.0,
                    'gapBetweenImageAndText2': 88.0,
                    'dialogTitle': '정말 탈퇴하시겠어요?',
                    'dialogContent':
                        '탈퇴하기 선택 시, 상대방과의 연결이 끊어지며\n기록된 데이터는 모두 삭제됩니다.',
                    'dialogExitText': '탈퇴하기',
                    'dialogSaveText': '돌아가기',
                    'onDialogExit': () => context.go('/onboarding'),
                    'onDialogSave': () => context.pop(),
                  },
                );
              },
            ),
            SizedBox(height: 16 * scaleFactor),
            _buildDivider(deviceWidth, scaleFactor),
            _buildCategoryTitle('기타', scaleFactor),
            SizedBox(height: 16 * scaleFactor),
            _buildVersionInfo(scaleFactor),
            SizedBox(height: 16 * scaleFactor),
            _buildNavigationOption(
              '약관 및 정책',
              scaleFactor,
              onTap: () {
                // 이용약관 페이지로 이동
                context.pushNamed('termsOfService');
              },
            ),
            SizedBox(height: 100 * scaleFactor), // 하단 여유 공간 추가
          ],
        ),
      ),
    );
  }

  // 카테고리 제목 (알림, 개인, 기타)
  Widget _buildCategoryTitle(String title, double scaleFactor) {
    return Padding(
      padding: EdgeInsets.only(left: 20 * scaleFactor),
      child: SizedBox(
        width: 24 * scaleFactor,
        height: 20 * scaleFactor,
        child: Text(
          title,
          style: TextStyle(
            color: const Color(0xFF747784),
            fontSize: 14 * scaleFactor,
            fontWeight: FontWeight.w400,
            height: 20 / 14,
            letterSpacing: -0.025 * (14 * scaleFactor),
          ),
        ),
      ),
    );
  }

  // 회색 구분 바
  Widget _buildDivider(double deviceWidth, double scaleFactor) {
    return Column(
      children: [
        Container(
          width: deviceWidth,
          height: 16 * scaleFactor,
          color: const Color(0xFFF7F8FB),
        ),
        SizedBox(height: 16 * scaleFactor),
      ],
    );
  }

  // 알림 옵션 (푸시 알림, 이메일 알림, 마케팅 정보 알림)
  Widget _buildNotificationOption(String title, double scaleFactor) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20 * scaleFactor),
      child: SizedBox(
        width: 335 * scaleFactor,
        height: 38 * scaleFactor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 102 * scaleFactor,
              height: 24 * scaleFactor,
              child: Text(
                title,
                style: TextStyle(
                  color: const Color(0xFF27282C),
                  fontSize: 16 * scaleFactor,
                  fontWeight: FontWeight.w500,
                  height: 24 / 16,
                  letterSpacing: -0.025 * (16 * scaleFactor),
                ),
              ),
            ),
            PushNotificationToggle(scaleFactor: scaleFactor),
          ],
        ),
      ),
    );
  }

  // 네비게이션 옵션 (로그아웃, 연결 끊기, 회원 탈퇴, 약관 및 정책)
  Widget _buildNavigationOption(
    String title,
    double scaleFactor, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20 * scaleFactor),
        child: Container(
          // Container로 변경하여 전체 영역이 탭 가능하도록 함
          width: 335 * scaleFactor,
          height: 38 * scaleFactor,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4 * scaleFactor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 24 * scaleFactor,
                child: Text(
                  title,
                  style: TextStyle(
                    color: const Color(0xFF27282C),
                    fontSize: 16 * scaleFactor,
                    fontWeight: FontWeight.w500,
                    height: 24 / 16,
                    letterSpacing: -0.025 * (16 * scaleFactor),
                  ),
                ),
              ),
              Image.asset(
                _enterIconPath,
                width: 14 * scaleFactor,
                height: 14 * scaleFactor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 버전 정보 - 클릭 범위 확장
  Widget _buildVersionInfo(double scaleFactor) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20 * scaleFactor),
      child: Container(
        // Container로 변경
        width: 335 * scaleFactor,
        height: 38 * scaleFactor,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4 * scaleFactor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 24 * scaleFactor,
              child: Text(
                '버전 정보',
                style: TextStyle(
                  color: const Color(0xFF27282C),
                  fontSize: 16 * scaleFactor,
                  fontWeight: FontWeight.w500,
                  height: 24 / 16,
                  letterSpacing: -0.025 * (16 * scaleFactor),
                ),
              ),
            ),
            SizedBox(
              height: 24 * scaleFactor,
              width: 27 * scaleFactor,
              child: Text(
                appVersion,
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: const Color(0xFF747784),
                  fontSize: 16 * scaleFactor,
                  fontWeight: FontWeight.w400,
                  height: 24 / 16,
                  letterSpacing: -0.025 * (16 * scaleFactor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(
    BuildContext context,
    WidgetRef ref,
    double scaleFactor,
  ) {
    FocusScope.of(context).unfocus();
    Future.delayed(const Duration(milliseconds: 200), () {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        isDismissible: true,
        enableDrag: true,
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () => Navigator.pop(context),
            behavior: HitTestBehavior.opaque,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: SizedBox(
                    width: double.infinity,
                    height: 288 * scaleFactor,
                    child: CustomBottomSheetDialog(
                      scaleFactor: scaleFactor,
                      title: '정말 로그아웃하시겠어요?',
                      content: '로그아웃 선택 시,\n현재 계정에서 로그아웃 됩니다.',
                      exitText: '로그아웃',
                      saveText: '돌아가기',
                      showSaveButton: true,
                      onExit: () => _logoutFunction(context, ref),
                      onSave: () => Navigator.pop(context),
                      onDismiss: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }

  Future<void> _logoutFunction(BuildContext context, WidgetRef ref) async {
    try {
      // AuthViewModel의 logout 호출
      await ref.read(authViewModelProvider.notifier).logout();
      // 로그아웃 성공 시 인증 상태 초기화
      ref
          .read(authStateNotifierProvider.notifier)
          .clear(); // clearState -> clear
      // 로그인 화면으로 이동
      context.go(RouteNames.onboarding);
    } catch (e) {
      // 에러 처리: 사용자에게 알림
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('로그아웃 실패: $e')));
    }
  }
}

// 알림 상태 관리 토글 버튼
class PushNotificationToggle extends StatefulWidget {
  final double scaleFactor;
  const PushNotificationToggle({super.key, required this.scaleFactor});

  @override
  _PushNotificationToggleState createState() => _PushNotificationToggleState();
}

class _PushNotificationToggleState extends State<PushNotificationToggle> {
  bool isEnabled = true;

  @override
  Widget build(BuildContext context) {
    final double width = 36 * widget.scaleFactor;
    final double height = 20 * widget.scaleFactor;
    final double circleSize = 16 * widget.scaleFactor;

    return GestureDetector(
      onTap: () async {
        setState(() {
          isEnabled = !isEnabled;
        });
        await openAppSettings(); // 또는 openNotificationSettings() 함수 추출해도 됨
      },
      child: Stack(
        children: [
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color:
                  isEnabled ? const Color(0xFFFF859B) : const Color(0xFFC3C6CF),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            left: isEnabled ? 17 * widget.scaleFactor : 3 * widget.scaleFactor,
            top: 2 * widget.scaleFactor,
            child: Container(
              width: circleSize,
              height: circleSize,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
