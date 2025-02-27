import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper_fe/features/letters/presentation/widgets/custom_bottom_sheet_dialog.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
<<<<<<< HEAD:lib/features/auth/my_page/presentation/pages/settings_page.dart
=======

>>>>>>> origin/main:lib/features/members/presentation/pages/settings_page.dart
  final String _enterIconPath = 'assets/images/my_page/Ic_Enter.png';
  final String appVersion = '0.1.1'; // 기본 버전 초기값

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    const double baseWidth = 375.0;
    final double scaleFactor = deviceWidth / baseWidth;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16 * scaleFactor),

          // '알림' 카테고리
          _buildCategoryTitle('알림', scaleFactor),
          SizedBox(height: 16 * scaleFactor),

          // 알림 설정 옵션들
          _buildNotificationOption('푸시 알림', scaleFactor),
          SizedBox(height: 16 * scaleFactor),
          _buildNotificationOption('이메일 알림', scaleFactor),
          SizedBox(height: 16 * scaleFactor),
          _buildNotificationOption('마케팅 정보 알림', scaleFactor),
          SizedBox(height: 16 * scaleFactor),

          // 회색 구분 바
          _buildDivider(deviceWidth, scaleFactor),

          // '개인' 카테고리
          _buildCategoryTitle('개인', scaleFactor),
          SizedBox(height: 16 * scaleFactor),

          // 개인 설정 옵션들 (로그아웃 / 연결 끊기 / 회원 탈퇴)
          _buildNavigationOption('로그아웃', scaleFactor, onTap: () {
            _showLogoutDialog(context, scaleFactor);
          }),
          SizedBox(height: 16 * scaleFactor),

          //연결 끊기 페이지 이동, 고라우터 사용
          _buildNavigationOption('연결 끊기', scaleFactor, onTap: () {
            context.pushNamed('disconnectPage', extra: {
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
              'dialogContent': '연결 끊기 선택 시, 기록된 데이터는\n모두 삭제되며 복구할 수 없습니다.',
              'dialogExitText': '연결 끊기',
              'dialogSaveText': '돌아가기',
              'onDialogExit': () {
                // 연결 끊기 버튼 누르면, 커플 연결 시작 화면으로 이동 (예: 'coupleConnect' 라우트)
                context.go('/disconnected_SC');
              },
              'onDialogSave': () {
                context.pop(); // 설정 페이지로 돌아감
              },
            });
          }),

          SizedBox(height: 16 * scaleFactor),

          _buildNavigationOption('회원 탈퇴', scaleFactor, onTap: () {
            context.pushNamed('disconnectPage', extra: {
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
              'dialogContent': '탈퇴하기 선택 시, 상대방과의 연결이 끊어지며\n기록된 데이터는 모두 삭제됩니다.',
              'dialogExitText': '탈퇴하기',
              'dialogSaveText': '돌아가기',
              'onDialogExit': () {
                context.go('/onboarding'); //온보딩으로 가는로직 구현하기
              },
              'onDialogSave': () {
                context.pop(); // 설정 페이지로 돌아감
              },
            });
          }),
          SizedBox(height: 16 * scaleFactor),

          // 회색 구분 바
          _buildDivider(deviceWidth, scaleFactor),

          // '기타' 카테고리 추가
          _buildCategoryTitle('기타', scaleFactor),
          SizedBox(height: 16 * scaleFactor),

          // 버전 정보
          _buildVersionInfo(scaleFactor),
          SizedBox(height: 16 * scaleFactor),

          // 약관 및 정책
          _buildNavigationOption('약관 및 정책', scaleFactor),
          SizedBox(height: 16 * scaleFactor),
        ],
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
  // onTap을 선택적으로 전달받아 터치 시 실행할 수 있게 함.
  Widget _buildNavigationOption(String title, double scaleFactor,
      {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20 * scaleFactor),
        child: SizedBox(
          width: 335 * scaleFactor,
          height: 38 * scaleFactor,
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

  // 버전 정보
  Widget _buildVersionInfo(double scaleFactor) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20 * scaleFactor),
      child: SizedBox(
        width: 335 * scaleFactor,
        height: 38 * scaleFactor,
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

  // 로그아웃 필드를 누르면 호출되는 함수: 커스텀 바텀 시트를 표시
  void _showLogoutDialog(BuildContext context, double scaleFactor) {
    // 키보드를 먼저 닫음
    FocusScope.of(context).unfocus();

    // 키보드가 완전히 닫힌 후 바텀 시트를 띄우도록 약간의 딜레이 추가
    Future.delayed(const Duration(milliseconds: 200), () {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent, // 배경을 투명하게 유지
        isDismissible: true, // 배경 클릭 시 닫히도록 설정
        enableDrag: true, // 드래그하여 닫을 수 있도록 설정
        builder: (BuildContext context) {
          // scaleFactor를 build 내에서 정의해야 함(예시: 이미 정의되어 있다고 가정)
          // 여기서는 기존에 정의된 scaleFactor 변수가 있다고 가정합니다.
          return GestureDetector(
            onTap: () => Navigator.pop(context), // 배경 클릭 시 닫기
            behavior: HitTestBehavior.opaque,
            child: Stack(
              children: [
                // 바텀시트를 하단에 붙이기
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: SizedBox(
                    width: double.infinity,
                    height: 288 * scaleFactor, // 바텀시트 높이 조정
                    child: CustomBottomSheetDialog(
                      scaleFactor: scaleFactor,
                      title: '정말 로그아웃하시겠어요?',
                      content: '로그아웃 선택 시,\n현재 계정에서 로그아웃 됩니다.',
                      exitText: '로그아웃',
                      saveText: '돌아가기',
                      showSaveButton: true,
                      onExit: () => _logoutFunction(context), // context 전달
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

  void _logoutFunction(BuildContext context) {
    // 로그아웃 API 호출 등 로그아웃 처리 후,
    Navigator.pop(context);
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
      onTap: () {
        setState(() {
          isEnabled = !isEnabled;
        });
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
