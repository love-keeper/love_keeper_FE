import 'package:flutter/material.dart';

class LetterBoxWidget extends StatelessWidget {
  final String title;
  final String content;
  final String date;

  const LetterBoxWidget({
    super.key,
    required this.title,
    required this.content,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20), // 박스 안의 패딩 20
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20), // 모서리 둥글게 20
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // 위, 아래 요소를 양 끝에 배치
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 상단 부분: 제목과 내용 (Column으로 묶어도 됨)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  letterSpacing: -0.45,
                  height: 26 / 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(39, 40, 44, 1),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                content,
                style: const TextStyle(
                  fontSize: 12,
                  letterSpacing: -0.3,
                  height: 20 / 12,
                  color: Color.fromRGBO(116, 119, 132, 1),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          // 하단 부분: 날짜
          Text(
            date,
            style: const TextStyle(
              fontSize: 12,
              height: 20 / 12,
              color: Color.fromRGBO(116, 119, 132, 1),
            ),
          ),
        ],
      ),
    );
  }
}
