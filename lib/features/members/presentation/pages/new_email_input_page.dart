import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper_fe/features/members/presentation/widgets/edit_field_widget.dart';
import 'package:love_keeper_fe/features/members/presentation/widgets/save_button_widget.dart';

class NewEmailInputPage extends StatefulWidget {
  const NewEmailInputPage({super.key});

  @override
  _NewEmailInputPageState createState() => _NewEmailInputPageState();
}

class _NewEmailInputPageState extends State<NewEmailInputPage> {
  final TextEditingController _newEmailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 텍스트 변경 시 상태 업데이트
    _newEmailController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _newEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 화면 너비에 따른 scaleFactor 계산 (기준: 375)
    final double deviceWidth = MediaQuery.of(context).size.width;
    const double baseWidth = 375.0;
    final double scaleFactor = deviceWidth / baseWidth;
    final bool hasText = _newEmailController.text.isNotEmpty;
    // 이메일 형식 정규식 (보편적인 형식: @와 .com, .net, .org, .edu 등 포함)
    final RegExp emailRegex = RegExp(
        r'^[^@]+@[^@]+\.(com|net|org|edu|co\.kr|ac\.kr)$',
        caseSensitive: false);

    // 입력 도중에 형식이 올바르지 않으면 가이드 문구 설정
    final String guideMessage =
        hasText && !emailRegex.hasMatch(_newEmailController.text)
            ? '올바른 이메일 형식을 입력해 주세요.'
            : '';

    return Scaffold(
      backgroundColor: Colors.white, // 배경을 흰색으로 지정
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
        enabled: hasText,
        buttonText: '다음',
        onPressed: () {
          context.push('/newEmail_CE');
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20 * scaleFactor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16 * scaleFactor),
            // EditFieldWidget을 사용하여 새 이메일 입력
            EditFieldWidget(
              label: '이메일',
              hintText: '변경할 이메일을 입력해 주세요',
              controller: _newEmailController,
              scaleFactor: scaleFactor,
              autofocus: true, // 페이지 진입 시 키보드 활성화
              guideMessage: guideMessage, // 조건 안내 문구 표시
            ),
          ],
        ),
      ),
    );
  }
}
