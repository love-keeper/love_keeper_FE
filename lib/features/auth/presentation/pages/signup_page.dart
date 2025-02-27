import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper_fe/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:love_keeper_fe/features/members/presentation/widgets/email_edit_field_widget.dart';
import 'package:love_keeper_fe/features/members/presentation/widgets/save_button_widget.dart';

class SignupPage extends ConsumerStatefulWidget {
  final String email;
  const SignupPage({super.key, required this.email});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final TextEditingController _emailCodeController = TextEditingController();
  bool _isCodeSent = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _sendVerificationCode();

    _emailCodeController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _emailCodeController.dispose();
    super.dispose();
  }

  Future<void> _sendVerificationCode() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final code =
          await ref.read(authViewModelProvider.notifier).sendCode(widget.email);
      setState(() {
        _isCodeSent = true;
        _isLoading = false;
      });
      debugPrint('인증코드 전송됨: $code');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('인증코드가 전송되었습니다.')),
      );
    } catch (e) {
      debugPrint('Send code error: $e');
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('인증코드 전송 실패: $e')),
      );
    }
  }

  Future<void> _verifyCode() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final result = await ref.read(authViewModelProvider.notifier).verifyCode(
            widget.email,
            int.tryParse(_emailCodeController.text) ?? 0,
          );
      if (result == '인증 성공') {
        context.push('/emailPwInput'); // 다음 단계로 이동
      }
    } catch (e) {
      debugPrint('Verify code error: $e');
      setState(() {
        _emailCodeController.clear();
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('인증 실패: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    const double baseWidth = 375.0;
    final double scaleFactor = deviceWidth / baseWidth;
    final bool hasText = _emailCodeController.text.isNotEmpty;

    void showResendBottomSheet(BuildContext context, double scaleFactor) {
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
                          SizedBox(height: 44 * scaleFactor),
                          Container(
                            width: 169 * scaleFactor,
                            height: 26 * scaleFactor,
                            alignment: Alignment.topCenter,
                            child: Text(
                              '메일을 받지 못하셨나요?',
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
                              '스팸 메일함을 확인하거나,\n인증코드 재전송 버튼을 눌러 주세요.\n문제가 계속되면 1:1 카카오톡 문의를 이용해 주세요.',
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
                                    '확인',
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

    final String guideMessage = hasText && _emailCodeController.text.length == 6
        ? '인증코드가 일치하지 않습니다. 다시 입력해 주세요.'
        : '';

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
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
                onPressed: () => showResendBottomSheet(context, scaleFactor),
                child: Text(
                  '메일을 받지 못하셨나요?',
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
            enabled: hasText && !_isLoading,
            buttonText: '인증하기',
            onPressed: _isLoading ? null : _verifyCode, // 직접 전달
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
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
                Padding(
                  padding: EdgeInsets.only(left: 0 * scaleFactor),
                  child: Text(
                    '본인 확인을 위해 위 이메일로 인증코드를 전송했습니다.\n인증 번호 6자를 입력해 주세요.',
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
                EmailEditFieldWidget(
                  label: '인증코드',
                  hintText: '6자리를 입력해 주세요.',
                  controller: _emailCodeController,
                  scaleFactor: scaleFactor,
                  autofocus: true,
                  guideMessage: guideMessage,
                  onResend: _sendVerificationCode,
                ),
              ],
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
