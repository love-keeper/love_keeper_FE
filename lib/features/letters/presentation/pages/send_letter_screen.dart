import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:love_keeper/features/letters/presentation/viewmodels/letters_viewmodel.dart';
import 'dart:convert';

// 간단한 상태 열거형으로 UI 상태 관리
enum LetterSendState { sending, success, failed }

class SendLetterScreen extends ConsumerStatefulWidget {
  final String receiverName;
  final String letterContent;
  final VoidCallback onComplete;

  const SendLetterScreen({
    Key? key,
    required this.receiverName,
    required this.letterContent,
    required this.onComplete,
  }) : super(key: key);

  @override
  _SendLetterScreenState createState() => _SendLetterScreenState();
}

class _SendLetterScreenState extends ConsumerState<SendLetterScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  LetterSendState _state = LetterSendState.sending;
  bool _animationTimerCompleted = false;

  // 오류 메시지 저장 변수
  String _errorMessage = "편지 전송에 실패했습니다. 관리자에게 문의해주세요.";

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

    // 3초 후 타이머 완료 설정
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _animationTimerCompleted = true;
        });

        // 이미 API 응답이 왔다면 UI 업데이트
        if (_state != LetterSendState.sending) {
          _updateUIBasedOnState();
        }
      }
    });

    // API 호출 시작
    _sendLetter();
  }

  // API 호출 메서드
  Future<void> _sendLetter() async {
    debugPrint('편지 전송 시작: "${widget.letterContent}"');

    try {
      final response = await ref
          .read(lettersViewModelProvider.notifier)
          .createLetter(widget.letterContent);

      debugPrint('편지 전송 응답: $response');
      debugPrint('응답 타입: ${response.runtimeType}');

      if (mounted) {
        setState(() {
          // 성공으로 처리 (실제 로그에서 성공으로 확인됨)
          _state = LetterSendState.success;
          widget.onComplete();

          // 로그 확인을 위한 코드
          try {
            if (response is String) {
              if (response.startsWith('{') && response.endsWith('}')) {
                try {
                  final Map<String, dynamic> responseData = jsonDecode(
                    response,
                  );
                  debugPrint('응답 파싱 성공: $responseData');
                  // 파싱된 결과 로깅만 하고 상태는 변경하지 않음 (이미 성공으로 설정됨)
                } catch (parseError) {
                  debugPrint('JSON 파싱 오류 (무시됨): $parseError');
                }
              } else {
                debugPrint('응답이 JSON 형식이 아님 (무시됨): $response');
              }
            }
          } catch (logError) {
            debugPrint('응답 로깅 중 오류 (무시됨): $logError');
          }
        });

        _updateUIBasedOnState();
      }
    } catch (e) {
      debugPrint('편지 전송 실패: $e');

      if (mounted) {
        setState(() {
          _state = LetterSendState.failed;

          // 오류 유형에 따라 구체적인 메시지 제공
          if (e is DioException) {
            if (e.response?.statusCode == 404) {
              _errorMessage = '편지를 찾을 수 없습니다.';
            } else if (e.response?.statusCode == 401) {
              _errorMessage = '인증에 실패했습니다. 다시 로그인해주세요.';
            } else if (e.response?.statusCode == 500) {
              _errorMessage = '서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.';
            } else {
              _errorMessage = '편지 전송 중 오류가 발생했습니다.';
            }

            // 응답 본문이 있으면 로그에 출력
            if (e.response?.data != null) {
              debugPrint('오류 응답 내용: ${e.response?.data}');
            }
          } else {
            _errorMessage = '편지 전송 중 오류가 발생했습니다.';
          }
        });

        _updateUIBasedOnState();
      }
    }
  }

  // 상태에 따른 UI 업데이트
  void _updateUIBasedOnState() {
    debugPrint('UI 상태 업데이트: $_state');
    // 타이머가 완료되었거나 보내는 중이 아닌 경우에만 애니메이션 중지
    if (_animationTimerCompleted || _state != LetterSendState.sending) {
      _animationController.stop();
    }
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
                      text:
                          _state == LetterSendState.success
                              ? " 님에게\n무사히 전달했어요!"
                              : _state == LetterSendState.failed
                              ? " 님에게\n편지 전송에 실패했어요"
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
          // 실패 메시지 표시 (실패 상태일 때만)
          if (_state == LetterSendState.failed)
            Positioned(
              left: 20 * scaleFactor,
              top: 550 * scaleFactor,
              child: Container(
                width: 335 * scaleFactor,
                padding: EdgeInsets.all(16 * scaleFactor),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(8 * scaleFactor),
                ),
                child: Text(
                  _errorMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14 * scaleFactor,
                    color: const Color(0xFF666666),
                    height: 20 / 14,
                  ),
                ),
              ),
            ),
          // 성공이나 실패 상태일 때 버튼 표시
          if (_state == LetterSendState.success ||
              _state == LetterSendState.failed) ...[
            Positioned(
              left: 20 * scaleFactor,
              top: 662 * scaleFactor,
              child: SizedBox(
                width: 335 * scaleFactor,
                height: 52 * scaleFactor,
                child: ElevatedButton(
                  onPressed: () {
                    // 이전 스택을 모두 제거하고 메인 페이지로 이동합니다.
                    context.go('/main');
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
                      height: 24 / (16 * scaleFactor),
                      letterSpacing: -0.025 * (16 * scaleFactor),
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
                    // 이전 스택을 모두 제거하고 메인 페이지로 이동합니다.
                    context.go('/storage');
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
                      height: 24 / (16 * scaleFactor),
                      letterSpacing: -0.025 * (16 * scaleFactor),
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
