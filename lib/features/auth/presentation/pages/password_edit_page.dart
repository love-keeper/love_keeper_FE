import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper_fe/features/members/presentation/widgets/edit_field_widget.dart';
import 'package:love_keeper_fe/features/members/presentation/widgets/save_button_widget.dart';

class PasswordEditPage extends StatefulWidget {
  const PasswordEditPage({super.key});

  @override
  _PasswordEditPageState createState() => _PasswordEditPageState();
}

class _PasswordEditPageState extends State<PasswordEditPage> {
  // 세 개의 텍스트 컨트롤러: 현재 비밀번호, 새 비밀번호, 새 비밀번호 확인
  final TextEditingController _newPwController = TextEditingController();
  final TextEditingController _confirmNewPwController = TextEditingController();

  // 새 비밀번호 조건: 최소 8자 이상, 영문, 숫자, 특수문자 포함
  final RegExp newPasswordRegex = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*()_+\-=\[\]{};:"\\|,.<>\/?]).{8,}$',
  );

  @override
  void initState() {
    super.initState();
    _newPwController.addListener(() => setState(() {}));
    _confirmNewPwController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _newPwController.dispose();
    _confirmNewPwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 화면 너비에 따른 scaleFactor 계산 (기준: 375)
    final double deviceWidth = MediaQuery.of(context).size.width;
    const double baseWidth = 375.0;
    final double scaleFactor = deviceWidth / baseWidth;

    // 각 텍스트 필드의 입력값
    final String newPw = _newPwController.text;
    final String confirmPw = _confirmNewPwController.text;

    // 안내문구 조건

    String newPwGuideMessage = '';
    if (newPw.isNotEmpty && !newPasswordRegex.hasMatch(newPw)) {
      newPwGuideMessage = '비밀번호가 조건을 충족하지 않습니다. 다시 입력해 주세요.';
    }

    String confirmPwGuideMessage = '';
    if (confirmPw.isNotEmpty && confirmPw != newPw) {
      confirmPwGuideMessage = '비밀번호가 일치하지 않습니다. 다시 입력해 주세요.';
    }

    // 세 필드 모두 채워지고 가이드 문구가 없으면 저장 버튼 활성화
    final bool isSaveEnabled = newPw.isNotEmpty &&
        confirmPw.isNotEmpty &&
        newPwGuideMessage.isEmpty &&
        confirmPwGuideMessage.isEmpty;

    return Scaffold(
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
        enabled: isSaveEnabled,
        buttonText: '변경하기',
        onPressed: () {
          if (isSaveEnabled) {
            // 여기서 백엔드 API를 호출해서 비밀번호를 변경하고,
            // 성공 시 스택 삭제하고
            context.go('/emailLogin');
          }
        },
      ),
      body: GestureDetector(
        // 텍스트 필드 이외의 영역 탭 시 키보드 내리기
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20 * scaleFactor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16 * scaleFactor),
              // 새 비밀번호 입력 필드
              EditFieldWidget(
                label: '새 비밀번호',
                hintText: '8자 이상 영문/숫자/특수문자 포함',
                controller: _newPwController,
                scaleFactor: scaleFactor,
                autofocus: false,
                guideMessage: newPwGuideMessage,
                obscureText: true,
              ),
              SizedBox(height: 36 * scaleFactor),
              // 새 비밀번호 확인 입력 필드
              EditFieldWidget(
                label: '비밀번호 확인',
                hintText: '비밀번호를 다시 입력해 주세요',
                controller: _confirmNewPwController,
                scaleFactor: scaleFactor,
                autofocus: false,
                guideMessage: confirmPwGuideMessage,
                obscureText: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
