import 'package:flutter/material.dart';

class AdSection extends StatelessWidget {
  const AdSection({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double boxWidth = screenWidth - 40; // 좌우 패딩 고려한 너비 조정

    return Center(
      child: Container(
        width: boxWidth, // 조정된 박스 너비
        height: 160, // 박스 높이
        padding: const EdgeInsets.all(18), // 내부 패딩
        decoration: BoxDecoration(
          color: Colors.white, // 배경 흰색
          borderRadius: BorderRadius.circular(20), // 모서리 둥글게
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.05),
              offset: Offset(0, 0), // 그림자 방향
              blurRadius: 5,
              spreadRadius: 0,
            ),
          ],
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '광고',
              style: TextStyle(
                fontSize: 14, // 폰트 크기
                fontWeight: FontWeight.w400,
                color: Color(0xFF4D4F58), // 제목 색상
              ),
            ),
            SizedBox(height: 9), // 광고와 새로운 텍스트 간 간격
            SizedBox(
              width: 250, // 텍스트 박스 너비 설정
              child: Text(
                '우리 서로 너무너무 사랑해요 알려뷰 알려븅 ㅎㅎㅎ', // 광고 내용 텍스트
                style: TextStyle(
                  fontSize: 18, // 추가 텍스트 크기
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF27282C), // 텍스트 색상
                ),
                softWrap: true, // 자동 줄바꿈 활성화
                maxLines: 3, // 최대 3줄까지 표시
                overflow: TextOverflow.visible, // 텍스트가 넘칠 때 처리 방식
              ),
            ),
          ],
        ),
      ),
    );
  }
}
