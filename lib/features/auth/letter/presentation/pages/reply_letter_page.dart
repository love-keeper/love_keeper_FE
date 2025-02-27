import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:love_keeper_fe/features/auth/letter/presentation/widgets/line_painter.dart';
import 'package:love_keeper_fe/features/auth/letter/presentation/widgets/letter_preview.dart';
import 'package:love_keeper_fe/features/auth/letter/presentation/widgets/custom_bottom_sheet_dialog.dart';
import 'package:love_keeper_fe/features/auth/letter/data/letter_texts.dart';

class ReplyLetterPage extends StatefulWidget {
  const ReplyLetterPage({super.key});

  @override
  _ReplyLetterPageState createState() => _ReplyLetterPageState();
}

class _ReplyLetterPageState extends State<ReplyLetterPage> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isButtonActive = false;
  int currentStep = 0;
  bool isPreview = false;
  bool showExitDialog = false;
  final List<String> stepTexts = ["", "", "", ""];

  late List<String> questionTexts;

  String userName = "나"; // 답장하는 사람 이름 (예시)
  String partnerName = "상대방"; // 원래 편지를 보낸 사람 이름 (예시)

  @override
  void initState() {
    super.initState();
    _textController.addListener(() {
      setState(() {
        _isButtonActive = _textController.text.isNotEmpty;
      });
    });
    // 답장 편지용 질문 텍스트 사용
    questionTexts = LetterTexts.replyQuestions;
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  // "다음" 버튼: 현재 단계의 텍스트 저장 후 다음 단계로 진행, 마지막 단계에서는 미리보기 모드로 전환
  void _nextStep() {
    setState(() {
      stepTexts[currentStep] = _textController.text;
      if (currentStep < 3) {
        currentStep++;
        _textController.text = stepTexts[currentStep];
        FocusScope.of(context).unfocus();
      } else {
        isPreview = true;
      }
    });
  }

  void _closePreview() {
    setState(() {
      isPreview = false;
    });
  }

  void _exitToHome() {
    context.go('/mainPage');
  }

  // 버튼에 표시될 텍스트 결정
  String getButtonText() {
    if (currentStep == 3 && !isPreview) return '완료';
    if (isPreview) return '전송하기';
    if (currentStep < 3) return '다음';
    return '';
  }

  List<double> getLineLengths(int currentStep) {
    switch (currentStep) {
      case 0:
        return [27.0, 32.0, 32.0];
      case 1:
        return [27.0, 27.0, 32.0];
      case 2:
        return [32.0, 27.0, 27.0];
      case 3:
        return [32.0, 32.0, 27.0];
      default:
        return [32.0, 32.0, 32.0];
    }
  }

  String getQuestionForStep(int step) {
    return questionTexts[step];
  }

// 백엔드에 임시 저장 요청을 보내는 함수
  Future<void> _saveTemporaryLetter() async {
    Map<String, dynamic> tempLetterData = {
      "sender": userName,
      "receiver": partnerName,
      "stepTexts": stepTexts, // 각 단계별 텍스트 리스트
      "currentStep": currentStep,
      "timestamp": DateTime.now().toIso8601String(),
      "isTemporary": true, // 임시 저장 여부 플래그
    };

    final url = Uri.parse("https://your-backend-url.com/api/saveTempLetter");
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(tempLetterData),
      );
      if (response.statusCode == 200) {
        // 임시 저장 성공 시 메인 페이지로 이동
        _exitToHome();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("임시저장 실패: ${response.statusCode}")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("임시저장 중 오류 발생: $e")));
    }
  }

  void _sendLetter() async {
    // 미리보기에서 사용된 방식과 동일하게 비어있지 않은 텍스트만 합칩니다.
    String letterContent = stepTexts.where((text) => text.isNotEmpty).join(" ");
    Map<String, dynamic> letterData = {
      "sender": userName,
      "receiver": partnerName,
      "content": letterContent,
      "timestamp": DateTime.now().toIso8601String(),
    };

    final url = Uri.parse("https://your-backend-url.com/api/sendLetter");
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(letterData),
      );

      if (response.statusCode == 200) {
        // 백엔드 전송 성공 조건 넣기
        // 백엔드 전송이 성공하면 sendLetterScreen 페이지로 이동합니다.
        context.pushNamed('sendLetterScreen', extra: {
          'letterData': letterData,
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("전송 실패: ${response.statusCode}")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("전송 중 오류 발생: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    const double baseWidth = 375.0;
    final double scaleFactor = deviceWidth / baseWidth;
    final List<double> lineLengths = getLineLengths(currentStep);
    final String previewContent =
        stepTexts.where((text) => text.isNotEmpty).join(" "); //미리보기 모드
    void displayExitDialog() {
      // 키보드를 먼저 닫음
      FocusScope.of(context).unfocus();

      // 키보드가 완전히 닫힌 후 바텀 시트를 띄우도록 약간의 딜레이 추가
      Future.delayed(const Duration(milliseconds: 200), () {
        showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent, // 배경을 투명하게 유지
          isDismissible: true, // 배경 클릭 시 닫히도록 설정
          enableDrag: true, // 드래그하여 닫을 수 있도록 설정
          builder: (BuildContext context) {
            // scaleFactor를 build 내에서 정의해야 함(예시: 이미 정의되어 있다고 가정)
            // 여기서는 기존에 정의된 scaleFactor 변수가 있다고 가정합니다.
            return GestureDetector(
              onTap: () => Navigator.pop(context), // 배경 클릭 시 닫기
              behavior: HitTestBehavior.opaque,
              child: Stack(
                children: [
                  // 바텀시트를 하단에 붙이기
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: SizedBox(
                      width: double.infinity,
                      height: 288 * scaleFactor, // 바텀시트 높이 조정
                      child: CustomBottomSheetDialog(
                        scaleFactor: scaleFactor,
                        title: "작성을 중단하시겠어요?",
                        content: "나가기 선택 시,\n작성된 편지는 저장되지 않습니다.",
                        exitText: "나가기",
                        saveText: "저장하기",
                        showSaveButton: true,
                        onExit: _exitToHome,
                        onSave: _saveTemporaryLetter,
                        onDismiss: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      });
    }

//뒤로가기 버튼
    void handleBackButton() {
      if (currentStep == 0) {
        if (_textController.text.isEmpty) {
          _exitToHome();
        } else {
          displayExitDialog();
        }
      } else {
        setState(() {
          currentStep--;
          _textController.text = stepTexts[currentStep];
        });
      }
    }

//미리보기 모드
    if (isPreview) {
      return Scaffold(
        body: LetterPreview(
          partnerName: "상대방",
          userName: "나",
          content: previewContent,
          scaleFactor: scaleFactor,
          actionButtonText: "전송하기",
          onAction: _sendLetter,
          onOutsideTap: _closePreview,
        ),
      );
    } else {
      return Scaffold(
        body: Stack(
          children: [
            GestureDetector(
              onTap: () {
                if (isPreview) {
                  _closePreview();
                } else {
                  FocusScope.of(context).unfocus();
                }
              },
              child: Scaffold(
                resizeToAvoidBottomInset: true,
                extendBodyBehindAppBar: true,
                appBar: AppBar(
                  backgroundColor: const Color.fromARGB(0, 255, 255, 255),
                  elevation: 0,
                  scrolledUnderElevation: 0,
                  leading: Padding(
                    padding: EdgeInsets.only(left: 20.0 * scaleFactor),
                    child: IconButton(
                      icon: Image.asset(
                        'assets/images/letter_page/Ic_Back.png',
                        width: 24 * scaleFactor,
                        height: 24 * scaleFactor,
                      ),
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                      onPressed: handleBackButton,
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: EdgeInsets.only(right: 20.0 * scaleFactor),
                      child: TextButton(
                        onPressed: displayExitDialog,
                        child: Text(
                          '나가기',
                          style: TextStyle(
                            color: const Color(0xFFFF859B),
                            fontSize: 14 * scaleFactor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                body: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        'assets/images/letter_page/background.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(height: 16.0 * scaleFactor),
                        Expanded(
                          child: SafeArea(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 141.0 * scaleFactor,
                                    height: 20.0 * scaleFactor,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: List.generate(4, (index) {
                                        return Row(
                                          children: [
                                            Container(
                                              width: index == currentStep
                                                  ? 20.0 * scaleFactor
                                                  : 10.0 * scaleFactor,
                                              height: index == currentStep
                                                  ? 20.0 * scaleFactor
                                                  : 10.0 * scaleFactor,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: index < currentStep
                                                    ? const Color(0xFFCCCCCC)
                                                    : index == currentStep
                                                        ? const Color(
                                                            0xFFFF859B)
                                                        : Colors.transparent,
                                                border: Border.all(
                                                  color: index == currentStep
                                                      ? const Color(0xFFFF859B)
                                                      : const Color(0xFFC3C6CF),
                                                  width: 2.0 * scaleFactor,
                                                ),
                                              ),
                                              child: Center(
                                                child: index == currentStep
                                                    ? Text(
                                                        '${index + 1}',
                                                        style: TextStyle(
                                                          fontSize: 12.0 *
                                                              scaleFactor,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.white,
                                                        ),
                                                      )
                                                    : const SizedBox.shrink(),
                                              ),
                                            ),
                                            if (index < 3)
                                              SizedBox(
                                                width: lineLengths[index] *
                                                    scaleFactor,
                                                height: 2.0 * scaleFactor,
                                                child: CustomPaint(
                                                  painter: LinePainter(
                                                    isDashed:
                                                        index >= currentStep,
                                                    color:
                                                        const Color(0xFFC3C6CF),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        );
                                      }),
                                    ),
                                  ),
                                  SizedBox(height: 32.0 * scaleFactor),
                                  Text(
                                    getQuestionForStep(currentStep),
                                    style: TextStyle(
                                      fontSize: 18.0 * scaleFactor,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF27282C),
                                    ),
                                  ),
                                  SizedBox(height: 10.0 * scaleFactor),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: TextField(
                                        controller: _textController,
                                        focusNode: _focusNode,
                                        maxLines: null,
                                        keyboardType: TextInputType.multiline,
                                        style: TextStyle(
                                          fontSize: 16.0 * scaleFactor,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFF27282C),
                                        ),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                12.0 * scaleFactor),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.transparent,
                                              width: 0.0,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                                12.0 * scaleFactor),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.transparent,
                                              width: 0.0,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                                12.0 * scaleFactor),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.all(0.0),
                                          hintText: '이곳을 눌러 답변을 입력해주세요.',
                                          hintStyle: TextStyle(
                                            fontSize: 16.0 * scaleFactor,
                                            fontWeight: FontWeight.w400,
                                            color: const Color(0xFFC3C6CF),
                                          ),
                                          alignLabelWithHint: true,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 12 * scaleFactor),
                                  Column(
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        child: Center(
                                          child: SizedBox(
                                            width: 335.0 * scaleFactor,
                                            height: 52.0 * scaleFactor,
                                            child: ElevatedButton(
                                              onPressed: _isButtonActive
                                                  ? _nextStep
                                                  : null,
                                              style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.zero,
                                                backgroundColor: _isButtonActive
                                                    ? const Color(0xFFFF859B)
                                                    : const Color(0xFFC3C6CF),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          26.0 * scaleFactor),
                                                ),
                                              ),
                                              child: Text(
                                                getButtonText(),
                                                style: TextStyle(
                                                  fontSize: 16.0 * scaleFactor,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 12.0 * scaleFactor),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}

class Preview {} // 필요 시 추가 (현재 사용되지 않음)
