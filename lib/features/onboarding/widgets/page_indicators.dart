import 'package:flutter/material.dart';

class PageIndicators extends StatelessWidget {
  final int count;
  final int currentIndex;
  final double size;
  final double spacing;
  final Color activeColor;
  final Color inactiveColor;

  const PageIndicators({
    super.key,
    required this.count,
    required this.currentIndex,
    this.size = 8, // 동그라미 크기 8픽셀
    this.spacing = 8,
    this.activeColor = Colors.white, // 활성화 색상: 흰색
    this.inactiveColor = const Color(0xFFFFB6C3), // 비활성화 색상: #FFB6C3
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: size,
          height: size,
          margin: EdgeInsets.symmetric(horizontal: spacing / 2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == currentIndex ? activeColor : inactiveColor,
          ),
        );
      }),
    );
  }
}
