import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper_fe/features/letters/presentation/viewmodels/letters_viewmodel.dart';
import 'package:love_keeper_fe/features/members/presentation/viewmodels/members_viewmodel.dart';
import 'package:love_keeper_fe/features/members/domain/entities/member_info.dart';
import 'package:love_keeper_fe/features/letters/presentation/widgets/line_painter.dart';
import 'package:love_keeper_fe/features/letters/presentation/widgets/letter_preview.dart';
import 'package:love_keeper_fe/features/drafts/presentation/viewmodels/drafts_viewmodel.dart';
import 'package:love_keeper_fe/features/letters/presentation/widgets/custom_bottom_sheet_dialog.dart';
import 'package:love_keeper_fe/features/letters/data/letter_texts.dart';
import 'package:dio/dio.dart';

class SendLetterPage extends ConsumerStatefulWidget {
  const SendLetterPage({super.key});

  @override
  _SendLetterPageState createState() => _SendLetterPageState();
}

class _SendLetterPageState extends ConsumerState<SendLetterPage> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isButtonActive = false;
  int currentStep = 0;
  bool isPreview = false;
  // 각 단계별 텍스트를 저장하는 배열 (초기 기본값은 빈 문자열)
  final List<String> stepTexts = ['', '', '', ''];
  late List<String> questionTexts;
  bool _initializedFromDraft = false; // Route extra에서 초기화 여부 확인

  @override
  void initState() {
    super.initState();
    // 텍스트 입력에 따라 버튼 활성화 여부를 결정
    _textController.addListener(() {
      setState(() {
        _isButtonActive = _textController.text.isNotEmpty;
      });
    });
    questionTexts = LetterTexts.sendQuestions;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initializedFromDraft) {
      final routeExtra = GoRouterState.of(context).extra;
      if (routeExtra != null &&
          routeExtra is Map &&
          routeExtra.containsKey('draftContents')) {
        final List<dynamic> draftContents =
            routeExtra['draftContents'] as List<dynamic>;
        if (draftContents.length == 4) {
          for (int i = 0; i < 4; i++) {
            stepTexts[i] = draftContents[i] as String? ?? '';
          }
          _textController.text = stepTexts[currentStep];
        }
      }
      _initializedFromDraft = true;
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  // "다음" 버튼: 현재 단계의 텍스트 저장 후 다음 단계로 이동.
  // 이미 저장된 텍스트가 있다면 복원하여 표시.
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

  // 메인 페이지로 이동 (나가기 선택 시 텍스트는 그대로 유지됨)
  void _exitToHome() {
    context.go('/mainPage');
  }

  // 편지 전송 로직 (별도 API 사용; 임시저장과는 별개)
  Future<void> _sendLetter() async {
    final memberInfoState = ref.watch(membersViewModelProvider);
    if (memberInfoState is AsyncLoading) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('사용자 정보를 불러오는 중입니다.')));
      return;
    }
    if (memberInfoState is AsyncError) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('사용자 정보를 불러오지 못했습니다.')));
      return;
    }
    final memberInfo = (memberInfoState as AsyncData<MemberInfo?>).value;
    if (memberInfo == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('사용자 정보를 찾을 수 없습니다.')));
      return;
    }
    final userName = memberInfo.nickname;
    final partnerName = memberInfo.coupleNickname ?? '상대방';
    String letterContent = stepTexts.where((text) => text.isNotEmpty).join(' ');
    try {
      final result = await ref
          .read(lettersViewModelProvider.notifier)
          .createLetter(letterContent);
      if (result.contains("성공")) {
        context.pushNamed('sendLetterScreen', extra: {
          'letterData': {
            'sender': userName,
            'receiver': partnerName,
            'content': letterContent,
          },
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('편지 전송 실패: $e')));
    }
  }

  // 임시저장 로직: "저장하기" 버튼 클릭 시 0단계부터 4단계까지의 텍스트를 순회하며 POST 요청 실행.
  Future<void> _saveTemporaryLetter() async {
    setState(() {
      stepTexts[currentStep] = _textController.text;
    });
    // 0단계부터 4단계까지 모두 임시저장 (빈 문자열도 포함)
    for (int step = 0; step < 4; step++) {
      final int draftOrder = step + 1;
      try {
        final String content = stepTexts[step];
        final result = await ref
            .read(draftsViewModelProvider.notifier)
            .createDraft(draftOrder, content);
        debugPrint('Saved draftOrder $draftOrder with content: $content');
      } catch (e) {
        if (e is DioException) {
          if (e.response?.statusCode == 400) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('드래프트 저장 실패: draftOrder는 1 이상이어야 합니다.')));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    '임시저장 실패 (step $step): ${e.response?.statusCode} - ${e.message}')));
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('임시저장 실패 (step $step): $e')));
        }
      }
    }
    Navigator.pop(context);
    context.go('/mainPage');
  }

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

  void displayExitDialog() {
    FocusScope.of(context).unfocus();
    Future.delayed(const Duration(milliseconds: 200), () {
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          final scaleFactor = MediaQuery.of(context).size.width / 375.0;
          return CustomBottomSheetDialog(
            scaleFactor: scaleFactor,
            title: '작성을 중단하시겠어요?',
            content: '나가기 선택 시,\n작성된 편지는 저장되지 않습니다.',
            exitText: '나가기',
            saveText: '저장하기',
            showSaveButton: true,
            onExit: _exitToHome,
            onSave: _saveTemporaryLetter,
            onDismiss: () => Navigator.pop(context),
          );
        },
      );
    });
  }

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

  @override
  Widget build(BuildContext context) {
    final double scaleFactor = MediaQuery.of(context).size.width / 375.0;
    final List<double> lineLengths = getLineLengths(currentStep);
    final String previewContent =
        stepTexts.where((text) => text.isNotEmpty).join(' ');
    final state = ref.watch(lettersViewModelProvider);
    final memberInfoState = ref.watch(membersViewModelProvider);

    if (isPreview) {
      final userName = memberInfoState is AsyncData<MemberInfo?>
          ? memberInfoState.value?.nickname ?? '나'
          : '나';
      final partnerName = memberInfoState is AsyncData<MemberInfo?>
          ? memberInfoState.value?.coupleNickname ?? '상대방'
          : '상대방';
      return Scaffold(
        body: LetterPreview(
          partnerName: partnerName,
          userName: userName,
          content: previewContent,
          scaleFactor: scaleFactor,
          actionButtonText: '전송하기',
          onAction: _sendLetter,
          onOutsideTap: _closePreview,
        ),
      );
    }
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
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
              onPressed: () {
                // 모든 단계의 텍스트와 현재 입력값이 모두 비어있으면 바로 메인 페이지로 이동
                if (stepTexts.every((text) => text.isEmpty) &&
                    _textController.text.isEmpty) {
                  _exitToHome();
                } else {
                  displayExitDialog();
                }
              },
              child: Text(
                '나가기',
                style: TextStyle(
                  color: const Color(0xFFFF859B),
                  fontSize: 14 * scaleFactor,
                  fontWeight: FontWeight.w600,
                  height: 22 / (14 * scaleFactor),
                  letterSpacing: -0.025 * (14 * scaleFactor),
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
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 상단 진행바
                        SizedBox(
                          width: 141.0 * scaleFactor,
                          height: 20.0 * scaleFactor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                              ? const Color(0xFFFF859B)
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
                                                fontSize: 12.0 * scaleFactor,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                                height: 12 / (12 * scaleFactor),
                                                letterSpacing:
                                                    -0.025 * (12 * scaleFactor),
                                              ),
                                            )
                                          : const SizedBox.shrink(),
                                    ),
                                  ),
                                  if (index < 3)
                                    SizedBox(
                                      width: lineLengths[index] * scaleFactor,
                                      height: 2.0 * scaleFactor,
                                      child: CustomPaint(
                                        painter: LinePainter(
                                          isDashed: index >= currentStep,
                                          color: const Color(0xFFC3C6CF),
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
                            height: 26 / (18 * scaleFactor),
                            letterSpacing: -0.025 * (18 * scaleFactor),
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
                                height: 24 / (16 * scaleFactor),
                                letterSpacing: -0.025 * (16 * scaleFactor),
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(12.0 * scaleFactor),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                    width: 0.0,
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(12.0 * scaleFactor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                    width: 0.0,
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(12.0 * scaleFactor),
                                ),
                                contentPadding: const EdgeInsets.all(0.0),
                                hintText: '이곳을 눌러 답변을 입력해주세요.',
                                hintStyle: TextStyle(
                                  fontSize: 16.0 * scaleFactor,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFFC3C6CF),
                                  height: 24 / (16 * scaleFactor),
                                  letterSpacing: -0.025 * (16 * scaleFactor),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 12 * scaleFactor),
                        SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: SizedBox(
                              width: 335.0 * scaleFactor,
                              height: 52.0 * scaleFactor,
                              child: ElevatedButton(
                                onPressed: state.isLoading || !_isButtonActive
                                    ? null
                                    : _nextStep,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _isButtonActive
                                      ? const Color(0xFFFF859B)
                                      : const Color(0xFFC3C6CF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        26.0 * scaleFactor),
                                  ),
                                ),
                                child: state.isLoading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white)
                                    : Text(
                                        getButtonText(),
                                        style: TextStyle(
                                          fontSize: 16.0 * scaleFactor,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          height: 24 / (16 * scaleFactor),
                                          letterSpacing:
                                              -0.025 * (16 * scaleFactor),
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 12.0 * scaleFactor),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
