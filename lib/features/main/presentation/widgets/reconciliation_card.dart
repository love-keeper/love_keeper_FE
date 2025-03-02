import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper_fe/features/drafts/presentation/viewmodels/drafts_viewmodel.dart';
import 'package:love_keeper_fe/features/letters/presentation/widgets/custom_bottom_sheet_dialog.dart';
import 'package:love_keeper_fe/features/drafts/domain/entities/draft.dart';
import 'package:dio/dio.dart'; // Dio 추가 (예외 처리 개선)

class ReconciliationCard extends ConsumerWidget {
  const ReconciliationCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        height: 160, // 카드의 높이
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), // 모서리 둥글게
          image: const DecorationImage(
            image: AssetImage('assets/images/main_page/img_main_Rectangle.png'),
            fit: BoxFit.cover,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.05),
              offset: Offset(0, 0), // 그림자 방향
              blurRadius: 5, // 흐림 효과
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          // 텍스트 영역
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 20),
                  child: Text(
                    '화해 요청하기',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: -0.45,
                      height: 1.44,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    '사과의 마음을 편지에 담아 보세요',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                      letterSpacing: -0.35,
                      height: 1.57,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 이미지 영역
          GestureDetector(
            onTap: () async {
              bool hasDraft = false;
              for (int step = 0; step <= 3; step++) {
                final draftOrder = step + 1; // draftOrder = 1~4 (백엔드 기준)
                try {
                  final draft = await ref
                      .read(draftsViewModelProvider.notifier)
                      .getDraft(draftOrder);
                  if (draft != null) {
                    hasDraft = true;
                    break;
                  }
                } catch (e) {
                  if (e is DioException) {
                    if (e.response?.statusCode == 404) {
                      debugPrint('드래프트 없음 - order: $draftOrder');
                      continue; // 데이터 없음으로 간주
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                '드래프트 확인 실패 (단계 $step): ${e.response?.statusCode} - ${e.message}')),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('드래프트 확인 실패 (단계 $step): $e')),
                    );
                  }
                }
              }

              if (hasDraft) {
                _showDraftDialog(context, ref);
              } else {
                context.pushNamed('sendLetter');
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(
                right: 20,
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: Image.asset(
                  'assets/images/main_page/letter.png', // 편지 이미지 경로
                  width: 110, // 적절한 너비
                  height: 130, // 적절한 높이
                  fit: BoxFit.contain, // 이미지 비율 유지
                ),
              ),
            ),
          )
        ]));
  }

  void _showDraftDialog(BuildContext context, WidgetRef ref) {
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
            title: '작성하던 글이 있어요!',
            content: '새로 쓰기 선택 시,\n이전 내용은 사라지게 됩니다.',
            exitText: '새로쓰기',
            saveText: '불러오기',
            showSaveButton: true,
            onExit: () async {
              // 임시저장 데이터 삭제 (백엔드 미구현으로 에러 처리)
              for (int step = 0; step <= 3; step++) {
                final draftOrder = step + 1;
                try {
                  await ref
                      .read(draftsViewModelProvider.notifier)
                      .deleteDraft(draftOrder);
                  debugPrint('드래프트 삭제 성공 - order: $draftOrder');
                } catch (e) {
                  if (e is DioException) {
                    if (e.response?.statusCode == 404) {
                      debugPrint('드래프트 이미 삭제됨 또는 없음 - order: $draftOrder');
                      continue; // 데이터 없음으로 처리
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                '드래프트 삭제 실패 (order $draftOrder): ${e.response?.statusCode} - ${e.message}')),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('드래프트 삭제 실패 (order $draftOrder): $e')),
                    );
                  }
                }
              }
              Navigator.pop(context); // 다이얼로그 닫기
              context.pushNamed('sendLetter'); // 새로 작성으로 이동
            },
            onSave: () async {
              // 임시저장 데이터 로드 (SendLetterPage에서 처리)
              Navigator.pop(context); // 다이얼로그 닫기
              context.pushNamed('sendLetter'); // 불러오기 위해 SendLetterPage로 이동
            },
            onDismiss: () => Navigator.pop(context),
          );
        },
      );
    });
  }
}
