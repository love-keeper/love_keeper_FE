import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper_fe/features/members/presentation/widgets/edit_field_widget.dart';
import 'package:love_keeper_fe/features/members/presentation/widgets/save_button_widget.dart';

class BirthdateEditPage extends StatefulWidget {
  const BirthdateEditPage({super.key});

  @override
  _BirthdateEditPageState createState() => _BirthdateEditPageState();
}

class _BirthdateEditPageState extends State<BirthdateEditPage> {
  final TextEditingController _birthdateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 텍스트 변경 시 상태 업데이트
    _birthdateController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _birthdateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 화면 너비에 따른 scaleFactor 계산 (기준: 375)
    final double deviceWidth = MediaQuery.of(context).size.width;
    const double baseWidth = 375.0;
    final double scaleFactor = deviceWidth / baseWidth;
    final bool hasText = _birthdateController.text.isNotEmpty;
    // 정규식을 이용해 YYYY.MM.DD 형식 검사
    final RegExp birthdateRegex =
        RegExp(r'^\d{4}\.(0[1-9]|1[0-2])\.(0[1-9]|[12]\d|3[01]).$');
    final String guideMessage =
        hasText && !birthdateRegex.hasMatch(_birthdateController.text)
            ? '유효한 날짜 형식(YYYY.MM.DD.)을 입력해 주세요'
            : '';

    return Scaffold(
      backgroundColor: Colors.white,
      // 항상 키보드 활성화를 위해 autofocus 옵션 설정 (EditFieldWidget에서 처리)
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          '생년월일 변경',
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
        buttonText: '변경하기',
        onPressed: () async {
          // 저장 처리 (예: 백엔드 API 호출 후 이전 페이지로 이동)
          context.pop();
          return;
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20 * scaleFactor),
        child: EditFieldWidget(
          label: '생년월일',
          hintText: 'YYYY.MM.DD.',
          controller: _birthdateController,
          scaleFactor: scaleFactor,
          autofocus: true, // 이 페이지에서는 항상 키보드 활성화
          guideMessage: guideMessage,
        ),
      ),
    );
  }
}
