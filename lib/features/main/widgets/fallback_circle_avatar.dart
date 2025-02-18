import 'package:flutter/material.dart';

class FallbackCircleAvatar extends StatelessWidget {
  final String imagePath;
  final double radius;
  final String fallbackPath;

  const FallbackCircleAvatar({
    super.key,
    required this.imagePath,
    required this.radius,
    required this.fallbackPath,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.transparent,
      child: ClipOval(
        child: Image.asset(
          imagePath,
          width: radius * 2,
          height: radius * 2,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            // 이미지 로딩 실패 시 fallback 이미지 표시
            return Image.asset(
              fallbackPath,
              width: radius * 2,
              height: radius * 2,
              fit: BoxFit.cover,
            );
          },
        ),
      ),
    );
  }
}
