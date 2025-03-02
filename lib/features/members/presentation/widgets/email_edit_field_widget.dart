import 'dart:async';
import 'package:flutter/material.dart';

/// 이메일 전용 입력 위젯 (타이머와 재전송 버튼 포함)
class EmailEditFieldWidget extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final double scaleFactor;
  final bool autofocus;
  final String guideMessage;
  final VoidCallback? onResend; // 재전송 버튼 콜백
  final FocusNode? focusNode;

  const EmailEditFieldWidget({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    required this.scaleFactor,
    this.autofocus = false,
    this.guideMessage = '',
    this.focusNode,
    this.onResend,
  });

  @override
  _EmailEditFieldWidgetState createState() => _EmailEditFieldWidgetState();
}

class _EmailEditFieldWidgetState extends State<EmailEditFieldWidget> {
  bool get hasText => widget.controller.text.isNotEmpty;
  Timer? _timer;
  int _remainingSeconds = 300; // 5분 = 300초

//입력 변화감지.
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {});
    });
    startTimer();
  }

  void startTimer() {
    _remainingSeconds = 300;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return; // 위젯이 트리에서 제거되었으면 아무 작업도 하지 않음
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get timerText {
    final minutes = (_remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 라벨 영역
        SizedBox(
          width: 63 * widget.scaleFactor,
          height: 24 * widget.scaleFactor,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.label,
              style: TextStyle(
                fontSize: 14 * widget.scaleFactor,
                fontWeight: FontWeight.w400,
                height: 22 / 14,
                letterSpacing: -0.025 * (14 * widget.scaleFactor),
                color: const Color(0xFF747784),
              ),
            ),
          ),
        ),
        // 텍스트 필드 영역 (타이머 및 삭제 아이콘 포함)
        SizedBox(
          width: 335 * widget.scaleFactor,
          height: 38 * widget.scaleFactor,
          child: Stack(
            children: [
              TextField(
                autofocus: widget.autofocus,
                focusNode: widget.focusNode,
                controller: widget.controller,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18 * widget.scaleFactor,
                  fontWeight: FontWeight.w600,
                  height: 26 / 18,
                  color: hasText
                      ? const Color(0xFF27282C)
                      : const Color(0xFFC3C6CF),
                  letterSpacing: -0.025 * (18 * widget.scaleFactor),
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                    fontSize: 18 * widget.scaleFactor,
                    fontWeight: FontWeight.w600,
                    height: 26 / 18,
                    letterSpacing: -0.025 * (18 * widget.scaleFactor),
                    color: const Color(0xFFC3C6CF),
                  ),
                  // 오른쪽에 충분한 공간을 남겨둠 (타이머와 삭제 아이콘용)
                  contentPadding: EdgeInsets.fromLTRB(
                    0 * widget.scaleFactor,
                    4 * widget.scaleFactor,
                    80 * widget.scaleFactor,
                    8 * widget.scaleFactor,
                  ),
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0.5 * widget.scaleFactor,
                child: Container(
                  height: 1.5 * widget.scaleFactor,
                  color: const Color(0xFFFF859B),
                ),
              ),
              // 타이머 텍스트는 사용자가 입력하지 않았을 때만 표시 (텍스트 필드 오른쪽 끝에 위치)
              if (!hasText)
                Positioned(
                  right: 0,
                  top: (38 * widget.scaleFactor - 24 * widget.scaleFactor) / 2,
                  child: Text(
                    timerText,
                    style: TextStyle(
                      fontSize: 16 * widget.scaleFactor,
                      fontWeight: FontWeight.w400,
                      height: 24 / 16,
                      letterSpacing: -0.025 * (1 * widget.scaleFactor),
                      color: const Color(0xFFFF859B),
                    ),
                  ),
                ),
              // 삭제 아이콘: 사용자가 입력한 경우, 타이머 대신 삭제 아이콘이 표시됨
              if (hasText)
                Positioned(
                  right: 0,
                  top: (38 * widget.scaleFactor - 24 * widget.scaleFactor) / 2,
                  child: GestureDetector(
                    onTap: () {
                      widget.controller.clear();
                    },
                    child: Image.asset(
                      'assets/images/my_page/Ic_Delete.png',
                      width: 24 * widget.scaleFactor,
                      height: 24 * widget.scaleFactor,
                    ),
                  ),
                ),
            ],
          ),
        ),
        // 안내 문구와 재전송 버튼를 한 줄(Row)에 배치 (텍스트 필드 바로 아래 6만큼 여백)
        SizedBox(height: 6 * widget.scaleFactor),
        SizedBox(
          height: 18 * widget.scaleFactor,
          child: Row(
            children: [
              // 안내 문구 (왼쪽 정렬)
              Expanded(
                child: Text(
                  widget.guideMessage,
                  style: TextStyle(
                    fontSize: 12 * widget.scaleFactor,
                    fontWeight: FontWeight.w400,
                    height: 18 / 12,
                    letterSpacing: -0.025 * (12 * widget.scaleFactor),
                    color: const Color(0xFFFF859B),
                  ),
                ),
              ),
              //재전송 버튼
              SizedBox(
                width: 36 * widget.scaleFactor,
                height: 22 * widget.scaleFactor,
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () {
                    if (widget.onResend != null) {
                      widget.onResend!();
                      startTimer(); // 재전송 시 타이머 재시작
                    }
                  },
                  child: Text(
                    '재전송',
                    style: TextStyle(
                      fontSize: 14 * widget.scaleFactor,
                      fontWeight: FontWeight.w600,
                      height: 22 / 14,
                      letterSpacing: -0.025 * (14 * widget.scaleFactor),
                      color: const Color(0xFFFF859B),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
