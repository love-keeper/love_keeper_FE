import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditFieldWidget extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final double scaleFactor;
  final bool autofocus;
  final String guideMessage;
  final bool obscureText;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode; // FocusNode 추가

  const EditFieldWidget({
    Key? key,
    required this.label,
    required this.hintText,
    required this.controller,
    required this.scaleFactor,
    this.autofocus = false,
    this.guideMessage = "",
    this.obscureText = false,
    this.readOnly = false,
    this.inputFormatters,
    this.focusNode, // 매개변수 추가
  }) : super(key: key);

  @override
  _EditFieldWidgetState createState() => _EditFieldWidgetState();
}

class _EditFieldWidgetState extends State<EditFieldWidget> {
  bool get hasText => widget.controller.text.isNotEmpty;

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
        SizedBox(
          width: 335 * widget.scaleFactor,
          height: 38 * widget.scaleFactor,
          child: Stack(
            children: [
              TextField(
                autofocus: widget.autofocus,
                controller: widget.controller,
                focusNode: widget.focusNode, // FocusNode 적용
                textAlign: TextAlign.left,
                readOnly: widget.readOnly,
                obscureText: widget.obscureText,
                inputFormatters: widget.inputFormatters,
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
                    0 * widget.scaleFactor,
                    4 * widget.scaleFactor,
                    24 * widget.scaleFactor,
                    8 * widget.scaleFactor,
                  ),
                ),
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
