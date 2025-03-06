import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper/features/couples/presentation/viewmodels/couples_viewmodel.dart';
import 'package:love_keeper/features/members/presentation/widgets/edit_field_widget.dart';
import 'package:love_keeper/features/members/presentation/widgets/save_button_widget.dart';
import 'package:love_keeper/features/members/presentation/widgets/date_text_input_formatter.dart';

class RelationshipStartEditPage extends ConsumerStatefulWidget {
  const RelationshipStartEditPage({super.key});

  @override
  _RelationshipStartEditPageState createState() =>
      _RelationshipStartEditPageState();
}

class _RelationshipStartEditPageState
    extends ConsumerState<RelationshipStartEditPage> {
  final TextEditingController _relationshipStartController =
      TextEditingController();
  late FocusNode _focusNode;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _relationshipStartController.addListener(() {
      setState(() {});
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _relationshipStartController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _updateStartDate() async {
    final inputDate = _relationshipStartController.text;
    if (!relationshipdateRegex.hasMatch(inputDate)) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final formattedDate = inputDate.replaceAll('.', '-');
      final result = await ref
          .read(couplesViewModelProvider.notifier)
          .updateStartDate(formattedDate);
      setState(() {
        _isLoading = false;
      });
      if (result == '날짜 업데이트 성공') {
        context.pop();
      }
    } catch (e) {
      debugPrint('Update start date error: $e');
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('날짜 업데이트 실패: $e')),
      );
    }
  }

  final RegExp relationshipdateRegex =
      RegExp(r'^\d{4}\.(0[1-9]|1[0-2])\.(0[1-9]|[12]\d|3[01])$');

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    const double baseWidth = 375.0;
    final double scaleFactor = deviceWidth / baseWidth;
    final bool hasText = _relationshipStartController.text.isNotEmpty;

    final String guideMessage = hasText &&
            !relationshipdateRegex.hasMatch(_relationshipStartController.text)
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
            '연애 시작일 변경',
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
                      label: '연애 시작일',
                      hintText: 'YYYY.MM.DD',
                      controller: _relationshipStartController,
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
                  onPressed: _isLoading ? null : _updateStartDate,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
