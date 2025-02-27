//편지 작성 기본 공통 UI
import 'package:flutter/material.dart';
import 'package:love_keeper_fe/features/letters/presentation/widgets/step_indicator.dart';

class BaseLetterPage extends StatelessWidget {
  final String
      headerText; // 상단 헤더 텍스트 (예: "OO님에게 편지를 보내는 중이에요" 또는 "OO님에게 답장을 보내는 중이에요")
  final String questionText; // 현재 단계의 질문 텍스트
  final Widget textField; // 편지 작성용 텍스트 필드 위젯
  final Widget buttonArea; // 하단 버튼 영역 위젯 (다음/완료/전송하기)
  final int currentStep; // 현재 단계 (0 ~ 3)
  final List<double> lineLengths; // 단계 표시용 선의 길이 리스트
  final double scaleFactor; // 화면 크기에 따른 스케일

  const BaseLetterPage({
    super.key,
    required this.headerText,
    required this.questionText,
    required this.textField,
    required this.buttonArea,
    required this.currentStep,
    required this.lineLengths,
    required this.scaleFactor,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 상단 헤더 텍스트 (중앙 정렬)
            Center(
              child: Text(
                headerText,
                style: TextStyle(
                  fontSize: 24 * scaleFactor,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF27282C),
                  height: 35 / 24, // line height 35
                  letterSpacing: -(24 * 0.065) * scaleFactor, // -6.5% of 24
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            // 단계 표시 (원형 아이콘 및 선)
            StepIndicator(
              currentStep: currentStep,
              scaleFactor: scaleFactor,
              lineLengths: lineLengths,
            ),
            const SizedBox(height: 32),
            // 질문 텍스트
            Text(
              questionText,
              style: TextStyle(
                fontSize: 18 * scaleFactor,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF27282C),
              ),
            ),
            const SizedBox(height: 10),
            // 편지 작성 텍스트 필드 영역 (남은 영역 차지)
            Expanded(child: textField),
            // 하단 버튼 영역
            buttonArea,
          ],
        ),
      ),
    );
  }
}
