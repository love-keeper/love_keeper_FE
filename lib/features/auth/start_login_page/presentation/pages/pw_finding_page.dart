import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper_fe/features/auth/my_page/presentation/widgets/edit_field_widget.dart';
import 'package:love_keeper_fe/features/auth/my_page/presentation/widgets/save_button_widget.dart';

class PwFindingPage extends StatefulWidget {
  const PwFindingPage({super.key});
  @override
  _PwFindingPageState createState() => _PwFindingPageState();
}

class _PwFindingPageState extends State<PwFindingPage> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  // "이메일 보내기" 버튼을 누르면 나타나는 바텀시트 (375x288, 내부에 "확인" 버튼)
  void _showConfirmationBottomSheet(BuildContext context, double scaleFactor) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // 배경을 투명하게
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
                        SizedBox(height: 48 * scaleFactor),
                        Container(
                          width: 171 * scaleFactor,
                          height: 26 * scaleFactor,
                          alignment: Alignment.topCenter,
                          child: Text(
                            "이메일이 발송되었습니다",
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
                            "메일이 도착하지 않았다면,\n스팸 메일함을 확인하거나 재전송 버튼을 눌러 주세요.\n문제가 계속되면 1:1 카카오톡 문의를 이용해 주세요.",
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
                        // "확인" 버튼
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(dialogContext);
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
                                    letterSpacing: -0.025 * (16 * scaleFactor),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
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

  @override
  Widget build(BuildContext context) {
    // 화면 너비에 따른 scaleFactor 계산 (기준: 375)
    final double deviceWidth = MediaQuery.of(context).size.width;
    const double baseWidth = 375.0;
    final double scaleFactor = deviceWidth / baseWidth;
    final bool hasText = _emailController.text.isNotEmpty;
    // 이메일 형식 정규식 (보편적인 형식: @와 .com, .net, .org, .edu 등 포함)
    final RegExp emailRegex = RegExp(
        r'^[^@]+@[^@]+\.(com|net|org|edu|co\.kr|ac\.kr)$',
        caseSensitive: false);

    // 입력 도중에 형식이 올바르지 않으면 가이드 문구 설정
    final String guideMessage =
        hasText && !emailRegex.hasMatch(_emailController.text)
            ? "올바른 이메일 형식을 입력해 주세요."
            : "";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "비밀번호 찾기",
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
      bottomNavigationBar: SaveButtonWidget(
        scaleFactor: scaleFactor,
        enabled: hasText,
        buttonText: "이메일 보내기",
        onPressed: () => _showConfirmationBottomSheet(context, scaleFactor),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20 * scaleFactor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 앱바 바로 아래에 안내 문구 추가 (16 단위 여백 후)
            SizedBox(height: 16 * scaleFactor),
            Text(
              "비밀번호 재설정을 위한 인증 메일이 전송됩니다.\n메일에 포함된 링크를 클릭하여 비밀번호를 재설정해 주세요.",
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
            // EditFieldWidget을 사용하여 이메일 입력 필드를 표시
            EditFieldWidget(
              label: "이메일",
              hintText: "가입하신 이메일 주소를 입력해 주세요.",
              controller: _emailController,
              scaleFactor: scaleFactor,
              autofocus: true, // 페이지 진입 시 키보드 활성화
              guideMessage: guideMessage, // 추가 안내 문구가 필요하면 입력
            ),
            SizedBox(height: 6 * scaleFactor),
            // 재전송 버튼을 오른쪽 정렬하여 텍스트 필드 바로 아래에 배치 (가로 크기 131x22)
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 36 * scaleFactor,
                height: 22 * scaleFactor,
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () =>
                      _showConfirmationBottomSheet(context, scaleFactor),
                  child: Text(
                    "재전송",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14 * scaleFactor,
                      fontWeight: FontWeight.w600,
                      height: 22 / 14,
                      letterSpacing: -0.025 * (14 * scaleFactor),
                      color: const Color(0xFFFF859B),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
