import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper/core/config/routes/route_names.dart';
import 'package:love_keeper/core/providers/auth_state_provider.dart';
import 'package:love_keeper/features/members/presentation/widgets/edit_field_widget.dart';
import 'package:love_keeper/features/members/presentation/widgets/save_button_widget.dart';
import 'package:love_keeper/features/members/presentation/widgets/agreementbox.dart';

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

  // 체크박스 상태 (필수 항목)
  bool required1 = false; // 마스터: "전체 동의 (선택 포함)"
  bool required2 = false; // 필수: "러브키퍼 이용약관 동의 (필수)"
  bool required3 = false; // 필수: "개인정보수집 및 이용에 대한 안내 (필수)"
  bool optional = false; // 선택: "마케팅 정보 수신 (선택)"

  // 하단 버튼 활성화 조건은 필수 항목인 required2와 required3가 모두 체크되어 있어야 함
  bool get allRequiredChecked => required2 && required3;

  final RegExp passwordRegex = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*()_+\-=\[\]{};:"\\|,.<>\/?]).{8,}$',
  );
  bool showConfirmField = false;
  final bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    debugPrint('Received email from extra: ${widget.email}');
    // updateEmail 호출 제거
    _passwordFocusNode = FocusNode();
    _confirmFocusNode = FocusNode();
    _passwordController.addListener(() => setState(() {}));
    _confirmController.addListener(() => setState(() {}));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _passwordFocusNode.requestFocus();
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

  void _showTermsBottomSheet(BuildContext context, double scaleFactor) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
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
                        height: 354 * scaleFactor,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16 * scaleFactor),
                            topRight: Radius.circular(16 * scaleFactor),
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 6 * scaleFactor),
                            Container(
                              width: 50 * scaleFactor,
                              height: 5 * scaleFactor,
                              decoration: BoxDecoration(
                                color: const Color(0xFFC3C6CF),
                                borderRadius: BorderRadius.circular(
                                  26 * scaleFactor,
                                ),
                              ),
                            ),
                            SizedBox(height: 33 * scaleFactor),
                            Center(
                              child: Text(
                                '약관동의',
                                style: TextStyle(
                                  fontSize: 18 * scaleFactor,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF27282C),
                                  height: 26 / (18 * scaleFactor),
                                  letterSpacing: -0.4 * scaleFactor,
                                ),
                              ),
                            ),
                            SizedBox(height: 29 * scaleFactor),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                buildAgreementRow(
                                  '전체 동의 (선택 포함)',
                                  scaleFactor,
                                  isChecked: required1,
                                  onChanged: (value) {
                                    setState(() {
                                      required1 = value;
                                      required2 = value;
                                      required3 = value;
                                      optional = value;
                                    });
                                    setModalState(() {});
                                  },
                                ),
                                SizedBox(height: 10 * scaleFactor),
                                buildAgreementRow(
                                  '러브키퍼 이용약관 동의 (필수)',
                                  scaleFactor,
                                  isChecked: required2,
                                  onChanged: (value) {
                                    setState(() {
                                      required2 = value;
                                      required1 =
                                          required2 && required3 && optional;
                                    });
                                    setModalState(() {});
                                  },
                                ),
                                SizedBox(height: 10 * scaleFactor),
                                buildAgreementRow(
                                  '개인정보수집 및 이용에 대한 안내 (필수)',
                                  scaleFactor,
                                  isChecked: required3,
                                  onChanged: (value) {
                                    setState(() {
                                      required3 = value;
                                      required1 =
                                          required2 && required3 && optional;
                                    });
                                    setModalState(() {});
                                  },
                                ),
                                SizedBox(height: 10 * scaleFactor),
                                buildAgreementRow(
                                  '마케팅 정보 수신 (선택)',
                                  scaleFactor,
                                  required: false,
                                  isChecked: optional,
                                  onChanged: (value) {
                                    setState(() {
                                      optional = value;
                                    });
                                    setModalState(() {});
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 27 * scaleFactor),
                            GestureDetector(
                              onTap: () {
                                if (required2 && required3) {
                                  // 상태 업데이트를 여기서 처리
                                  ref
                                      .read(authStateNotifierProvider.notifier)
                                      .updatePassword(_passwordController.text);
                                  ref
                                      .read(authStateNotifierProvider.notifier)
                                      .updateAgreements(
                                        privacyPolicyAgreed: required3,
                                        marketingAgreed: optional,
                                        termsOfServiceAgreed: required2,
                                      );
                                  if (widget.email != null) {
                                    ref
                                        .read(
                                          authStateNotifierProvider.notifier,
                                        )
                                        .updateEmail(widget.email!);
                                  }
                                  Navigator.pop(dialogContext);
                                  debugPrint(
                                    'Pushing to: /profileRegistration with email: ${widget.email}',
                                  );
                                  context.push(
                                    '/profileRegistration',
                                    extra: {
                                      'email': widget.email,
                                      'provider': 'LOCAL',
                                      'providerId': null,
                                    },
                                  );
                                }
                              },
                              child: Container(
                                width: 334 * scaleFactor,
                                height: 52 * scaleFactor,
                                decoration: BoxDecoration(
                                  color:
                                      (required2 && required3)
                                          ? const Color(0xFFFF859B)
                                          : const Color(0xFFC3C6CF),
                                  borderRadius: BorderRadius.circular(
                                    55 * scaleFactor,
                                  ),
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
                                      letterSpacing:
                                          -0.025 * (16 * scaleFactor),
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
                  onPressed:
                      _isLoading
                          ? null
                          : () async {
                            debugPrint(
                              'Next button pressed: showConfirmField=$showConfirmField',
                            );
                            if (!showConfirmField) {
                              if (hasPassword &&
                                  passwordRegex.hasMatch(
                                    _passwordController.text,
                                  )) {
                                setState(() {
                                  showConfirmField = true;
                                });
                                WidgetsBinding.instance.addPostFrameCallback((
                                  _,
                                ) {
                                  _confirmFocusNode.requestFocus();
                                });
                              }
                            } else {
                              if (hasPassword &&
                                  hasConfirm &&
                                  _passwordController.text ==
                                      _confirmController.text) {
                                debugPrint('Opening terms bottom sheet');
                                _showTermsBottomSheet(context, scaleFactor);
                              }
                            }
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
