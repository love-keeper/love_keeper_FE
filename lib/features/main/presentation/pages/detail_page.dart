import 'package:flutter/material.dart';
import 'package:love_keeper_fe/features/main/widgets/letter_box_widget.dart';
import 'package:love_keeper_fe/features/main/widgets/promise_box_widget.dart';

class DetailPage extends StatelessWidget {
  final DateTime selectedDay;
  final String type; // "letter" 또는 "promise"

  DetailPage({
    super.key,
    required this.selectedDay,
    required this.type,
  });

  // 샘플 데이터 (실제 프로젝트에서는 백엔드 데이터를 사용)
  final List<Map<String, String>> sampleLetters = [
    {
      'user': '돌돌',
      'content': '내가 너무 심했던 것 같아 용서해 줄 수 있어? 다시해와 엊꺼ㅜ우',
      'date': '2025. 02. 01.'
    },
    {
      'user': '미미',
      'content': '예시 내용입니다. 이것은 긴 내용일 경우 생략됩니다. 어쩌라고',
      'date': '2025. 02. 02.'
    },
    {
      'user': '돌돌',
      'content': '내가 너무 심했던 것 같아 용서해 줄 수 있어? 다시해와 엊꺼ㅜ우',
      'date': '2025. 02. 01.'
    },
    {
      'user': '미미',
      'content': '예시 내용입니다. 이것은 긴 내용일 경우 생략됩니다. 어쩌라고',
      'date': '2025. 02. 02.'
    },
    // 추가 데이터...
  ];

  final List<Map<String, String>> samplePromises = [
    {
      'title': '첫 번째 약속',
      'content': '약속 내용이 이곳에 표시됩니다. 자세한 내용은 생략될 수 있습니다.',
      'date': '2025. 03. 01.'
    },
    {
      'title': '두 번째 약속',
      'content': '또 다른 약속의 내용이 여기에 표시됩니다. 내용이 길 경우 ... 처리됩니다.',
      'date': '2025. 03. 05.'
    },
    // 추가 데이터...
  ];

  @override
  Widget build(BuildContext context) {
    // 앱바 제목: "n월 n일" (요일은 제외)
    String title = "${selectedDay.month}월 ${selectedDay.day}일";

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent, // 앱바를 투명하게
        elevation: 0,
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.45,
            color: Color(0xFF27282C),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/storage_page/Img_ArchivedCalender_BG.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: type == "letter"
            ? _buildLetterGrid(context)
            : _buildPromiseList(context),
      ),
    );
  }

  Widget _buildLetterGrid(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double boxWidth = (screenWidth - 55) / 2;
    final double boxHeight = boxWidth * (160 / 156);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        padding: const EdgeInsets.only(bottom: 20, top: 140),
        itemCount: sampleLetters.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 한 줄에 두 개의 박스
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: boxWidth / boxHeight,
        ),
        itemBuilder: (context, index) {
          final letter = sampleLetters[index];
          return LetterBoxWidget(
            title: "${letter['user'] ?? '알 수 없음'}의 편지",
            content: letter['content'] ?? "",
            date: letter['date'] ?? "",
          );
        },
      ),
    );
  }

  Widget _buildPromiseList(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 140),
      itemCount: samplePromises.length,
      itemBuilder: (context, index) {
        final promise = samplePromises[index];
        return Padding(
          padding: const EdgeInsets.only(
            bottom: 15,
          ),
          child: PromiseBoxWidget(
            content: promise['content'] ?? "",
            date: promise['date'] ?? "",
          ),
        );
      },
    );
  }
}
