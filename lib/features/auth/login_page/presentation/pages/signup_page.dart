import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper_fe/features/auth/my_page/presentation/widgets/save_button_widget.dart';
import 'package:love_keeper_fe/features/auth/my_page/presentation/widgets/email_edit_field_widget.dart';

//전에 입력한 이메일 넘겨받기
class SignupPage extends StatefulWidget {
  final String email;
  const SignupPage({Key? key, required this.email}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailCodeController = TextEditingController();
  String _verificationCode = "";

  @override
  void initState() {
    super.initState();

    // 페이지가 시작되면 인증 코드를 백엔드에서 받아온다고 가정하고 저장합니다.
    _sendVerificationCode();

    // 텍스트 변경 시 상태 업데이트
    _emailCodeController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _emailCodeController.dispose();
    super.dispose();
  }

  // 백엔드에서 인증 코드를 받아오는 함수 (여기서는 임의의 "123456"으로 설정)
  Future<void> _sendVerificationCode() async {
    // 실제 API 호출 대신, 임의의 코드를 할당
    setState(() {
      _verificationCode = "123456";
    });
    debugPrint("인증코드 전송됨: $_verificationCode");
  }

  @override
  Widget build(BuildContext context) {
    // 화면 너비에 따른 scaleFactor 계산 (기준: 375)
    final double deviceWidth = MediaQuery.of(context).size.width;
    const double baseWidth = 375.0;
    final double scaleFactor = deviceWidth / baseWidth;
    final bool hasText = _emailCodeController.text.isNotEmpty;
    final bool codeMatches = _emailCodeController.text == _verificationCode;

    void _showResendBottomSheet(BuildContext context, double scaleFactor) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent, // 배경은 투명하게
        isDismissible: true,
        builder: (BuildContext dialogContext) {
          return GestureDetector(
            onTap: () => Navigator.pop(dialogContext),
            behavior: HitTestBehavior.opaque,
            child: Stack(
              children: [
                // 전체 화면 오버레이 (투명)
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.transparent,
                ),
                // 하단에 바텀시트 배치
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {}, // 바텀시트 내부 터치 시 닫히지 않도록
                    child: Container(
                      width: 375 * scaleFactor,
                      height: 288 * scaleFactor,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16 * scaleFactor),
                          topRight: Radius.circular(16 * scaleFactor),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 7 * scaleFactor),
                          // 드래그 핸들
                          Container(
                            width: 50 * scaleFactor,
                            height: 5 * scaleFactor,
                            decoration: BoxDecoration(
                              color: const Color(0xFFC3C6CF),
                              borderRadius:
                                  BorderRadius.circular(26 * scaleFactor),
                            ),
                          ),
                          // (필요하다면 중간에 설명 텍스트나 여백 추가)
                          SizedBox(height: 44 * scaleFactor),
                          Container(
                            width: 169 * scaleFactor,
                            height: 26 * scaleFactor,
                            alignment: Alignment.topCenter,
                            child: Text(
                              "메일을 받지 못하셨나요?",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18 * scaleFactor,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF27282C),
                                height: 26 / 18,
                                letterSpacing: -(18 * 0.025),
                              ),
                            ),
                          ),
                          SizedBox(height: 16 * scaleFactor),
                          Container(
                            width: 335 * scaleFactor,
                            height: 72 * scaleFactor,
                            color: Colors.transparent,
                            alignment: Alignment.topCenter,
                            child: Text(
                              "스팸 메일함을 확인하거나,\n인증코드 재전송 버튼을 눌러 주세요.\n문제가 계속되면 1:1 카카오톡 문의를 이용해 주세요.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16 * scaleFactor,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF27282C),
                                height: 24 / 16,
                                letterSpacing: -(16 * 0.025),
                              ),
                            ),
                          ),
                          SizedBox(height: 16 * scaleFactor),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                context.pop();
                              },
                              child: Container(
                                width: 334 * scaleFactor,
                                height: 52 * scaleFactor,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFF859B),
                                  borderRadius:
                                      BorderRadius.circular(55 * scaleFactor),
                                ),
                                child: Center(
                                  child: Text(
                                    "확인",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16 * scaleFactor,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      height: 24 / 16,
                                      letterSpacing:
                                          -0.025 * (16 * scaleFactor),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 50 * scaleFactor),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    // 입력된 텍스트가 있을 때, 입력값이 인증 코드와 일치하지 않으면 안내 문구 표시
    final String guideMessage =
        hasText && !codeMatches ? "인증코드가 일치하지 않습니다. 다시 입력해 주세요." : "";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "이메일로 시작",
          style: TextStyle(
            fontSize: 18 * scaleFactor,
            fontWeight: FontWeight.w600,
            height: 26 / 18,
            letterSpacing: -0.45 * scaleFactor,
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
      // bottomNavigationBar에 '메일을 받지 못하셨나요?' 버튼과 '다음' 버튼을 세로로 배치
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // '메일을 받지 못하셨나요?' 버튼 (다음 버튼 위에 6 단위 여백)
          Padding(
            padding: EdgeInsets.only(
              left: 20 * scaleFactor,
              right: 20 * scaleFactor,
              bottom: 6 * scaleFactor,
            ),
            child: SizedBox(
              width: 131 * scaleFactor,
              height: 22 * scaleFactor,
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () => _showResendBottomSheet(context, scaleFactor),
                child: Text(
                  "메일을 받지 못하셨나요?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14 * scaleFactor,
                    fontWeight: FontWeight.w400,
                    height: 22 / 14,
                    letterSpacing: -0.025 * (14 * scaleFactor),
                    color: const Color(0xFF747784),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ),

          SaveButtonWidget(
            scaleFactor: scaleFactor,
            enabled: hasText,
            buttonText: "인증하기",
            onPressed: () {
              context.push('/emailPwInput'); // 이메일로 시작, 새비밀번호로 가입하는 페이지 파기
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20 * scaleFactor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16 * scaleFactor),
            Padding(
              padding: EdgeInsets.only(left: 0 * scaleFactor),
              child: Text(
                widget.email,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18 * scaleFactor,
                  fontWeight: FontWeight.w600,
                  height: 26 / 18,
                  letterSpacing: -0.025 * (18 * scaleFactor),
                  color: const Color(0xFFFF859B),
                ),
              ),
            ),
            SizedBox(height: 3 * scaleFactor),
            // 안내 문구 (왼쪽 정렬)
            Padding(
              padding: EdgeInsets.only(left: 0 * scaleFactor),
              child: Text(
                "본인 확인을 위해 위 이메일로 인증코드를 전송했습니다.\n인증 번호 6자를 입력해 주세요.",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 14 * scaleFactor,
                  fontWeight: FontWeight.w400,
                  height: 22 / 14,
                  letterSpacing: -0.025 * (14 * scaleFactor),
                  color: const Color(0xFF27282C),
                ),
              ),
            ),
            SizedBox(height: 36 * scaleFactor),
            // 이메일 전용 입력 위젯 (타이머, 재전송 버튼 포함)
            EmailEditFieldWidget(
              label: "인증코드",
              hintText: "6자리를 입력해 주세요.",
              controller: _emailCodeController,
              scaleFactor: scaleFactor,
              autofocus: true,
              guideMessage: guideMessage, // 필요 시 안내 문구 입력
              onResend: () {
                // 재전송 로직 구현
                debugPrint("재전송 버튼 클릭됨");
                _sendVerificationCode(); // 백엔드한테 재전송 요청 보내는 API 구현하기
              },
            ),
          ],
        ),
      ),
    );
  }
}
