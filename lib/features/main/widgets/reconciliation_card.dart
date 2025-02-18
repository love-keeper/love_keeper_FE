import 'package:flutter/material.dart';

class ReconciliationCard extends StatelessWidget {
  const ReconciliationCard({super.key});

  @override
  Widget build(BuildContext context) {
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
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
          Padding(
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
        ],
      ),
    );
  }
}
