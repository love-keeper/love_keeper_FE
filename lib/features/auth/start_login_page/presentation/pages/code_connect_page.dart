import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper_fe/features/auth/my_page/presentation/widgets/edit_field_widget.dart';
import 'package:love_keeper_fe/features/auth/my_page/presentation/widgets/save_button_widget.dart';

class CodeConnectPage extends StatefulWidget {
  const CodeConnectPage({Key? key}) : super(key: key);

  @override
  _CodeConnectPageState createState() => _CodeConnectPageState();
}

class _CodeConnectPageState extends State<CodeConnectPage> {
  final TextEditingController _inviteCodeController = TextEditingController();

  // 백엔드에서 받아온 상대방 초대 코드 (가정)
  final String expectedInviteCode = "S9FDJ24JSF";

  @override
  void initState() {
    super.initState();
    _inviteCodeController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _inviteCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 화면 너비에 따른 scaleFactor 계산 (기준: 375)
    final double deviceWidth = MediaQuery.of(context).size.width;
    const double baseWidth = 375.0;
    final double scaleFactor = deviceWidth / baseWidth;

    // 사용자가 초대 코드를 입력했는지 여부
    final bool hasText = _inviteCodeController.text.isNotEmpty;
    // 입력한 코드와 예상 코드가 일치하지 않으면 가이드 문구 표시
    final String guideMessage =
        hasText && _inviteCodeController.text != expectedInviteCode
            ? "입력한 초대 코드가 유효하지 않습니다. 다시 입력해 주세요."
            : "";

    // SaveButton 활성화 조건: 사용자가 입력한 코드가 있고, 올바른 코드일 때만 활성화
    final bool isButtonEnabled =
        hasText && _inviteCodeController.text == expectedInviteCode;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "코드연결",
          style: TextStyle(
            fontSize: 18 * scaleFactor,
            fontWeight: FontWeight.w600,
            height: 26 / 18,
            letterSpacing: -0.025 * (18 * scaleFactor),
            color: const Color(0xFF27282C),
          ),
        ),
        leading: IconButton(
          icon: Image.asset(
            'assets/images/letter_page/Ic_Back.png',
            width: 24 * scaleFactor,
            height: 24 * scaleFactor,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20 * scaleFactor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16 * scaleFactor),
            // 초대 코드 박스: 106×26 크기, 분홍색 텍스트와 복사 아이콘(16×16, 옆에 2 간격)
            Container(
              width: 150 * scaleFactor,
              height: 26 * scaleFactor,
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    expectedInviteCode,
                    style: TextStyle(
                      fontSize: 18 * scaleFactor,
                      fontWeight: FontWeight.w600,
                      height: 26 / 18,
                      letterSpacing: -0.025 * (18 * scaleFactor),
                      color: const Color(0xFFFF859B),
                    ),
                  ),
                  SizedBox(width: 2 * scaleFactor),
                  Image.asset(
                    'assets/images/login_page/Ic_Copy.png',
                    width: 16 * scaleFactor,
                    height: 16 * scaleFactor,
                  ),
                ],
              ),
            ),
            SizedBox(height: 3 * scaleFactor),
            // 안내 문구: "생성된 초대 코드를 복사해 상대방에게 전달해 보세요."
            Text(
              "생성된 초대 코드를 복사해 상대방에게 전달해 보세요.",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 14 * scaleFactor,
                fontWeight: FontWeight.w400,
                height: 22 / 14,
                letterSpacing: -0.025 * (14 * scaleFactor),
                color: const Color(0xFF27282C),
              ),
            ),
            SizedBox(height: 36 * scaleFactor),
            // 상대방 초대 코드 입력 필드 (EditFieldWidget 사용)
            EditFieldWidget(
              label: "상대방 초대 코드",
              hintText: "전달 받은 초대 코드를 입력해 주세요.",
              controller: _inviteCodeController,
              scaleFactor: scaleFactor,
              autofocus: true,
              guideMessage: guideMessage,
            ),
          ],
        ),
      ),
      bottomNavigationBar: SaveButtonWidget(
        scaleFactor: scaleFactor,
        enabled: isButtonEnabled,
        buttonText: "연결하기",
        onPressed: () {
          // 연결하기 버튼 누르면 메인 페이지로 이동
          context.push('/mainPage');
        },
      ),
    );
  }
}
