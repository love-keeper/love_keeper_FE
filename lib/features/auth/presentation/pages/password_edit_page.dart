import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper_fe/core/config/routes/route_names.dart';
import 'package:love_keeper_fe/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:love_keeper_fe/features/members/presentation/widgets/edit_field_widget.dart';
import 'package:love_keeper_fe/features/members/presentation/widgets/save_button_widget.dart';

class PasswordEditPage extends ConsumerStatefulWidget {
  final String email;
  final String code;

  const PasswordEditPage({super.key, required this.email, required this.code});

  @override
  _PasswordEditPageState createState() => _PasswordEditPageState();
}

class _PasswordEditPageState extends ConsumerState<PasswordEditPage> {
  final TextEditingController _newPwController = TextEditingController();
  final TextEditingController _confirmNewPwController = TextEditingController();
  bool _isLoading = false;

  final RegExp newPasswordRegex = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*()_+\-=\[\]{};:"\\|,.<>\/?]).{8,}$',
  );

  @override
  void initState() {
    super.initState();
    _newPwController.addListener(() => setState(() {}));
    _confirmNewPwController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _newPwController.dispose();
    _confirmNewPwController.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    final newPw = _newPwController.text;
    final confirmPw = _confirmNewPwController.text;

    setState(() {
      _isLoading = true;
    });
    try {
      await ref.read(authViewModelProvider.notifier).resetPassword(
            widget.email,
            newPw,
            confirmPw,
          );
      setState(() {
        _isLoading = false;
      });
      context.go(RouteNames.emailLoginPage);
    } catch (e) {
      debugPrint('Reset password error: $e');
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('비밀번호 변경 실패: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    const double baseWidth = 375.0;
    final double scaleFactor = deviceWidth / baseWidth;

    final String newPw = _newPwController.text;
    final String confirmPw = _confirmNewPwController.text;

    String newPwGuideMessage = '';
    if (newPw.isNotEmpty && !newPasswordRegex.hasMatch(newPw)) {
      newPwGuideMessage = '비밀번호가 조건을 충족하지 않습니다. 다시 입력해 주세요.';
    }

    String confirmPwGuideMessage = '';
    if (confirmPw.isNotEmpty && confirmPw != newPw) {
      confirmPwGuideMessage = '비밀번호가 일치하지 않습니다. 다시 입력해 주세요.';
    }

    final bool isSaveEnabled = newPw.isNotEmpty &&
        confirmPw.isNotEmpty &&
        newPwGuideMessage.isEmpty &&
        confirmPwGuideMessage.isEmpty &&
        !_isLoading;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          '비밀번호 재설정',
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
        enabled: isSaveEnabled,
        buttonText: '변경하기',
        onPressed: _isLoading ? null : _resetPassword,
      ),
      body: Stack(
        children: [
          GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20 * scaleFactor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16 * scaleFactor),
                  EditFieldWidget(
                    label: '새 비밀번호',
                    hintText: '8자 이상 영문/숫자/특수문자 포함',
                    controller: _newPwController,
                    scaleFactor: scaleFactor,
                    autofocus: true,
                    guideMessage: newPwGuideMessage,
                    obscureText: true,
                  ),
                  SizedBox(height: 36 * scaleFactor),
                  EditFieldWidget(
                    label: '비밀번호 확인',
                    hintText: '비밀번호를 다시 입력해 주세요',
                    controller: _confirmNewPwController,
                    scaleFactor: scaleFactor,
                    autofocus: false,
                    guideMessage: confirmPwGuideMessage,
                    obscureText: true,
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
