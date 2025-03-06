import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper/core/config/routes/route_names.dart';
import 'package:love_keeper/features/couples/presentation/viewmodels/couples_viewmodel.dart';
import 'package:love_keeper/features/members/presentation/widgets/edit_field_widget.dart';
import 'package:love_keeper/features/members/presentation/widgets/save_button_widget.dart';

class CodeConnectPage extends ConsumerStatefulWidget {
  const CodeConnectPage({super.key});

  @override
  _CodeConnectPageState createState() => _CodeConnectPageState();
}

class _CodeConnectPageState extends ConsumerState<CodeConnectPage> {
  final TextEditingController _inviteCodeController = TextEditingController();
  late FocusNode _focusNode;
  String generatedInviteCode = '';
  bool _isLoading = false;
  bool _connectionFailed = false; // 연결 실패 여부

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _inviteCodeController.addListener(() {
      setState(() {});
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _generateInviteCode();
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _inviteCodeController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _generateInviteCode() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final inviteCode =
          await ref.read(couplesViewModelProvider.notifier).generateCode();
      setState(() {
        generatedInviteCode = inviteCode.inviteCode; // 백엔드에서 받은 초대 코드
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Generate code error: $e');
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('초대 코드 생성 실패: $e')));
    }
  }

  Future<void> _connectPartner() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final result = await ref
          .read(couplesViewModelProvider.notifier)
          .connect(_inviteCodeController.text);
      setState(() {
        _isLoading = false;
        // 연결이 성공하면 _connectionFailed를 false로 설정
        _connectionFailed = false;
      });
      if (result == '커플 연결이 완료되었습니다.') {
        context.push(RouteNames.mainPage);
      } else {
        // 연결 결과가 실패하면 _connectionFailed를 true로 설정
        setState(() {
          _connectionFailed = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('연결 실패')),
        );
      }
    } catch (e) {
      debugPrint('Connect error: $e');
      setState(() {
        _isLoading = false;
        _connectionFailed = true;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('연결 실패: $e')));
    }
  }

  Future<void> _handleBackButton() async {
    // 로그아웃 처리
    try {
      await ref.read(authViewModelProvider.notifier).logout();
      print('Logged out successfully');
    } catch (e) {
      print('Logout error: $e');
    }
    // 온보딩 페이지로 이동
    context.pushReplacement(RouteNames.onboarding);
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    const double baseWidth = 375.0;
    final double scaleFactor = deviceWidth / baseWidth;

    final bool hasText = _inviteCodeController.text.isNotEmpty;
    // 가이드 메시지는 이제 연결 실패(_connectionFailed)가 true일 때만 표시됩니다.
    final String guideMessage =
        _connectionFailed ? '입력한 초대 코드가 유효하지 않습니다. 다시 입력해 주세요.' : '';

    final bool isButtonEnabled = hasText && !_isLoading;

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
            '코드 연결',
            style: TextStyle(
              fontSize: 18 * scaleFactor,
              fontWeight: FontWeight.w600,
              height: 26 / 18,
              letterSpacing: -0.025 * (18 * scaleFactor),
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
                        Container(
                          width: 150 * scaleFactor,
                          height: 26 * scaleFactor,
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                generatedInviteCode.isEmpty
                                    ? '로딩 중...'
                                    : generatedInviteCode,
                                style: TextStyle(
                                  fontSize: 18 * scaleFactor,
                                  fontWeight: FontWeight.w600,
                                  height: 26 / 18,
                                  letterSpacing: -0.025 * (18 * scaleFactor),
                                  color: const Color(0xFFFF859B),
                                ),
                              ),
                              SizedBox(width: 2 * scaleFactor),
                              Image.asset(
                                'assets/images/login_page/Ic_Copy.png',
                                width: 16 * scaleFactor,
                                height: 16 * scaleFactor,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 3 * scaleFactor),
                        Text(
                          '생성된 초대 코드를 복사해 상대방에게 전달해 보세요.',
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
                        // EditFieldWidget는 guideMessage를 받아 가이드 메시지로 사용합니다.
                        EditFieldWidget(
                          label: '상대방 초대 코드',
                          hintText: '전달 받은 초대 코드를 입력해 주세요.',
                          controller: _inviteCodeController,
                          scaleFactor: scaleFactor,
                          autofocus: true,
                          guideMessage: guideMessage,
                          focusNode: _focusNode,
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
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12 * scaleFactor),
                child: SaveButtonWidget(
                  scaleFactor: scaleFactor,
                  enabled: isButtonEnabled,
                  buttonText: '연결하기',
                  onPressed: _isLoading ? null : _connectPartner,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
