import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 상단 라벨과 텍스트 필드(입력 시 삭제 아이콘 포함)를 구현한 위젯
class EditFieldWidget extends StatefulWidget {
  final String label; // 예: "닉네임", "생년월일" 등
  final String hintText; // 힌트 텍스트
  final TextEditingController controller;
  final double scaleFactor;
  final bool autofocus; // autofocus 매개변수 추가
  final String guideMessage; // 조건 안내 문구
  final bool obscureText;
  final bool readOnly; // 추가: 텍스트 필드 수정 불가 여부
  final List<TextInputFormatter>? inputFormatters; // 입력 포매터 추가

  const EditFieldWidget({
    Key? key,
    required this.label,
    required this.hintText,
    required this.controller,
    required this.scaleFactor,
    this.autofocus = false, // 기본값 설정
    this.guideMessage = "",
    this.obscureText = false, // 기본값은 false
    this.readOnly = false, // 기본값 false
    this.inputFormatters,
  }) : super(key: key);

  @override
  _EditFieldWidgetState createState() => _EditFieldWidgetState();
}

class _EditFieldWidgetState extends State<EditFieldWidget> {
  bool get hasText => widget.controller.text.isNotEmpty;

  // 리스너 콜백을 별도 메소드로 분리
  void _onControllerChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onControllerChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 라벨 영역 (예: "닉네임")
        SizedBox(
          width: 89 * widget.scaleFactor,
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

        SizedBox(height: 0 * widget.scaleFactor),
        // 텍스트 필드 영역와 하단 선, 삭제 아이콘
        SizedBox(
          width: 335 * widget.scaleFactor,
          height: 38 * widget.scaleFactor,
          child: Stack(
            children: [
              TextField(
                autofocus: widget.autofocus, // 여기서 autofocus 사용
                controller: widget.controller,
                textAlign: TextAlign.left,
                readOnly: widget.readOnly,
                obscureText: widget.obscureText,
                inputFormatters: widget.inputFormatters, // 입력 포매터 적용
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
                  contentPadding: EdgeInsets.fromLTRB(
                    0 * widget.scaleFactor, // 왼쪽 패딩 0
                    4 * widget.scaleFactor, // 위에서 4만큼
                    24 * widget.scaleFactor, // 오른쪽 24만큼
                    8 * widget.scaleFactor, // 아래에서 8만큼
                  ),
                ),
              ),
              // 하단 선 (텍스트 필드 하단에서 0.5 위에 위치)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0.5 * widget.scaleFactor,
                child: Container(
                  height: 1.5 * widget.scaleFactor,
                  color: const Color(0xFFFF859B),
                ),
              ),
              // 삭제 아이콘 (텍스트 필드 오른쪽, 입력된 경우에만 표시)
              if (hasText && !widget.readOnly)
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
        // 안내 문구 (텍스트 필드 바로 아래 3 단위 여백)
        if (widget.guideMessage.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(top: 3 * widget.scaleFactor),
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
      ],
    );
  }
}
