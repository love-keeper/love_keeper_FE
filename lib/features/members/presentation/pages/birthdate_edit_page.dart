import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper/features/members/presentation/viewmodels/members_viewmodel.dart';
import 'package:love_keeper/features/members/presentation/widgets/edit_field_widget.dart';
import 'package:love_keeper/features/members/presentation/widgets/date_text_input_formatter.dart';
import 'package:love_keeper/features/members/presentation/widgets/save_button_widget.dart';

class BirthdateEditPage extends ConsumerStatefulWidget {
  const BirthdateEditPage({super.key});

  @override
  _BirthdateEditPageState createState() => _BirthdateEditPageState();
}

class _BirthdateEditPageState extends ConsumerState<BirthdateEditPage> {
  final TextEditingController _birthdateController = TextEditingController();
  late FocusNode _focusNode;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _birthdateController.addListener(() {
      setState(() {});
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _birthdateController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _updateBirthday() async {
    final inputDate = _birthdateController.text;
    if (!birthdateRegex.hasMatch(inputDate)) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final formattedDate = inputDate.replaceAll('.', '-');
      final result = await ref
          .read(membersViewModelProvider.notifier)
          .updateBirthday(formattedDate);
      setState(() {
        _isLoading = false;
      });
      if (result == '생일 업데이트 성공') {
        context.pop();
      }
    } catch (e) {
      debugPrint('Update birthday error: $e');
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('생일 업데이트 실패: $e')),
      );
    }
  }

  final RegExp birthdateRegex =
      RegExp(r'^\d{4}\.(0[1-9]|1[0-2])\.(0[1-9]|[12]\d|3[01])$');

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    const double baseWidth = 375.0;
    final double scaleFactor = deviceWidth / baseWidth;
    final bool hasText = _birthdateController.text.isNotEmpty;

    final String guideMessage =
        hasText && !birthdateRegex.hasMatch(_birthdateController.text)
            ? '유효한 날짜 형식(YYYY.MM.DD)을 입력해 주세요'
            : '';

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), // 화면 탭 시 키보드 내림
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
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
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20 * scaleFactor),
                    child: EditFieldWidget(
                      label: '생년월일',
                      hintText: 'YYYY.MM.DD',
                      controller: _birthdateController,
                      scaleFactor: scaleFactor,
                      autofocus: true,
                      guideMessage: guideMessage,
                      inputFormatters: [DateTextInputFormatter()],
                      focusNode: _focusNode,
                    ),
                  ),
                  if (_isLoading)
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12 * scaleFactor),
                child: SaveButtonWidget(
                  scaleFactor: scaleFactor,
                  enabled: hasText && guideMessage.isEmpty && !_isLoading,
                  buttonText: '변경하기',
                  onPressed: _isLoading ? null : _updateBirthday,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
