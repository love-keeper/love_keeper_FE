import 'package:flutter/material.dart';

/// 하단에 고정되어 저장(변경) 버튼 역할을 하는 위젯
class SaveButtonWidget extends StatelessWidget {
  final double scaleFactor;
  final bool enabled;
  final String buttonText;
  final VoidCallback onPressed;

  const SaveButtonWidget({
    Key? key,
    required this.scaleFactor,
    required this.enabled,
    required this.buttonText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 키보드가 올라와도 버튼은 항상 보이도록 bottomNavigationBar에 배치합니다.
    return Padding(
      padding: EdgeInsets.only(
        top: 0 * scaleFactor,
        left: 20 * scaleFactor,
        right: 20 * scaleFactor,
        bottom: MediaQuery.of(context).viewInsets.bottom + 15,
      ),
      child: SizedBox(
        width: 334 * scaleFactor,
        height: 52 * scaleFactor,
        child: GestureDetector(
          onTap: enabled ? onPressed : null,
          child: Container(
            decoration: BoxDecoration(
              color:
                  enabled ? const Color(0xFFFF859B) : const Color(0xFFC3C6CF),
              borderRadius: BorderRadius.circular(55 * scaleFactor),
            ),
            child: Center(
              child: Text(
                buttonText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16 * scaleFactor,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  height: 24 / 16,
                  letterSpacing: -0.025 * (16 * scaleFactor),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
