import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper_fe/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:love_keeper_fe/features/members/presentation/widgets/edit_field_widget.dart';
import 'package:love_keeper_fe/features/members/presentation/widgets/save_button_widget.dart';

class PwFindingPage extends ConsumerStatefulWidget {
  const PwFindingPage({super.key});

  @override
  _PwFindingPageState createState() => _PwFindingPageState();
}

class _PwFindingPageState extends ConsumerState<PwFindingPage> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

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

  void _showConfirmationBottomSheet(BuildContext context, double scaleFactor) {
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
                        Container(
                          width: 171 * scaleFactor,
                          height: 26 * scaleFactor,
                          alignment: Alignment.topCenter,
                          child: Text(
                            '이메일이 발송되었습니다',
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
                            '메일이 도착하지 않았다면,\n스팸 메일함을 확인하거나 재전송 버튼을 눌러 주세요.\n문제가 계속되면 1:1 카카오톡 문의를 이용해 주세요.',
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

  Future<void> _resetPasswordRequest() async {
    if (!emailRegex.hasMatch(_emailController.text)) return;

    setState(() {
      _isLoading = true;
    });
    try {
      final result = await ref
          .read(authViewModelProvider.notifier)
          .resetPasswordRequest(_emailController.text);
      setState(() {
        _isLoading = false;
      });
      if (result == '비밀번호 변경 링크가 이메일로 발송되었습니다.') {
        final scaleFactor = MediaQuery.of(context).size.width / 375.0;
        _showConfirmationBottomSheet(context, scaleFactor);
      }
    } catch (e) {
      debugPrint('Reset password request error: $e');
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('비밀번호 재설정 요청 실패: $e')),
      );
    }
  }

  final RegExp emailRegex = RegExp(
    r'^[^@]+@[^@]+\.(com|net|org|edu|co\.kr|ac\.kr)$',
    caseSensitive: false,
  );

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    const double baseWidth = 375.0;
    final double scaleFactor = deviceWidth / baseWidth;
    final bool hasText = _emailController.text.isNotEmpty;

    final String guideMessage =
        hasText && !emailRegex.hasMatch(_emailController.text)
            ? '올바른 이메일 형식을 입력해 주세요.'
            : '';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          '비밀번호 찾기',
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
        enabled: hasText && !_isLoading,
        buttonText: '이메일 보내기',
        onPressed: _isLoading ? null : _resetPasswordRequest,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20 * scaleFactor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16 * scaleFactor),
                Text(
                  '비밀번호 재설정을 위한 인증 메일이 전송됩니다.\n메일에 포함된 링크를 클릭하여 비밀번호를 재설정해 주세요.',
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
                EditFieldWidget(
                  label: '이메일',
                  hintText: '가입하신 이메일 주소를 입력해 주세요.',
                  controller: _emailController,
                  scaleFactor: scaleFactor,
                  autofocus: true,
                  guideMessage: guideMessage,
                ),
                SizedBox(height: 6 * scaleFactor),
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
                      onPressed: _isLoading ? null : _resetPasswordRequest,
                      child: Text(
                        '재전송',
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
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
