import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper_fe/core/config/routes/route_names.dart';
import 'package:love_keeper_fe/features/drafts/presentation/viewmodels/drafts_viewmodel.dart';
import 'package:love_keeper_fe/features/letters/presentation/widgets/custom_bottom_sheet_dialog.dart';
import 'package:love_keeper_fe/features/drafts/domain/entities/draft.dart';
import 'package:dio/dio.dart';

class ReconciliationCard extends ConsumerWidget {
  const ReconciliationCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: AssetImage('assets/images/main_page/img_main_Rectangle.png'),
          fit: BoxFit.cover,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            offset: Offset(0, 0),
            blurRadius: 5,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
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
          GestureDetector(
            onTap: () async {
              bool hasDraft = false;
              List<String?> draftContents = List.filled(4, '');
              for (int step = 0; step <= 3; step++) {
                final draftOrder = step + 1;
                try {
                  final draft = await ref
                      .read(draftsViewModelProvider.notifier)
                      .getDraft(draftOrder);
                  debugPrint('Draft response for order $draftOrder: $draft');
                  final content = draft.content ?? '';
                  draftContents[step] = content;
                  // hasDraft를 true로 설정하려면 내용이 비어있지 않아야 함.
                  if (content.trim().isNotEmpty) {
                    hasDraft = true;
                  }
                } catch (e) {
                  if (e is DioException) {
                    if (e.response?.statusCode == 404) {
                      debugPrint(
                          '드래프트 없음 - order: $draftOrder (사용자 입력 없음, 빈 문자열로 처리)');
                      draftContents[step] = '';
                      continue;
                    } else {
                      debugPrint(
                          '드래프트 확인 실패 - order: $draftOrder, Status: ${e.response?.statusCode}, Error: ${e.message}');
                    }
                  } else {
                    debugPrint('드래프트 확인 실패 - order: $draftOrder, Error: $e');
                  }
                  draftContents[step] = '';
                }
              }
              debugPrint(
                  'Has draft: $hasDraft, Draft contents: $draftContents');
              if (hasDraft) {
                _showDraftDialog(context, ref, draftContents);
              } else {
                context.pushNamed(RouteNames.sendLetter, extra: {
                  'draftContents': List.filled(4, ''),
                });
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Align(
                alignment: Alignment.centerRight,
                child: Image.asset(
                  'assets/images/main_page/letter.png',
                  width: 110,
                  height: 130,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDraftDialog(
      BuildContext context, WidgetRef ref, List<String?> draftContents) {
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
                      debugPrint(
                          '드래프트 없음 - order: $draftOrder (사용자 입력 없음, 무시)');
                      continue;
                    } else {
                      debugPrint(
                          '드래프트 삭제 실패 - order: $draftOrder, Status: ${e.response?.statusCode}, Error: ${e.message}');
                    }
                  } else {
                    debugPrint('드래프트 삭제 실패 - order: $draftOrder, Error: $e');
                  }
                }
              }
              Navigator.pop(context);
              context.pushNamed('sendLetter', extra: {
                'draftContents': List.filled(4, ''),
              });
            },
            onSave: () async {
              Navigator.pop(context);
              context.pushNamed('sendLetter', extra: {
                'draftContents': draftContents,
              });
            },
            onDismiss: () => Navigator.pop(context),
          );
        },
      );
    });
  }
}
