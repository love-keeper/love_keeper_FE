import 'package:flutter/material.dart';

class CustomBottomSheetDialog extends StatefulWidget {
  final double scaleFactor;
  final String title;
  final String content;
  final String exitText;
  final String saveText;
  final bool showSaveButton;
  final VoidCallback onExit;
  final VoidCallback? onSave;
  final VoidCallback onDismiss;

  const CustomBottomSheetDialog({
    Key? key,
    required this.scaleFactor,
    required this.title,
    required this.content,
    required this.exitText,
    this.saveText = "저장하기",
    this.showSaveButton = true,
    required this.onExit,
    this.onSave,
    required this.onDismiss,
  }) : super(key: key);

  @override
  _CustomBottomSheetDialogState createState() =>
      _CustomBottomSheetDialogState();
}

class _CustomBottomSheetDialogState extends State<CustomBottomSheetDialog>
    with SingleTickerProviderStateMixin {
  late double _dragOffset;
  late AnimationController _animationController;
  late Animation<double> _animation;
  final double threshold = 50.0;

  @override
  void initState() {
    super.initState();
    _dragOffset = -288 * widget.scaleFactor;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
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
      _dragOffset -= details.delta.dy;
      if (_dragOffset > 0) _dragOffset = 0;
    });
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    if (_dragOffset.abs() > threshold) {
      widget.onDismiss();
    } else {
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
        GestureDetector(
          onTap: widget.onDismiss,
          behavior: HitTestBehavior.opaque,
        ),
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
                  SizedBox(height: 44 * widget.scaleFactor),
                  Container(
                    width: 203 * widget.scaleFactor,
                    height: 26 * widget.scaleFactor,
                    color: Colors.transparent,
                    alignment: Alignment.topCenter,
                    child: Text(
                      widget.title,
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
                  SizedBox(height: 29 * widget.scaleFactor),
                  Container(
                    width: 335 * widget.scaleFactor,
                    height: 48 * widget.scaleFactor,
                    color: Colors.transparent,
                    alignment: Alignment.topCenter,
                    child: Text(
                      widget.content,
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
                  SizedBox(height: 31 * widget.scaleFactor),
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
                            widget.exitText,
                            style: TextStyle(
                              fontSize: 16 * widget.scaleFactor,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff27282C),
                              height: 24 / (16 * widget.scaleFactor),
                              letterSpacing: -0.025 * (16 * widget.scaleFactor),
                            ),
                          ),
                        ),
                      ),
                      if (widget.showSaveButton) ...[
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
                              widget.saveText,
                              style: TextStyle(
                                fontSize: 16 * widget.scaleFactor,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                height: 24 / (16 * widget.scaleFactor),
                                letterSpacing:
                                    -0.025 * (16 * widget.scaleFactor),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
