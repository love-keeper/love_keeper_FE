import 'package:flutter/material.dart';

class PromiseBoxWidget extends StatelessWidget {
  final String content;
  final String date;

  const PromiseBoxWidget({
    super.key,
    required this.content,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // 부모의 패딩 안에 꽉 차도록
      height: 112, // iPhone 13 기준 높이 (반응형 조정 가능)
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white, // 원하는 배경색 (예: white)
        borderRadius: BorderRadius.circular(20),
        // 그림자 없음
      ),
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // 본문은 위쪽, 날짜는 패딩 하단에 고정
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 본문 텍스트
          Text(
            content,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.4, // 약 16의 -2.5%
              height: 24 / 16, // 라인헤이트 24
              color: Color(0xFF27282C),
            ),
          ),
          // 날짜 텍스트 (컨테이너 패딩 하단에 고정)
          Text(
            date,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              letterSpacing: -0.35, // 약 14의 -2.5%
              height: 24 / 14, // 라인헤이트 24
              color: Color(0xFF747784),
            ),
          ),
        ],
      ),
    );
  }
}
