import 'package:flutter/services.dart';

class DateTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // 입력값에서 숫자와 점만 남기고 나머지 제거
    String newText = newValue.text.replaceAll(RegExp(r'[^\d.]'), '');
    String oldText = oldValue.text.replaceAll(RegExp(r'[^\d.]'), '');

    // 숫자만 추출
    String digitsOnly = newText.replaceAll('.', '');
    if (digitsOnly.length > 8) {
      digitsOnly = digitsOnly.substring(0, 8);
      newText = digitsOnly; // 길이 제한 후 점 없는 상태로 시작
    }

    // 삭제인지 확인
    bool isDeleting = newText.length < oldText.length;
    int len = digitsOnly.length;

    // 포맷팅된 결과
    String formatted = '';
    if (isDeleting) {
      // 삭제 시 숫자만 남기고 점은 입력 로직에서 추가
      formatted = digitsOnly;
    } else {
      // 입력 시 점 추가 (마지막 점은 추가하지 않음)
      if (len <= 4) {
        formatted = digitsOnly;
        if (len == 4) formatted += '.'; // YYYY 입력 끝나면 점 추가
      } else if (len <= 6) {
        formatted = '${digitsOnly.substring(0, 4)}.${digitsOnly.substring(4)}';
        if (len == 6) formatted += '.'; // MM 입력 끝나면 점 추가
      } else {
        formatted =
            '${digitsOnly.substring(0, 4)}.${digitsOnly.substring(4, 6)}.${digitsOnly.substring(6)}';
        // len == 8일 때 추가 점 없음
      }
    }

    // 커서 위치 계산
    int baseOffset = newValue.selection.baseOffset;
    String prefix = newValue.text
        .substring(0, baseOffset)
        .replaceAll(RegExp(r'[^\d.]'), '');
    int digitCountBeforeCursor = prefix.replaceAll('.', '').length;
    int punctuationCount = 0;
    if (!isDeleting) {
      if (digitCountBeforeCursor >= 4) punctuationCount++; // YYYY 뒤 점
      if (digitCountBeforeCursor >= 6) punctuationCount++; // MM 뒤 점
    }
    int newCursorOffset = digitCountBeforeCursor + punctuationCount;
    if (newCursorOffset > formatted.length) {
      newCursorOffset = formatted.length;
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: newCursorOffset),
    );
  }
}
