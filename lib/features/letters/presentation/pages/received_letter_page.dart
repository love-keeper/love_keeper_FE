import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:love_keeper/features/letters/presentation/widgets/letter_preview.dart';
import 'package:love_keeper/features/members/presentation/viewmodels/members_viewmodel.dart';
import 'package:love_keeper/features/members/domain/entities/member_info.dart';

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
    final String letterId = letterData['id'] ?? '';

    // 현재 사용자 정보 가져오기
    final String receiverName =
        memberInfoState is AsyncData<MemberInfo?>
            ? memberInfoState.value?.nickname ?? '나'
            : '나';

    // 답장하기 버튼 클릭 시 실행될 함수
    void onReplyTap() {
      // /replyLetter 페이지로 이동
      context.go(
        '/replyLetter',
        extra: {
          'letterId': letterId,
          'senderName': senderName,
          'content': content,
        },
      );
    }

    // 외부 영역 탭 시 메인으로 돌아가기
    void onOutsideTap() {
      context.go('/main');
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
