import 'package:flutter/material.dart';

class SendLetterScreen extends StatefulWidget {
  final String receiverName;
  final VoidCallback onComplete;

  const SendLetterScreen(
      {Key? key, required this.receiverName, required this.onComplete})
      : super(key: key);

  @override
  _SendLetterScreenState createState() => _SendLetterScreenState();
}

class _SendLetterScreenState extends State<SendLetterScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _completed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        widget.onComplete();
        _animationController.stop();
        setState(() {
          _completed = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    const double baseWidth = 375.0;
    final double scaleFactor = deviceWidth / baseWidth;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/letter_page/background.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 21 * scaleFactor,
            top: 133 * scaleFactor,
            child: Container(
              width: 335 * scaleFactor,
              height: 70 * scaleFactor,
              alignment: Alignment.topCenter,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 24 * scaleFactor,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF27282C),
                    height: 35 / 24,
                    letterSpacing: -(24 * 0.065) * scaleFactor,
                  ),
                  children: [
                    TextSpan(
                      text: widget.receiverName,
                      style: const TextStyle(color: Color(0xFFFB5681)),
                    ),
                    TextSpan(
                      text: _completed
                          ? " 님에게\n무사히 전달했어요!"
                          : " 님에게\n편지를 보내는 중이에요",
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 87 * scaleFactor,
            top: 300 * scaleFactor,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _animation.value),
                  child: child,
                );
              },
              child: Image.asset(
                'assets/images/letter_page/Img_Letter.png',
                width: 201 * scaleFactor,
                height: 201 * scaleFactor,
              ),
            ),
          ),
          if (_completed) ...[
            Positioned(
              left: 20 * scaleFactor,
              top: 662 * scaleFactor,
              child: SizedBox(
                width: 335 * scaleFactor,
                height: 52 * scaleFactor,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF859B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26 * scaleFactor),
                    ),
                  ),
                  child: Text(
                    "홈으로 가기",
                    style: TextStyle(
                      fontSize: 16 * scaleFactor,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: ((375 - 162) / 2) * scaleFactor,
              top: 714 * scaleFactor,
              child: SizedBox(
                width: 162 * scaleFactor,
                height: 52 * scaleFactor,
                child: TextButton(
                  onPressed: () {
                    // 보관함으로 이동하는 로직 추가
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
                  ),
                  child: Text(
                    "보관함 가기",
                    style: TextStyle(
                      fontSize: 16 * scaleFactor,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFFF859B),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
