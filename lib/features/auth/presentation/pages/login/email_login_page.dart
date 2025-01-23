import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:love_keeper_fe/core/theme/custom_colors.dart';
import '../../viewmodels/login_view_model.dart';

class EmailLoginPage extends ConsumerStatefulWidget {
  const EmailLoginPage({super.key});

  @override
  ConsumerState<EmailLoginPage> createState() => _EmailLoginPageState();
}

class _EmailLoginPageState extends ConsumerState<EmailLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _validEmail = false;
  bool _showPassword = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateEmail(String value) {
    setState(() {
      if (value.isEmpty) {
        _validEmail = false;
      } else {
        final emailRegex =
            RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
        _validEmail = emailRegex.hasMatch(value);
      }
    });
  }

  void _handleNext() {
    if (_validEmail && !_showPassword) {
      setState(() {
        _showPassword = true;
      });
    } else if (_validEmail &&
        _showPassword &&
        _passwordController.text.isNotEmpty) {
      // TODO: 로그인 처리
      print('로그인 시도: ${_emailController.text}, ${_passwordController.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '이메일로 시작',
          style: textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                // 이메일 입력 영역
                Text(
                  '이메일',
                  style: textTheme.labelLarge?.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _emailController,
                  onChanged: _validateEmail,
                  style: textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurface,
                  ),
                  decoration: InputDecoration(
                    hintText: '이메일을 입력해 주세요.',
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 0,
                      vertical: 10,
                    ),
                    suffixIcon: _emailController.text.isNotEmpty
                        ? IconButton(
                            icon: Image.asset(
                              'assets/images/login_page/Ic_Close.png',
                              height: 24,
                              width: 24,
                            ),
                            onPressed: () {
                              _emailController.clear();
                              setState(() {
                                _validEmail = false;
                              });
                            },
                          )
                        : null,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                if (!_validEmail && _emailController.text.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    '올바른 이메일 형식이 아닙니다. 다시 입력해 주세요.',
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.error,
                    ),
                  ),
                ],
                if (_showPassword) ...[
                  const SizedBox(height: 32),
                  // 비밀번호 입력 영역
                  Text(
                    '비밀번호',
                    style: textTheme.labelLarge?.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    style: textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurface,
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 0,
                        vertical: 10,
                      ),
                      hintText: '비밀번호를 입력해 주세요.',
                      suffixIcon: _passwordController.text.isNotEmpty
                          ? IconButton(
                              icon: Image.asset(
                                'assets/images/login_page/Ic_Close.png',
                                height: 24,
                                width: 24,
                              ),
                              onPressed: () {
                                _passwordController.clear();
                                setState(() {}); // 버튼 상태 업데이트를 위해 필요
                              },
                            )
                          : null,
                    ),
                    onChanged: (value) => setState(() {}),
                  ),
                  const Spacer(),
                  Center(
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        '비밀번호를 잊으셨나요?',
                        style: textTheme.labelMedium?.copyWith(
                          color: colorScheme.tertiary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],

                FilledButton(
                  onPressed: (!_showPassword && _validEmail) ||
                          (_showPassword &&
                              _validEmail &&
                              _passwordController.text.isNotEmpty)
                      ? _handleNext
                      : null,
                  style: FilledButton.styleFrom(
                    backgroundColor: colorScheme.primaryContainer,
                    disabledBackgroundColor: CustomColors.unenabled,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    _showPassword ? '로그인' : '다음',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
