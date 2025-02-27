import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper_fe/features/members/presentation/widgets/edit_field_widget.dart';
import 'package:love_keeper_fe/features/members/presentation/widgets/save_button_widget.dart';

class EmailPasswordInputPage extends StatefulWidget {
  const EmailPasswordInputPage({super.key});

  @override
  _EmailPasswordInputPageState createState() => _EmailPasswordInputPageState();
}

class _EmailPasswordInputPageState extends State<EmailPasswordInputPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  // 비밀번호 조건: 최소 8자 이상, 영문, 숫자, 특수문자 포함
  final RegExp passwordRegex = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*()_+\-=\[\]{};:"\\|,.<>\/?]).{8,}$',
  );
  // 비밀번호 확인 필드를 보여줄지 여부
  bool showConfirmField = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      setState(() {});
    });
    _confirmController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _showTermsBottomSheet(BuildContext context, double scaleFactor) {
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
                        // 큰 텍스트: 약관동의
                        Center(
                          child: Text(
                            '약관동의',
                            style: TextStyle(
                              fontSize: 20 * scaleFactor,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF27282C),
                            ),
                          ),
                        ),
                        SizedBox(height: 40 * scaleFactor),
                        // 작은 텍스트: 전체 동의 (선택 포함)
                        Center(
                          child: Text(
                            '전체 동의 (선택 포함)',
                            style: TextStyle(
                              fontSize: 16 * scaleFactor,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF27282C),
                            ),
                          ),
                        ),
                        SizedBox(height: 40 * scaleFactor),
                        //const Spacer(),
                        // 하단 버튼: 동의하고 계속하기
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(dialogContext);
                            // 프로필 등록 화면으로 이동 (이전 스택 삭제)
                            context.push('/profileRegistration');
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
                                '동의하고 계속하기',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16 * scaleFactor,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16 * scaleFactor),
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

    final bool hasPassword = _passwordController.text.isNotEmpty;
    final bool hasConfirm = _confirmController.text.isNotEmpty;

    // 비밀번호가 조건을 만족하지 않으면 가이드 메시지 출력
    final String passwordGuideMessage =
        hasPassword && !passwordRegex.hasMatch(_passwordController.text)
            ? '비밀번호가 조건을 충족하지 않습니다. 다시 입력해 주세요.'
            : '';

    // 비밀번호 확인 필드의 경우, 입력된 내용이 비밀번호와 다르면 가이드 메시지 출력
    final String confirmGuideMessage = showConfirmField &&
            hasConfirm &&
            (_confirmController.text != _passwordController.text)
        ? '비밀번호가 일치하지 않습니다. 다시 입력해 주세요.'
        : '';

    // 버튼 활성화 조건:
    // - 아직 비밀번호 확인 필드가 안 보일 경우: 비밀번호 필드가 채워지고 정규식을 만족하면 활성화
    // - 비밀번호 확인 필드가 보이면: 두 필드 모두 채워지고, 비밀번호가 정규식에 부합하며 두 값이 일치해야 활성화
    final bool isButtonEnabled = showConfirmField
        ? (hasPassword &&
            hasConfirm &&
            passwordRegex.hasMatch(_passwordController.text) &&
            (_passwordController.text == _confirmController.text))
        : (hasPassword && passwordRegex.hasMatch(_passwordController.text));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          '이메일로 시작',
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
        enabled: isButtonEnabled,
        buttonText: '다음',
        onPressed: () {
          if (!showConfirmField) {
            // 아직 비밀번호 확인 필드가 보이지 않는 경우:
            // 비밀번호 조건이 충족되면 확인 필드를 추가로 표시
            if (hasPassword &&
                passwordRegex.hasMatch(_passwordController.text)) {
              setState(() {
                showConfirmField = true;
              });
            } else {
              setState(() {}); // 상태 업데이트 (가이드 메시지가 이미 표시됨)
            }
          } else {
            // 비밀번호 확인 필드가 보이는 경우:
            if (hasPassword &&
                hasConfirm &&
                _passwordController.text == _confirmController.text) {
              // 비밀번호 확인 조건이 충족되면
              _showTermsBottomSheet(context, scaleFactor);
            } else {
              setState(() {}); // 상태 업데이트하여 가이드 메시지 표시
            }
          }
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20 * scaleFactor),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16 * scaleFactor),
              // 비밀번호 입력 필드
              EditFieldWidget(
                label: '비밀번호',
                hintText: '8자 이상 영문/숫자/특수문자 포함',
                controller: _passwordController,
                scaleFactor: scaleFactor,
                autofocus: true,
                guideMessage: passwordGuideMessage,
                obscureText: true, // 입력 시 * 로 표시
              ),
              // 비밀번호 확인 입력 필드 (조건 충족 시 추가)
              if (showConfirmField) ...[
                SizedBox(height: 36 * scaleFactor),
                EditFieldWidget(
                  label: '비밀번호 확인',
                  hintText: '비밀번호를 다시 입력해 주세요',
                  controller: _confirmController,
                  scaleFactor: scaleFactor,
                  autofocus: false,
                  guideMessage: confirmGuideMessage,
                  obscureText: true, // 입력 시 * 로 표시
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
