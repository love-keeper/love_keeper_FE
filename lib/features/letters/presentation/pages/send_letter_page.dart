import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper_fe/features/letters/presentation/viewmodels/letters_viewmodel.dart';
import 'package:love_keeper_fe/features/members/presentation/viewmodels/members_viewmodel.dart';
import 'package:love_keeper_fe/features/members/domain/entities/member_info.dart'; // MemberInfo 임포트
import 'package:love_keeper_fe/features/letters/presentation/widgets/line_painter.dart';
import 'package:love_keeper_fe/features/letters/presentation/widgets/letter_preview.dart';
import 'package:love_keeper_fe/features/letters/presentation/widgets/custom_bottom_sheet_dialog.dart';
import 'package:love_keeper_fe/features/letters/data/letter_texts.dart';
import 'package:love_keeper_fe/features/drafts/presentation/viewmodels/drafts_viewmodel.dart'; // DraftsViewModel 추가
import 'package:love_keeper_fe/features/drafts/domain/entities/draft.dart'; // Draft 추가
import 'package:dio/dio.dart'; // Dio 추가

class SendLetterPage extends ConsumerStatefulWidget {
  const SendLetterPage({super.key});

  @override
  _SendLetterPageState createState() => _SendLetterPageState();
}

class _SendLetterPageState extends ConsumerState<SendLetterPage> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isButtonActive = false;
  int currentStep = 0; // UI 단계: 0~3
  bool isPreview = false;
  final List<String> stepTexts = ['', '', '', '']; // null이 될 수 없음

  late List<String> questionTexts;

  @override
  void initState() {
    super.initState();
    _textController.addListener(() {
      setState(() {
        _isButtonActive = _textController.text.isNotEmpty; // null 체크 불필요
      });
    });
    questionTexts = LetterTexts.sendQuestions;

    // draft 데이터 로드
    _loadDraftData();
  }

  Future<void> _loadDraftData() async {
    for (int step = 0; step <= 3; step++) {
      final draftOrder = step + 1; // 백엔드 draftOrder: 1~4
      try {
        final draft = await ref
            .read(draftsViewModelProvider.notifier)
            .getDraft(draftOrder);
        if (draft != null) {
          setState(() {
            stepTexts[step] = draft.content ?? ''; // null일 경우 빈 문자열
            if (step == currentStep) {
              _textController.text = draft.content ?? ''; // 현재 단계 텍스트 필드에 반영
            }
          });
          // 데이터 불러온 후 삭제 (백엔드 미구현으로 에러 처리)
          try {
            await _deleteDraft(draftOrder);
          } catch (e) {
            if (e is DioException) {
              debugPrint(
                  '드래프트 삭제 실패 (미구현) - order: $draftOrder, Error: ${e.response?.statusCode} - ${e.message}');
            } else {
              debugPrint('드래프트 삭제 실패 (미구현) - order: $draftOrder, Error: $e');
            }
          }
        }
      } catch (e) {
        if (e is DioException) {
          if (e.response?.statusCode == 404) {
            debugPrint('드래프트 없음 - order: $draftOrder');
            continue; // 데이터 없음으로 처리
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(
                      '드래프트 불러오기 실패 (단계 $step): ${e.response?.statusCode} - ${e.message}')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('드래프트 불러오기 실패 (단계 $step): $e')),
          );
        }
      }
    }
  }

  Future<void> _deleteDraft(int draftOrder) async {
    try {
      await ref.read(draftsViewModelProvider.notifier).deleteDraft(draftOrder);
      debugPrint('드래프트 삭제 성공 - draftOrder: $draftOrder');
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 404) {
          debugPrint('드래프트 이미 삭제됨 또는 없음 - draftOrder: $draftOrder');
        } else {
          throw Exception(
              '드래프트 삭제 실패 (draftOrder $draftOrder): ${e.response?.statusCode} - ${e.message}');
        }
      } else {
        throw Exception('드래프트 삭제 실패 (draftOrder $draftOrder): $e');
      }
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _nextStep() {
    setState(() {
      stepTexts[currentStep] = _textController.text; // null이 아님 보장
      if (currentStep < 3) {
        currentStep++;
        _textController.text = stepTexts[currentStep] ?? ''; // null 체크
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

  Future<void> _sendLetter() async {
    final memberInfoState = ref.watch(membersViewModelProvider);
    if (memberInfoState is AsyncLoading) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('사용자 정보를 불러오는 중입니다.')),
      );
      return;
    }
    if (memberInfoState is AsyncError) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('사용자 정보를 불러오지 못했습니다.')),
      );
      return;
    }
    final memberInfo = (memberInfoState as AsyncData<MemberInfo?>).value;
    if (memberInfo == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('사용자 정보를 찾을 수 없습니다.')),
      );
      return;
    }
    final userName = memberInfo.nickname; // 사용자 닉네임
    final partnerName = memberInfo.coupleNickname ?? '상대방'; // 상대방 닉네임 (없으면 기본값)

    String letterContent =
        stepTexts.where((text) => text.isNotEmpty).toList().join(' ');
    try {
      final result = await ref
          .read(lettersViewModelProvider.notifier)
          .createLetter(letterContent);
      if (result.contains("성공")) {
        // 백엔드 메시지에 따라 조정 필요
        context.pushNamed('sendLetterScreen', extra: {
          'letterData': {
            'sender': userName,
            'receiver': partnerName,
            'content': letterContent,
          },
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('편지 전송 실패: $e')),
      );
    }
  }

  // 임시저장 메서드 (DraftsViewModel 사용, draftOrder 조정)
  Future<void> _saveTemporaryLetter() async {
    if (currentStep < 0 || currentStep > 3 || _textController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('저장할 내용이 없습니다.')),
      );
      return;
    }

    // _textController.text를 stepTexts에 저장
    setState(() {
      stepTexts[currentStep] = _textController.text; // null이 아님 보장
    });

    final int draftOrder =
        currentStep + 1; // UI currentStep(0~3) -> 백엔드 draftOrder(1~4)
    try {
      // 기존 데이터 삭제 (백엔드 미구현으로 에러 처리)
      await _deleteDraft(draftOrder);

      // 새 데이터 저장
      final result = await ref
          .read(draftsViewModelProvider.notifier)
          .createDraft(draftOrder, stepTexts[currentStep]!); // null 아님 보장
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('임시저장 성공: $result')),
      );
      _exitToHome(); // 성공 후 메인 페이지로 이동
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 400) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('드래프트 저장 실패: draftOrder는 1 이상이어야 합니다.')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text('임시저장 실패: ${e.response?.statusCode} - ${e.message}')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('임시저장 실패: $e')),
        );
      }
    }
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
            saveText: '저장하기', // "임시저장"으로 변경 가능 (UI 일관성)
            showSaveButton: true,
            onExit: _exitToHome,
            onSave: _saveTemporaryLetter, // 임시저장 로직 연결
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
        _textController.text = stepTexts[currentStep] ?? ''; // null 체크
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
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                  contentPadding: const EdgeInsets.all(
                                      0.0), // LetterPage와 동일한 패딩
                                  hintText: '이곳을 눌러 답변을 입력해주세요.',
                                  hintStyle: TextStyle(
                                    fontSize: 16.0 * scaleFactor,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFFC3C6CF),
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
                                          color: Colors.white,
                                        )
                                      : Text(
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
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
