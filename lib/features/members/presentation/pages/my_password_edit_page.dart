import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper/features/members/presentation/viewmodels/members_viewmodel.dart';
import 'package:love_keeper/features/members/presentation/widgets/edit_field_widget.dart';
import 'package:love_keeper/features/members/presentation/widgets/save_button_widget.dart';

class MyPasswordEditPage extends ConsumerStatefulWidget {
  const MyPasswordEditPage({super.key});

  @override
  _MyPasswordEditPageState createState() => _MyPasswordEditPageState();
}

class _MyPasswordEditPageState extends ConsumerState<MyPasswordEditPage> {
  final TextEditingController _currentPwController = TextEditingController();
  final TextEditingController _newPwController = TextEditingController();
  final TextEditingController _confirmNewPwController = TextEditingController();
  late FocusNode _currentPwFocusNode;
  bool _isLoading = false;

  // ① 서버 에러 MEMBER042 처리용 가이드 메시지
  String _currentPwGuideMessage = '';

  final RegExp newPasswordRegex = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*()_+\-=\[\]{};:"\\|,.<>\/?]).{8,}$',
  );

  @override
  void initState() {
    super.initState();
    _currentPwFocusNode = FocusNode();

    // ② 입력할 때마다 가이드 메시지 초기화
    _currentPwController.addListener(() {
      if (_currentPwGuideMessage.isNotEmpty) {
        setState(() => _currentPwGuideMessage = '');
      }
      setState(() {}); // 버튼 활성화 체크용
    });
    _newPwController.addListener(() => setState(() {}));
    _confirmNewPwController.addListener(() => setState(() {}));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _currentPwFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _currentPwController.dispose();
    _newPwController.dispose();
    _confirmNewPwController.dispose();
    _currentPwFocusNode.dispose();
    super.dispose();
  }

  Future<void> _updatePassword() async {
    final currentPw = _currentPwController.text;
    final newPw = _newPwController.text;
    final confirmPw = _confirmNewPwController.text;

    // 클라이언트 검증
    if (newPw != confirmPw) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('새 비밀번호가 일치하지 않습니다.')));
      return;
    }
    if (!newPasswordRegex.hasMatch(newPw)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('비밀번호는 8자 이상, 영문/숫자/특수문자를 포함해야 합니다.')),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      final result = await ref
          .read(membersViewModelProvider.notifier)
          .updatePassword(currentPw, newPw, confirmPw);
      setState(() => _isLoading = false);

      if (result == '비밀번호 변경 성공') {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('비밀번호가 성공적으로 변경되었습니다.')));
        context.pop();
      }
    } catch (e) {
      setState(() => _isLoading = false);

      // ③ 서버 에러 MEMBER042일 때만 필드 밑 가이드 메시지로 표시
      if (e is DioException &&
          e.response?.data is Map<String, dynamic> &&
          e.response!.data['code'] == 'MEMBER042') {
        setState(() {
          _currentPwGuideMessage = '현재 비밀번호가 일치하지 않습니다.';
        });
        ref.invalidate(membersViewModelProvider);
      } else {
        // 그 외 에러는 SnackBar
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('비밀번호 변경 실패: ${e.toString()}')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    const baseWidth = 375.0;
    final scaleFactor = deviceWidth / baseWidth;

    final currentPw = _currentPwController.text;
    final newPw = _newPwController.text;
    final confirmPw = _confirmNewPwController.text;

    final currentPwGuideMsg = _currentPwGuideMessage;
    final newPwGuideMsg =
        (newPw.isNotEmpty && !newPasswordRegex.hasMatch(newPw))
            ? '비밀번호가 조건을 충족하지 않습니다. 다시 입력해 주세요.'
            : '';
    final confirmPwGuideMsg =
        (confirmPw.isNotEmpty && confirmPw != newPw)
            ? '비밀번호가 일치하지 않습니다. 다시 입력해 주세요.'
            : '';

    final isSaveEnabled =
        currentPw.isNotEmpty &&
        newPw.isNotEmpty &&
        confirmPw.isNotEmpty &&
        currentPwGuideMsg.isEmpty &&
        newPwGuideMsg.isEmpty &&
        confirmPwGuideMsg.isEmpty &&
        !_isLoading;

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
            '비밀번호 변경',
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16 * scaleFactor),
                        EditFieldWidget(
                          label: '현재 비밀번호',
                          hintText: '현재 비밀번호를 입력해 주세요',
                          controller: _currentPwController,
                          scaleFactor: scaleFactor,
                          autofocus: true,
                          guideMessage: currentPwGuideMsg,
                          obscureText: true,
                          focusNode: _currentPwFocusNode,
                        ),
                        SizedBox(height: 36 * scaleFactor),
                        EditFieldWidget(
                          label: '새 비밀번호',
                          hintText: '8자 이상 영문/숫자/특수문자 포함',
                          controller: _newPwController,
                          scaleFactor: scaleFactor,
                          autofocus: false,
                          guideMessage: newPwGuideMsg,
                          obscureText: true,
                        ),
                        SizedBox(height: 36 * scaleFactor),
                        EditFieldWidget(
                          label: '새 비밀번호 확인',
                          hintText: '비밀번호를 다시 입력해 주세요',
                          controller: _confirmNewPwController,
                          scaleFactor: scaleFactor,
                          autofocus: false,
                          guideMessage: confirmPwGuideMsg,
                          obscureText: true,
                        ),
                      ],
                    ),
                  ),
                  if (_isLoading)
                    const Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
            SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 6 * scaleFactor),
                    child: SizedBox(
                      width: 131 * scaleFactor,
                      height: 22 * scaleFactor,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () => context.push('/pwFinding'),
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
                            decorationColor: const Color(0xFF747784),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 12 * scaleFactor),
                    child: SaveButtonWidget(
                      scaleFactor: scaleFactor,
                      enabled: isSaveEnabled,
                      buttonText: '변경하기',
                      onPressed: _isLoading ? null : _updatePassword,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
