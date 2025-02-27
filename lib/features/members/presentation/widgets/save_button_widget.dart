// lib/features/members/presentation/widgets/save_button_widget.dart
import 'package:flutter/material.dart';

class SaveButtonWidget extends StatelessWidget {
  final double scaleFactor;
  final bool enabled;
  final String buttonText;
  final Future<void> Function()?
      onPressed; // VoidCallback -> Future<void> Function()

  const SaveButtonWidget({
    super.key,
    required this.scaleFactor,
    required this.enabled,
    required this.buttonText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 20 * scaleFactor, vertical: 10 * scaleFactor),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 52 * scaleFactor),
          backgroundColor:
              enabled ? const Color(0xFFFF859B) : const Color(0xFFC3C6CF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(55 * scaleFactor),
          ),
        ),
        onPressed: enabled ? onPressed : null,
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 16 * scaleFactor,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            height: 24 / 16,
            letterSpacing: -0.025 * (16 * scaleFactor),
          ),
        ),
      ),
    );
  }
}
