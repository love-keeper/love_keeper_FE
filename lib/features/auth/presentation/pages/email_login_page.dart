import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper_fe/features/members/presentation/widgets/edit_field_widget.dart';
import 'package:love_keeper_fe/features/members/presentation/widgets/save_button_widget.dart';

class EmailLoginPage extends StatefulWidget {
  const EmailLoginPage({super.key});

  @override
  _EmailLoginPageState createState() => _EmailLoginPageState();
}

class _EmailLoginPageState extends State<EmailLoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // 상태 변수: 비밀번호 입력필드 표시 여부
  bool showPasswordField = false;
  // 비밀번호 가이드 메시지 표시 여부 (로그인 버튼 클릭 후 비밀번호가 틀릴 때 true)
  bool showPasswordGuide = false;

  // 디버그용 백엔드 값 (실제 구현 시 백엔드 연동)
  static const String debugEmail = '000@gmail.com';
  static const String debugPassword = 'password123';

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      // 이메일 입력 변경 시 상태 업데이트 및 비밀번호 가이드 숨김
      setState(() {
        showPasswordGuide = false;
      });
    });
    _passwordController.addListener(() {
      // 비밀번호 입력 변경 시 가이드 메시지 숨김
      setState(() {
        showPasswordGuide = false;
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 화면 너비에 따른 scaleFactor 계산 (기준: 375)
    final double deviceWidth = MediaQuery.of(context).size.width;
    const double baseWidth = 375.0;
    final double scaleFactor = deviceWidth / baseWidth;

    final bool hasEmail = _emailController.text.isNotEmpty;
    final bool hasPassword = _passwordController.text.isNotEmpty;

    // 이메일 형식 정규식
    final RegExp emailRegex = RegExp(
      r'^[^@]+@[^@]+\.(com|net|org|edu|co\.kr|ac\.kr)$',
      caseSensitive: false,
    );

    final String emailGuideMessage =
        hasEmail && !emailRegex.hasMatch(_emailController.text)
            ? '올바른 이메일 형식을 입력해 주세요.'
            : '';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text('이메일로 시작'),
        titleTextStyle: TextStyle(
          fontSize: 18 * scaleFactor,
          fontWeight: FontWeight.w600,
          height: 26 / 18,
          letterSpacing: -0.45 * scaleFactor,
          color: const Color(0xFF27282C),
        ),
        leading: IconButton(
          icon: Image.asset(
            'assets/images/letter_page/Ic_Back.png',
            width: 24 * scaleFactor,
            height: 24 * scaleFactor,
          ),
          onPressed: () => context.pop(), // 온보딩으로 가는 로직 넣기
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showPasswordField) // 비밀번호 입력 필드가 보일 때만 표시
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
                  onPressed: () {
                    // 비밀번호 찾기 화면으로 이동
                    context.push('/pwFinding');
                  },
                  child: Text(
                    '비밀번호를 잊으셨나요?',
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
            enabled: showPasswordField ? (hasEmail && hasPassword) : hasEmail,
            buttonText: showPasswordField ? '로그인' : '다음',
            onPressed: () {
              if (!showPasswordField) {
                if (_emailController.text == debugEmail &&
                    emailRegex.hasMatch(_emailController.text)) {
                  setState(() {
                    showPasswordField = true;
                  });
                } else {
                  context
                      .push('/signup', extra: {'email': _emailController.text});
                }
              } else {
                if (hasPassword && _passwordController.text == debugPassword) {
                  context.go('/mainPage');
                } else {
                  setState(() {
                    showPasswordGuide = true;
                  });
                }
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20 * scaleFactor),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16 * scaleFactor),
              // 이메일 입력 위젯 (EditFieldWidget 재사용)
              EditFieldWidget(
                label: '이메일',
                hintText: '이메일 주소를 입력해 주세요.',
                controller: _emailController,
                scaleFactor: scaleFactor,
                autofocus: true,
                guideMessage: emailGuideMessage,
                // 이메일 필드는 비밀번호 입력 단계부터 수정 불가능하게 처리
                readOnly:
                    showPasswordField, // 만약 readOnly 속성이 EditFieldWidget에서 구현되어 있다면
              ),
              // 이메일 조건에 맞고 가입된 이메일이면 비밀번호 입력 필드 추가
              if (showPasswordField) ...[
                SizedBox(height: 36 * scaleFactor),
                // 비밀번호 입력 위젯 (EditFieldWidget 재사용, obscureText: true로 설정)
                EditFieldWidget(
                  label: '비밀번호',
                  hintText: '비밀번호를 입력해 주세요.',
                  controller: _passwordController,
                  scaleFactor: scaleFactor,
                  autofocus: false,
                  guideMessage:
                      showPasswordGuide ? '비밀번호가 일치하지 않습니다. 다시 입력해 주세요.' : '',
                  obscureText:
                      true, // 여기서 비밀번호는 *로 표시 (EditFieldWidget에 해당 인자 구현되어 있다고 가정)
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
