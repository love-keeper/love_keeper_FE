// agreementbox.dart > 회원가입시 약관동의 바텀시트에 사용되는 위젯
import 'package:flutter/material.dart';

Widget buildAgreementRow(String text, double scaleFactor) {
  return Container(
    width: 335 * scaleFactor,
    height: 24 * scaleFactor,
    margin: EdgeInsets.symmetric(vertical: 4 * scaleFactor), // 상하 2씩 간격
    child: Row(
      children: [
        Expanded(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16 * scaleFactor,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF27282C),
              height: 24 / (16 * scaleFactor),
              letterSpacing: -0.025 * (16 * scaleFactor),
            ),
          ),
        ),
        SizedBox(
          width: 20 * scaleFactor,
          height: 20 * scaleFactor,
          child: Checkbox(
            value: false,
            onChanged: (bool? newValue) {
              // 체크박스 상태 변경 처리 (필요에 따라 구현)
            },
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
      ],
    ),
  );
}
