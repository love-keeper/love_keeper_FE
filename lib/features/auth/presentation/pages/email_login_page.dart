import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper/core/config/routes/route_names.dart';
import 'package:love_keeper/core/providers/auth_state_provider.dart';
import 'package:love_keeper/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:love_keeper/features/couples/presentation/viewmodels/couples_viewmodel.dart';
import 'package:love_keeper/features/members/presentation/widgets/edit_field_widget.dart';
import 'package:love_keeper/features/members/presentation/widgets/save_button_widget.dart';

class EmailLoginPage extends ConsumerStatefulWidget {
  const EmailLoginPage({super.key});

  @override
  _EmailLoginPageState createState() => _EmailLoginPageState();
}

class _EmailLoginPageState extends ConsumerState<EmailLoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;
  bool showPasswordField = false;
  bool showPasswordGuide = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _emailController.addListener(() {
      setState(() {
        showPasswordGuide = false;
      });
    });
    _passwordController.addListener(() {
      setState(() {
        showPasswordGuide = false;
      });
    });
    // 초기에는 이메일 필드에 포커스
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _emailFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _handleNextOrLogin() async {
    if (!emailRegex.hasMatch(_emailController.text)) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final authViewModel = ref.read(authViewModelProvider.notifier);
      if (!showPasswordField) {
        final result = await authViewModel.emailDuplication(
          _emailController.text,
        );
        ref
            .read(authStateNotifierProvider.notifier)
            .updateEmail(_emailController.text);
        if (!mounted) return;
        setState(() {
          _isLoading = false;
        });
        if (result == '사용 가능한 이메일입니다.') {
          ref
              .read(authStateNotifierProvider.notifier)
              .updateEmail(_emailController.text);
          debugPrint('Pushing to signup with email: ${_emailController.text}');
          if (mounted) {
            context.push(
              RouteNames.signupPage,
              extra: {'email': _emailController.text},
            );
          }
        } else {
          // 이메일이 이미 등록되어 있으면 비밀번호 필드를 보여주고,
          // 먼저 이메일 필드의 포커스를 해제한 후 비밀번호 필드로 이동
          setState(() {
            showPasswordField = true;
          });
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _emailFocusNode.unfocus();
            _passwordFocusNode.requestFocus();
          });
        }
      } else {
        await authViewModel.login(
          email: _emailController.text,
          provider: 'LOCAL',
          password: _passwordController.text,
          providerId: null,
          context: context,
        );
        if (!mounted) return;
        setState(() {
          _isLoading = false;
        });
        try {
          final coupleInfo =
              await ref.read(couplesViewModelProvider.notifier).getCoupleInfo();
          if (coupleInfo != null && mounted) {
            debugPrint(
              'Couple info found: ${coupleInfo.coupleId}, navigating to MainPage',
            );
            context.go(RouteNames.mainPage);
          } else {
            debugPrint('No couple info found, navigating to CodeConnectPage');
            if (mounted) {
              context.go(RouteNames.codeConnectPage);
            }
          }
        } on DioException catch (e) {
          if (e.response?.statusCode == 404 && mounted) {
            debugPrint(
              'No couple info found (404), navigating to CodeConnectPage',
            );
            context.go(RouteNames.codeConnectPage);
          } else {
            debugPrint('Couple info fetch failed: $e');
            if (mounted) {
              context.go(RouteNames.codeConnectPage);
            }
          }
        }
      }
    } catch (e) {
      debugPrint('Error: $e');
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        if (showPasswordField) showPasswordGuide = true;
      });
      if (e is DioException && e.response?.statusCode == 409) {
        setState(() {
          showPasswordField = true;
        });
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(showPasswordField ? '로그인 실패: $e' : '이메일 확인 실패: $e'),
            ),
          );
        }
      }
    }
  }

  final RegExp emailRegex = RegExp(
    r'^[^@]+@[^@]+\.(com|net|org|edu|co\.kr|ac\.kr)$',
    caseSensitive: false,
  );

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    const double baseWidth = 375.0;
    final double scaleFactor = deviceWidth / baseWidth;

    final bool hasEmail = _emailController.text.isNotEmpty;
    final bool hasPassword = _passwordController.text.isNotEmpty;

    final String emailGuideMessage =
        hasEmail && !emailRegex.hasMatch(_emailController.text)
            ? '올바른 이메일 형식을 입력해 주세요.'
            : '';

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: const Text('이메일로 시작'),
          titleTextStyle: TextStyle(
            fontSize: 18 * scaleFactor,
            fontWeight: FontWeight.w600,
            height: 26 / 18,
            letterSpacing: -0.45 * scaleFactor,
            color: const Color(0xFF27282C),
          ),
          leading: IconButton(
            icon: Image.asset(
              'assets/images/letter_page/Ic_Back.png',
              width: 24 * scaleFactor,
              height: 24 * scaleFactor,
            ),
            onPressed: () => context.pop(),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20 * scaleFactor),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16 * scaleFactor),
                          EditFieldWidget(
                            label: '이메일',
                            hintText: '이메일 주소를 입력해 주세요.',
                            controller: _emailController,
                            scaleFactor: scaleFactor,
                            autofocus: !showPasswordField,
                            guideMessage: emailGuideMessage,
                            readOnly: showPasswordField,
                            focusNode: _emailFocusNode,
                          ),
                          if (showPasswordField) ...[
                            SizedBox(height: 36 * scaleFactor),
                            EditFieldWidget(
                              label: '비밀번호',
                              hintText: '비밀번호를 입력해 주세요.',
                              controller: _passwordController,
                              scaleFactor: scaleFactor,
                              autofocus: true,
                              guideMessage:
                                  showPasswordGuide
                                      ? '비밀번호가 일치하지 않습니다. 다시 입력해 주세요.'
                                      : '',
                              obscureText: true,
                              focusNode: _passwordFocusNode,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  if (_isLoading)
                    const Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
            SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (showPasswordField)
                    Padding(
                      padding: EdgeInsets.only(bottom: 6 * scaleFactor),
                      child: SizedBox(
                        width: 131 * scaleFactor,
                        height: 22 * scaleFactor,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {
                            context.push('/pwFinding');
                          },
                          child: Text(
                            '비밀번호를 잊으셨나요?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14 * scaleFactor,
                              fontWeight: FontWeight.w400,
                              height: 22 / 14,
                              letterSpacing: -0.025 * (14 * scaleFactor),
                              color: const Color(0xFF747784),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 12 * scaleFactor),
                    child: SaveButtonWidget(
                      scaleFactor: scaleFactor,
                      enabled:
                          showPasswordField
                              ? (hasEmail && hasPassword && !_isLoading)
                              : (hasEmail && !_isLoading),
                      buttonText: showPasswordField ? '로그인' : '다음',
                      onPressed: _isLoading ? null : _handleNextOrLogin,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
