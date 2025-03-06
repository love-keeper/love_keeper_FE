import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper/core/config/routes/route_names.dart';
import 'package:love_keeper/features/members/presentation/viewmodels/members_viewmodel.dart';
import 'package:love_keeper/features/members/presentation/widgets/edit_field_widget.dart';
import 'package:love_keeper/features/members/presentation/widgets/save_button_widget.dart';

class NewEmailInputPage extends ConsumerStatefulWidget {
  const NewEmailInputPage({super.key});

  @override
  _NewEmailInputPageState createState() => _NewEmailInputPageState();
}

class _NewEmailInputPageState extends ConsumerState<NewEmailInputPage> {
  final TextEditingController _newEmailController = TextEditingController();
  late FocusNode _focusNode; // FocusNode 추가
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode(); // FocusNode 초기화
    _newEmailController.addListener(() {
      setState(() {});
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus(); // 페이지 로드 후 포커스 요청
    });
  }

  @override
  void dispose() {
    _newEmailController.dispose();
    _focusNode.dispose(); // FocusNode 해제
    super.dispose();
  }

  Future<void> _proceedToCertification() async {
    final email = _newEmailController.text;
    if (!emailRegex.hasMatch(email)) return;

    setState(() {
      _isLoading = true;
    });

    try {
      setState(() {
        _isLoading = false;
      });
      context.push(
        RouteNames.newEmailCertification,
        extra: {'email': email}, // 이메일만 전달
      );
    } catch (e) {
      debugPrint('Navigation error: $e');
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('오류 발생: $e')));
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
    final bool hasText = _newEmailController.text.isNotEmpty;

    final String guideMessage =
        hasText && !emailRegex.hasMatch(_newEmailController.text)
            ? '올바른 이메일 형식을 입력해 주세요.'
            : '';

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), // 화면 탭 시 키보드 내림
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true, // 키보드에 따라 화면 조정
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            '이메일 변경',
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
            SizedBox(height: 16 * scaleFactor),
            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20 * scaleFactor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        EditFieldWidget(
                          label: '이메일',
                          hintText: '변경할 이메일을 입력해 주세요',
                          controller: _newEmailController,
                          scaleFactor: scaleFactor,
                          autofocus: false, // autofocus를 FocusNode로 대체
                          guideMessage: guideMessage,
                          focusNode: _focusNode, // FocusNode 전달
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
                padding: EdgeInsets.symmetric(vertical: 10 * scaleFactor),
                child: SaveButtonWidget(
                  scaleFactor: scaleFactor,
                  enabled: hasText && guideMessage.isEmpty && !_isLoading,
                  buttonText: '다음',
                  onPressed: _isLoading ? null : _proceedToCertification,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
