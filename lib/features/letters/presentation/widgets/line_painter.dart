import 'package:flutter/material.dart';

class LinePainter extends CustomPainter {
  final bool isDashed;
  final Color color;

  LinePainter({required this.isDashed, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0;
    if (isDashed) {
      const dashWidth = 4.0;
      const dashSpace = 4.0;
      double startX = 0;
      while (startX < size.width) {
        canvas.drawLine(
          Offset(startX, size.height / 2),
          Offset(startX + dashWidth, size.height / 2),
          paint,
        );
        startX += dashWidth + dashSpace;
      }
    } else {
      canvas.drawLine(
        Offset(0, size.height / 2),
        Offset(size.width, size.height / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
