import 'package:flutter/material.dart';

class CustomInfoCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final bool isLocked; // 🔒 잠금 여부

  const CustomInfoCard({
    super.key,
    required this.title,
    required this.imagePath,
    this.isLocked = false, // 기본값 false
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 128,
      decoration: BoxDecoration(
        color: isLocked ? const Color(0xFFBDBDBD) : Colors.white, // 배경 회색
        borderRadius: BorderRadius.circular(20),
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
            padding: const EdgeInsets.only(top: 18, left: 18),
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
            bottom: 9,
            right: 9,
            child: Image.asset(
              imagePath,
              width: 64,
              height: 64,
              fit: BoxFit.contain,
            ),
          ),
          if (isLocked) ...[
            // 🔒 잠금 오버레이
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.25),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            Center(
              child: Image.asset(
                'assets/images/main_page/mingcute_lock-fill.png',
                width: 40,
                height: 40,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
