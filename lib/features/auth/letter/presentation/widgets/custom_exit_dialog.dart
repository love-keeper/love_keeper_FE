import 'package:flutter/material.dart';

class CustomExitDialog extends StatefulWidget {
  final double scaleFactor;
  final VoidCallback onExit; // '나가기' 버튼 동작
  final VoidCallback onSave; // '저장하기' 버튼 동작
  final VoidCallback onDismiss; // 오버레이 탭 시 다이얼로그 해제

  const CustomExitDialog({
    Key? key,
    required this.scaleFactor,
    required this.onExit,
    required this.onSave,
    required this.onDismiss,
  }) : super(key: key);

  @override
  _CustomExitDialogState createState() => _CustomExitDialogState();
}

class _CustomExitDialogState extends State<CustomExitDialog>
    with SingleTickerProviderStateMixin {
  late double _dragOffset;
  late AnimationController _animationController;
  late Animation<double> _animation;
  final double threshold = 50.0; // 드래그 임계값

  @override
  void initState() {
    super.initState();
    // 박스 높이(288 * scaleFactor)만큼 음수로 초기 설정 → 화면 아래에 숨김
    _dragOffset = -288 * widget.scaleFactor;
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    // 입장 애니메이션: _dragOffset을 초기값(-288*scaleFactor)에서 0으로
    _animation =
        Tween<double>(begin: _dragOffset, end: 0).animate(_animationController)
          ..addListener(() {
            setState(() {
              _dragOffset = _animation.value;
            });
          });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    setState(() {
      // 아래로 드래그하면 details.delta.dy가 양수 → _dragOffset을 반대로 적용하여 음수로 감소
      _dragOffset -= details.delta.dy;
      // 위로 드래그하면 _dragOffset가 양수가 되므로 0으로 제한 (최대 0)
      if (_dragOffset > 0) _dragOffset = 0;
    });
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    if (_dragOffset.abs() > threshold) {
      widget.onDismiss();
    } else {
      // 임계값 미만이면 원래 위치(0)로 복귀 애니메이션
      _animation = Tween<double>(begin: _dragOffset, end: 0)
          .animate(_animationController)
        ..addListener(() {
          setState(() {
            _dragOffset = _animation.value;
          });
        });
      _animationController.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 50% 불투명 오버레이 (배경 유지)
        GestureDetector(
          onTap: widget.onDismiss,
          behavior: HitTestBehavior.opaque,
          child: Container(
            color: const Color(0x8027282C), // 50% opacity of 0xFF27282C
          ),
        ),
        // 하단 흰색 박스; Positioned의 bottom이 _dragOffset에 따라 조정됨
        Positioned(
          left: 0,
          right: 0,
          bottom: _dragOffset,
          child: GestureDetector(
            onVerticalDragUpdate: _onVerticalDragUpdate,
            onVerticalDragEnd: _onVerticalDragEnd,
            child: Container(
              width: 375 * widget.scaleFactor,
              height: 288 * widget.scaleFactor,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16 * widget.scaleFactor),
                  topRight: Radius.circular(16 * widget.scaleFactor),
                ),
              ),
              child: Column(
                children: [
                  // 드래그 핸들 (상단에서 7 포인트 아래)
                  Padding(
                    padding: EdgeInsets.only(top: 7 * widget.scaleFactor),
                    child: Container(
                      width: 50 * widget.scaleFactor,
                      height: 5 * widget.scaleFactor,
                      decoration: BoxDecoration(
                        color: const Color(0xFFC3C6CF),
                        borderRadius:
                            BorderRadius.circular(26 * widget.scaleFactor),
                      ),
                    ),
                  ),
                  // 44 포인트 간격
                  SizedBox(height: 44 * widget.scaleFactor),
                  // 투명 박스 (165x26): "작성을 중단하시겠어요?"
                  Container(
                    width: 165 * widget.scaleFactor,
                    height: 26 * widget.scaleFactor,
                    color: Colors.transparent,
                    alignment: Alignment.topCenter,
                    child: Text(
                      "작성을 중단하시겠어요?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18 * widget.scaleFactor,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF27282C),
                        height: 26 / 18,
                        letterSpacing: -(18 * 0.025),
                      ),
                    ),
                  ),
                  // 29 포인트 간격
                  SizedBox(height: 29 * widget.scaleFactor),
                  // 투명 박스 (335x48): "나가기 선택 시,\n작성된 편지는 저장되지 않습니다."
                  Container(
                    width: 335 * widget.scaleFactor,
                    height: 48 * widget.scaleFactor,
                    color: Colors.transparent,
                    alignment: Alignment.topCenter,
                    child: Text(
                      "나가기 선택 시,\n작성된 편지는 저장되지 않습니다.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16 * widget.scaleFactor,
                        fontWeight: FontWeight.normal,
                        color: const Color(0xFF27282C),
                        height: 24 / 16,
                        letterSpacing: -(16 * 0.025),
                      ),
                    ),
                  ),
                  // 27 포인트 간격 (버튼 영역 시작 전)
                  SizedBox(height: 27 * widget.scaleFactor),
                  // 버튼 영역: 두 개의 버튼 (각 162x52, 사이 12, 가운데 정렬)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 162 * widget.scaleFactor,
                        height: 52 * widget.scaleFactor,
                        child: ElevatedButton(
                          onPressed: widget.onExit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFC3C6CF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  26 * widget.scaleFactor),
                            ),
                          ),
                          child: Text(
                            '나가기',
                            style: TextStyle(
                              fontSize: 16 * widget.scaleFactor,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12 * widget.scaleFactor),
                      SizedBox(
                        width: 162 * widget.scaleFactor,
                        height: 52 * widget.scaleFactor,
                        child: ElevatedButton(
                          onPressed: widget.onSave,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF859B),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  26 * widget.scaleFactor),
                            ),
                          ),
                          child: Text(
                            '저장하기',
                            style: TextStyle(
                              fontSize: 16 * widget.scaleFactor,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16 * widget.scaleFactor),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
