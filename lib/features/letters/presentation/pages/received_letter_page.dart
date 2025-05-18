import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:love_keeper/features/letters/presentation/widgets/letter_preview.dart';
import 'package:love_keeper/features/members/presentation/viewmodels/members_viewmodel.dart';
import 'package:love_keeper/features/members/domain/entities/member_info.dart';
import 'package:love_keeper/features/drafts/presentation/viewmodels/drafts_viewmodel.dart';
import 'package:love_keeper/features/drafts/data/models/request/create_draft_request.dart';
import 'package:love_keeper/features/letters/presentation/widgets/custom_bottom_sheet_dialog.dart';
import 'package:dio/dio.dart';

class ReceivedLetterPage extends ConsumerWidget {
  final Map<String, dynamic> letterData;

  const ReceivedLetterPage({Key? key, required this.letterData})
    : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    const double baseWidth = 375.0;
    final double scaleFactor = deviceWidth / baseWidth;
    final memberInfoState = ref.watch(membersViewModelProvider);

    // 편지 데이터에서 정보 추출
    final String senderName = letterData['sender'] ?? '상대방';
    final String content = letterData['content'] ?? '';
    final String date = letterData['date'] ?? '';

    // index를 사용하여 letterId 대체
    final String indexStr = letterData['index'] ?? '0';

    // 현재 사용자 정보 가져오기
    final String receiverName =
        memberInfoState is AsyncData<MemberInfo?>
            ? memberInfoState.value?.nickname ?? '나'
            : '나';

    // 답장하기 버튼 클릭 시 실행될 함수
    void onReplyTap() async {
      // 드래프트 확인
      bool hasDraft = false;
      List<String?> draftContents = List.filled(4, '');

      for (int step = 0; step <= 3; step++) {
        final draftOrder = step + 1;
        try {
          // ANSWER 타입으로 드래프트 확인
          final draft = await ref
              .read(draftsViewModelProvider.notifier)
              .getDraft(draftOrder, draftType: DraftType.answer);

          debugPrint('Draft response for order $draftOrder: $draft');
          final draftContent = draft.content ?? '';
          draftContents[step] = draftContent;
          if (draftContent.trim().isNotEmpty) {
            hasDraft = true;
          }
        } catch (e) {
          if (e is DioException) {
            if (e.response?.statusCode == 404) {
              debugPrint('드래프트 없음 - order: $draftOrder (사용자 입력 없음, 빈 문자열로 처리)');
              draftContents[step] = '';
              continue;
            } else {
              debugPrint(
                '드래프트 확인 실패 - order: $draftOrder, Status: ${e.response?.statusCode}, Error: ${e.message}',
              );
            }
          } else {
            debugPrint('드래프트 확인 실패 - order: $draftOrder, Error: $e');
          }
          draftContents[step] = '';
        }
      }

      debugPrint('Has draft: $hasDraft, Draft contents: $draftContents');

      if (hasDraft) {
        // 드래프트가 있으면 바텀시트 다이얼로그 표시
        _showDraftDialog(context, ref, draftContents, {
          'index': indexStr,
          'senderName': senderName,
          'content': content,
        });
      } else {
        // 드래프트가 없으면 바로 ReplyLetterPage로 이동
        context.go(
          '/replyLetter',
          extra: {
            'index': indexStr,
            'senderName': senderName,
            'content': content,
            'draftContents': List.filled(4, ''), // 빈 드래프트 내용 전달
          },
        );
      }
    }

    // 외부 영역 탭 시 저장소 페이지로 돌아가기
    void onOutsideTap() {
      context.go('/storage'); // 저장소 페이지로 직접 이동
    }

    return Scaffold(
      body: LetterPreview(
        partnerName: senderName, // 받는 사람: 상대방 이름
        userName: receiverName, // 보낸 사람: 내 이름
        content: content,
        scaleFactor: scaleFactor,
        actionButtonText: '답장하기',
        onAction: onReplyTap,
        onOutsideTap: onOutsideTap,
      ),
    );
  }
}

// 드래프트 다이얼로그 표시 함수
void _showDraftDialog(
  BuildContext context,
  WidgetRef ref,
  List<String?> draftContents,
  Map<String, dynamic> extraData,
) {
  FocusScope.of(context).unfocus();
  Future.delayed(const Duration(milliseconds: 200), () {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true, // 탭바 위에 바텀시트 표시
      backgroundColor: Colors.transparent,
      builder: (context) {
        final scaleFactor = MediaQuery.of(context).size.width / 375.0;
        return CustomBottomSheetDialog(
          scaleFactor: scaleFactor,
          title: '작성하던 답장이 있어요!',
          content: '새로 쓰기 선택 시,\n이전 내용은 사라지게 됩니다.',
          exitText: '새로쓰기',
          saveText: '불러오기',
          showSaveButton: true,
          onExit: () async {
            // 기존 드래프트 삭제
            for (int step = 0; step <= 3; step++) {
              final draftOrder = step + 1;
              try {
                await ref
                    .read(draftsViewModelProvider.notifier)
                    .deleteDraft(draftOrder, draftType: DraftType.answer);
                debugPrint('드래프트 삭제 성공 - order: $draftOrder');
              } catch (e) {
                if (e is DioException) {
                  if (e.response?.statusCode == 404) {
                    debugPrint('드래프트 없음 - order: $draftOrder (사용자 입력 없음, 무시)');
                    continue;
                  } else {
                    debugPrint(
                      '드래프트 삭제 실패 - order: $draftOrder, Status: ${e.response?.statusCode}, Error: ${e.message}',
                    );
                  }
                } else {
                  debugPrint('드래프트 삭제 실패 - order: $draftOrder, Error: $e');
                }
              }
            }

            Navigator.pop(context); // 바텀시트 닫기

            // 새 ReplyLetterPage로 이동
            context.go(
              '/replyLetter',
              extra: {
                ...extraData,
                'draftContents': List.filled(4, ''), // 빈 드래프트 내용 전달
              },
            );
          },
          onSave: () {
            Navigator.pop(context);
            // 드래프트 내용과 함께 ReplyLetterPage로 이동
            context.go(
              '/replyLetter',
              extra: {
                ...extraData,
                'draftContents': draftContents, // 기존 드래프트 내용 전달
              },
            );
          },
          // 단순히 바텀시트만 닫기
          onDismiss: () => Navigator.pop(context),
        );
      },
    );
  });
}
