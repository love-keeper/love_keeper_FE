import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper_fe/core/config/routes/route_names.dart';
import 'package:love_keeper_fe/features/couples/presentation/viewmodels/couples_viewmodel.dart';
import 'package:love_keeper_fe/features/members/presentation/widgets/edit_field_widget.dart';
import 'package:love_keeper_fe/features/members/presentation/widgets/save_button_widget.dart';

class CodeConnectPage extends ConsumerStatefulWidget {
  const CodeConnectPage({super.key});

  @override
  _CodeConnectPageState createState() => _CodeConnectPageState();
}

class _CodeConnectPageState extends ConsumerState<CodeConnectPage> {
  final TextEditingController _inviteCodeController = TextEditingController();
  String generatedInviteCode = ''; // 생성된 초대 코드 저장
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _generateInviteCode(); // 화면 로드 시 초대 코드 생성
    _inviteCodeController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _inviteCodeController.dispose();
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('초대 코드 생성 실패: $e')),
      );
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
      });
      if (result == '연결 성공') {
        // 백엔드 응답에 따라 수정
        context.push('/mainPage');
      }
    } catch (e) {
      debugPrint('Connect error: $e');
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('연결 실패: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    const double baseWidth = 375.0;
    final double scaleFactor = deviceWidth / baseWidth;

    final bool hasText = _inviteCodeController.text.isNotEmpty;
    final String guideMessage = hasText &&
            _inviteCodeController.text !=
                generatedInviteCode // 단순 예시, 실제로는 백엔드 검증
        ? '입력한 초대 코드가 유효하지 않습니다. 다시 입력해 주세요.'
        : '';

    final bool isButtonEnabled =
        hasText && _inviteCodeController.text.isNotEmpty && !_isLoading;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          '코드연결',
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
      body: Stack(
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
                EditFieldWidget(
                  label: '상대방 초대 코드',
                  hintText: '전달 받은 초대 코드를 입력해 주세요.',
                  controller: _inviteCodeController,
                  scaleFactor: scaleFactor,
                  autofocus: true,
                  guideMessage: guideMessage,
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
      bottomNavigationBar: SaveButtonWidget(
        scaleFactor: scaleFactor,
        enabled: isButtonEnabled,
        buttonText: '연결하기',
        onPressed: _isLoading ? null : _connectPartner,
      ),
    );
  }
}
