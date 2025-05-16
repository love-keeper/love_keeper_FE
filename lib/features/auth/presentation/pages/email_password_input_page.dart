import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper/core/config/routes/route_names.dart';
import 'package:love_keeper/core/providers/auth_state_provider.dart';
import 'package:love_keeper/features/members/presentation/widgets/edit_field_widget.dart';
import 'package:love_keeper/features/members/presentation/widgets/save_button_widget.dart';

class EmailPasswordInputPage extends ConsumerStatefulWidget {
  final String? email;
  const EmailPasswordInputPage({this.email, super.key});

  @override
  _EmailPasswordInputPageState createState() => _EmailPasswordInputPageState();
}

class _EmailPasswordInputPageState
    extends ConsumerState<EmailPasswordInputPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  late FocusNode _passwordFocusNode;
  late FocusNode _confirmFocusNode;

  final RegExp passwordRegex = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*()_+\-=\[\]{};:"\\|,.<>\/?]).{8,}$',
  );
  bool showConfirmField = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    debugPrint('Received email from extra: ${widget.email}');
    _passwordFocusNode = FocusNode();
    _confirmFocusNode = FocusNode();
    _passwordController.addListener(() => setState(() {}));
    _confirmController.addListener(() => setState(() {}));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _passwordFocusNode.requestFocus();
      if (widget.email != null) {
        ref.read(authStateNotifierProvider.notifier).updateEmail(widget.email!);
      }
      ref.read(authStateNotifierProvider.notifier).updateProvider('LOCAL');
      ref.read(authStateNotifierProvider.notifier).updateProviderId(null);
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    _passwordFocusNode.dispose();
    _confirmFocusNode.dispose();
    super.dispose();
  }

  void _onNextPressed() async {
    if (_isLoading) return;

    debugPrint('Next button pressed: showConfirmField=$showConfirmField');
    if (!showConfirmField) {
      if (_passwordController.text.isNotEmpty &&
          passwordRegex.hasMatch(_passwordController.text)) {
        setState(() {
          showConfirmField = true;
        });
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _confirmFocusNode.requestFocus();
        });
      }
    } else {
      if (_passwordController.text == _confirmController.text &&
          _passwordController.text.isNotEmpty) {
        setState(() => _isLoading = true);
        try {
          ref
              .read(authStateNotifierProvider.notifier)
              .updatePassword(_passwordController.text);
          context.push(RouteNames.profileRegistrationPage);
        } finally {
          if (mounted) {
            setState(() => _isLoading = false);
          }
        }
      } else {
        debugPrint('Passwords do not match or are empty');
      }
    }
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

    final String confirmGuideMessage =
        showConfirmField &&
                hasConfirm &&
                (_confirmController.text != _passwordController.text)
            ? '비밀번호가 일치하지 않습니다. 다시 입력해 주세요.'
            : '';

    final bool isButtonEnabled =
        showConfirmField
            ? (hasPassword &&
                hasConfirm &&
                passwordRegex.hasMatch(_passwordController.text) &&
                (_passwordController.text == _confirmController.text) &&
                !_isLoading)
            : (hasPassword &&
                passwordRegex.hasMatch(_passwordController.text) &&
                !_isLoading);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
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
        body: Column(
          children: [
            Expanded(
              child: Stack(
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
                            focusNode: _passwordFocusNode,
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
                              focusNode: _confirmFocusNode,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  if (_isLoading)
                    const Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(bottom: 12 * scaleFactor),
                child: SaveButtonWidget(
                  scaleFactor: scaleFactor,
                  enabled: isButtonEnabled,
                  buttonText: '다음',
                  onPressed: () async {
                    _onNextPressed();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
