import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper_fe/core/config/routes/route_names.dart';
import 'package:love_keeper_fe/features/members/presentation/viewmodels/members_viewmodel.dart';
import 'package:love_keeper_fe/features/members/presentation/widgets/edit_field_widget.dart';
import 'package:love_keeper_fe/features/members/presentation/widgets/save_button_widget.dart';

class NewEmailInputPage extends ConsumerStatefulWidget {
  const NewEmailInputPage({super.key});

  @override
  _NewEmailInputPageState createState() => _NewEmailInputPageState();
}

class _NewEmailInputPageState extends ConsumerState<NewEmailInputPage> {
  final TextEditingController _newEmailController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _newEmailController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _newEmailController.dispose();
    super.dispose();
  }

  Future<void> _proceedToCertification() async {
    final email = _newEmailController.text;
    if (!emailRegex.hasMatch(email)) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // 인증 코드는 NewEmailCertification에서 실행되므로 여기서는 이동만 처리
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('오류 발생: $e')),
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
    final bool hasText = _newEmailController.text.isNotEmpty;

    final String guideMessage =
        hasText && !emailRegex.hasMatch(_newEmailController.text)
            ? '올바른 이메일 형식을 입력해 주세요.'
            : '';

    return Scaffold(
      backgroundColor: Colors.white,
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
      bottomNavigationBar: SaveButtonWidget(
        scaleFactor: scaleFactor,
        enabled: hasText && guideMessage.isEmpty && !_isLoading,
        buttonText: '다음',
        onPressed: _isLoading ? null : _proceedToCertification,
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20 * scaleFactor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16 * scaleFactor),
                EditFieldWidget(
                  label: '이메일',
                  hintText: '변경할 이메일을 입력해 주세요',
                  controller: _newEmailController,
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
    );
  }
}
