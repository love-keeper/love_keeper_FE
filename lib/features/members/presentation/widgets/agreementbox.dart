import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// 약관 동의 행 위젯 생성 함수.
/// [required]는 체크 필수 여부 (기본값: true),
/// [isChecked]는 체크박스의 현재 상태를 나타내며, 부모 위젯에서 관리하는 값입니다.
/// [onChanged]는 체크박스의 상태가 변경될 때 호출되는 콜백입니다.
Widget buildAgreementRow(
  String text,
  double scaleFactor, {
  bool required = true,
  required bool isChecked, // 부모에서 관리하는 체크 상태
  required ValueChanged<bool> onChanged, // 상태 변경 시 호출되는 콜백
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20 * scaleFactor),
    child: _AgreementRow(
      text: text,
      scaleFactor: scaleFactor,
      requiredField: required,
      isChecked: isChecked,
      onChanged: onChanged,
    ),
  );
}

/// 부모에서 전달받은 isChecked 값을 그대로 사용하여 체크박스 상태를 표현하는 stateless 위젯.
/// 내부적으로 상태를 관리하지 않고, 오직 부모가 전달한 값으로만 UI를 구성합니다.
class _AgreementRow extends StatelessWidget {
  final String text;
  final double scaleFactor;
  final bool requiredField;
  final bool isChecked;
  final ValueChanged<bool> onChanged;

  const _AgreementRow({
    super.key,
    required this.text,
    required this.scaleFactor,
    required this.onChanged,
    this.requiredField = true,
    required this.isChecked,
  });

  @override
  Widget build(BuildContext context) {
    // 밑줄 적용 여부
    final bool showUnderline =
        text.contains('전체 동의') ||
        text.contains('이용약관') ||
        text.contains('개인정보');

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4 * scaleFactor),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (text.contains('이용약관')) {
                  context.push('/termsOfService');
                } else if (text.contains('개인정보')) {
                  context.push('/privacyPolicyPage');
                }
              },
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16 * scaleFactor,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF27282C),
                  height: 24 / (16 * scaleFactor),
                  letterSpacing: -0.025 * (16 * scaleFactor),
                  decoration:
                      showUnderline
                          ? TextDecoration.underline
                          : TextDecoration.none,
                  decorationColor: const Color(0xFF27282C),
                  decorationThickness: 1.0,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 20 * scaleFactor,
            height: 20 * scaleFactor,
            child: Checkbox(
              value: isChecked,
              activeColor: const Color(0xFFFF859B),
              checkColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3),
              ),
              side:
                  isChecked
                      ? null
                      : BorderSide(
                        color: const Color(0xFFC3C6CF),
                        width: 2 * scaleFactor,
                      ),
              onChanged: (bool? newValue) {
                onChanged(newValue ?? false);
              },
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ],
      ),
    );
  }
}
