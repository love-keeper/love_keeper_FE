import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper_fe/core/config/routes/route_names.dart';
import 'package:love_keeper_fe/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:love_keeper_fe/features/members/presentation/widgets/edit_field_widget.dart';
import 'package:love_keeper_fe/features/members/presentation/widgets/save_button_widget.dart';

class EmailLoginPage extends ConsumerStatefulWidget {
  const EmailLoginPage({super.key});

  @override
  _EmailLoginPageState createState() => _EmailLoginPageState();
}

class _EmailLoginPageState extends ConsumerState<EmailLoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool showPasswordField = false;
  bool showPasswordGuide = false;

  static const String debugEmail = '000@gmail.com';
  static const String debugPassword = 'password123';

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      setState(() {
        showPasswordGuide = false;
      });
    });
    _passwordController.addListener(() {
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
    final double deviceWidth = MediaQuery.of(context).size.width;
    const double baseWidth = 375.0;
    final double scaleFactor = deviceWidth / baseWidth;

    final bool hasEmail = _emailController.text.isNotEmpty;
    final bool hasPassword = _passwordController.text.isNotEmpty;

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
          onPressed: () => context.pop(),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showPasswordField)
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
            onPressed: () async {
              if (!showPasswordField) {
                if (!emailRegex.hasMatch(_emailController.text)) {
                  return; // 이메일 형식이 맞지 않으면 동작 중지
                }
                try {
                  final result = await ref
                      .read(authViewModelProvider.notifier)
                      .emailDuplication(_emailController.text);
                  if (result == '사용 가능한 이메일입니다.') {
                    // 중복이 아니면 인증 페이지로 이동
                    context.push(RouteNames.newEmailcertification,
                        extra: {'email': _emailController.text});
                  } else {
                    // 중복이면 비밀번호 입력 필드 표시
                    setState(() {
                      showPasswordField = true;
                    });
                  }
                } catch (e) {
                  // 중복된 경우 (예: COMMON409) 비밀번호 입력 필드 표시
                  setState(() {
                    showPasswordField = true;
                  });
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
              EditFieldWidget(
                label: '이메일',
                hintText: '이메일 주소를 입력해 주세요.',
                controller: _emailController,
                scaleFactor: scaleFactor,
                autofocus: true,
                guideMessage: emailGuideMessage,
                readOnly: showPasswordField,
              ),
              if (showPasswordField) ...[
                SizedBox(height: 36 * scaleFactor),
                EditFieldWidget(
                  label: '비밀번호',
                  hintText: '비밀번호를 입력해 주세요.',
                  controller: _passwordController,
                  scaleFactor: scaleFactor,
                  autofocus: false,
                  guideMessage:
                      showPasswordGuide ? '비밀번호가 일치하지 않습니다. 다시 입력해 주세요.' : '',
                  obscureText: true,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
