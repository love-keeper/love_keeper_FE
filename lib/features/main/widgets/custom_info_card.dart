import 'package:flutter/material.dart';

class CustomInfoCard extends StatelessWidget {
  final String title;
  final String imagePath;

  const CustomInfoCard({
    super.key,
    required this.title,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 128, // 카드 높이
      decoration: BoxDecoration(
        color: Colors.white, // 배경 흰색
        borderRadius: BorderRadius.circular(20), // 모서리 둥글게
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            offset: Offset(0, 0),
            blurRadius: 5,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 18, left: 18), // 제목 패딩
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          Positioned(
            bottom: 9, // 아이콘 이미지 아래 패딩
            right: 9, // 아이콘 이미지 오른쪽 패딩
            child: Image.asset(
              imagePath,
              width: 64, // 아이콘 크기 조정
              height: 64,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
