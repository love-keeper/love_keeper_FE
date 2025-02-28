import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper_fe/core/config/routes/route_names.dart';
import 'package:love_keeper_fe/core/providers/auth_state_provider.dart';
import 'package:love_keeper_fe/features/members/presentation/widgets/edit_field_widget.dart';
import 'package:love_keeper_fe/features/members/presentation/widgets/save_button_widget.dart';

class EmailPasswordInputPage extends ConsumerStatefulWidget {
  const EmailPasswordInputPage({super.key});

  @override
  _EmailPasswordInputPageState createState() => _EmailPasswordInputPageState();
}

class _EmailPasswordInputPageState
    extends ConsumerState<EmailPasswordInputPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final RegExp passwordRegex = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*()_+\-=\[\]{};:"\\|,.<>\/?]).{8,}$',
  );
  bool showConfirmField = false;
  final bool _isLoading = false;

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
      backgroundColor: Colors.transparent,
      isDismissible: true,
      builder: (BuildContext dialogContext) {
        return GestureDetector(
          onTap: () => Navigator.pop(dialogContext),
          behavior: HitTestBehavior.opaque,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.transparent,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {},
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
                        Center(
                          child: Text(
                            '전체 동의 (선택 포함)',
                            style: TextStyle(
                              fontSize: 16 * scaleFactor,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF27282C),
                              height: 24 / (16 * scaleFactor),
                              letterSpacing: -0.025 * (16 * scaleFactor),
                            ),
                          ),
                        ),
                        SizedBox(height: 40 * scaleFactor),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(dialogContext);
                            // AuthStateProvider에 비밀번호 저장
                            ref
                                .read(authStateNotifierProvider.notifier)
                                .updatePassword(_passwordController.text);
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
                                  height: 24 / (16 * scaleFactor),
                                  letterSpacing: -0.025 * (16 * scaleFactor),
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
    final double deviceWidth = MediaQuery.of(context).size.width;
    const double baseWidth = 375.0;
    final double scaleFactor = deviceWidth / baseWidth;

    final bool hasPassword = _passwordController.text.isNotEmpty;
    final bool hasConfirm = _confirmController.text.isNotEmpty;

    final String passwordGuideMessage =
        hasPassword && !passwordRegex.hasMatch(_passwordController.text)
            ? '비밀번호가 조건을 충족하지 않습니다. 다시 입력해 주세요.'
            : '';

    final String confirmGuideMessage = showConfirmField &&
            hasConfirm &&
            (_confirmController.text != _passwordController.text)
        ? '비밀번호가 일치하지 않습니다. 다시 입력해 주세요.'
        : '';

    final bool isButtonEnabled = showConfirmField
        ? (hasPassword &&
            hasConfirm &&
            passwordRegex.hasMatch(_passwordController.text) &&
            (_passwordController.text == _confirmController.text) &&
            !_isLoading)
        : (hasPassword &&
            passwordRegex.hasMatch(_passwordController.text) &&
            !_isLoading);

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
        onPressed: _isLoading
            ? null
            : () async {
                if (!showConfirmField) {
                  if (hasPassword &&
                      passwordRegex.hasMatch(_passwordController.text)) {
                    setState(() {
                      showConfirmField = true;
                    });
                  }
                } else {
                  if (hasPassword &&
                      hasConfirm &&
                      _passwordController.text == _confirmController.text) {
                    _showTermsBottomSheet(context, scaleFactor);
                  }
                }
              },
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20 * scaleFactor),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16 * scaleFactor),
                  EditFieldWidget(
                    label: '비밀번호',
                    hintText: '8자 이상 영문/숫자/특수문자 포함',
                    controller: _passwordController,
                    scaleFactor: scaleFactor,
                    autofocus: true,
                    guideMessage: passwordGuideMessage,
                    obscureText: true,
                  ),
                  if (showConfirmField) ...[
                    SizedBox(height: 36 * scaleFactor),
                    EditFieldWidget(
                      label: '비밀번호 확인',
                      hintText: '비밀번호를 다시 입력해 주세요',
                      controller: _confirmController,
                      scaleFactor: scaleFactor,
                      autofocus: false,
                      guideMessage: confirmGuideMessage,
                      obscureText: true,
                    ),
                  ],
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
