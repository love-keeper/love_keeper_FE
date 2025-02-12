// 파일 위치: lib/features/letter/presentation/widgets/letter_preview.dart
import 'package:flutter/material.dart';

class LetterPreview extends StatelessWidget {
  final String partnerName; // 미리보기에서 표시할 받는 사람 이름
  final String userName; // 미리보기에서 표시할 보내는 사람 이름
  final String content; // 미리보기할 편지 내용 (각 단계 텍스트 결합 결과)
  final double scaleFactor; // 화면 크기에 따른 스케일 값
  final VoidCallback onAction; // "전송하기" 또는 "답장하기" 버튼 동작
  final String actionButtonText; // 버튼에 표시할 텍스트 ("전송하기" 또는 "답장하기")
  final VoidCallback onOutsideTap; // 흰색 박스 외부 탭 시 실행할 콜백 (예: 편지 작성 모드로 복귀)

  const LetterPreview({
    Key? key,
    required this.partnerName,
    required this.userName,
    required this.content,
    required this.scaleFactor,
    required this.onAction,
    required this.actionButtonText,
    required this.onOutsideTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 전체 미리보기 화면을 GestureDetector로 감싸 외부 탭 감지
    return GestureDetector(
      onTap: onOutsideTap,
      behavior: HitTestBehavior.opaque,
      child: SafeArea(
        child: Column(
          children: [
            // 흰색 미리보기 컨테이너 (내부 탭은 흡수)
            Expanded(
              child: Center(
                child: GestureDetector(
                  onTap: () {}, // 이 영역 내부에서는 onOutsideTap이 실행되지 않도록
                  child: Container(
                    width: 335.0 * scaleFactor,
                    height: 500.0 * scaleFactor,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0 * scaleFactor),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6.0,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(16.0 * scaleFactor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'To. $partnerName',
                          style: TextStyle(
                            fontSize: 18.0 * scaleFactor,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF27282C),
                          ),
                        ),
                        SizedBox(height: 10.0 * scaleFactor),
                        Container(
                          width: 295.0 * scaleFactor,
                          height: 1.0 * scaleFactor,
                          color: const Color(0xFFC3C6CF),
                        ),
                        SizedBox(height: 10.0 * scaleFactor),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Text(
                              content,
                              style: TextStyle(
                                fontSize: 16.0 * scaleFactor,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF27282C),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0 * scaleFactor),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'From. $userName',
                            style: TextStyle(
                              fontSize: 18.0 * scaleFactor,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF27282C),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // "전송하기"/"답장하기" 버튼 영역 (원래 버튼 위치 유지)
            SizedBox(
              width: 335.0 * scaleFactor,
              height: 52.0 * scaleFactor,
              child: ElevatedButton(
                onPressed: onAction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF859B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26 * scaleFactor),
                  ),
                ),
                child: Text(
                  actionButtonText,
                  style: TextStyle(
                    fontSize: 16 * scaleFactor,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // 버튼 아래 여백
            SizedBox(height: 12.0 * scaleFactor),
          ],
        ),
      ),
    );
  }
}
