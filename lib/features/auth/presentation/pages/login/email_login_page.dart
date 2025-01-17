import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
        _validEmail = emailRegex.hasMatch(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          '이메일로 시작',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 이메일 입력 필드
              const Text(
                '이메일',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF666666),
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _emailController,
                onChanged: _validateEmail,
                decoration: InputDecoration(
                  hintText: '이메일을 입력해 주세요.',
                  hintStyle: const TextStyle(
                    color: Color(0xFFCCCCCC),
                    fontSize: 14,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12,
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFEEEEEE), // 기본 상태의 밑줄 색상
                      width: 1,
                    ),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFFF6B95), // 포커스 상태의 밑줄 색상 (핑크색)
                      width: 1,
                    ),
                  ),
                  filled: false,
                  fillColor: const Color(0xFFF5F5F5),
                  suffixIcon: _validEmail
                      ? const Icon(Icons.check_circle, color: Color(0xFF00CC88))
                      : null,
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              if (!_validEmail && _emailController.text.isNotEmpty) ...[
                const SizedBox(height: 8),
                const Text(
                  '올바른 이메일 형식이 아닙니다. 다시 입력해 주세요.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFFFF4D4D),
                  ),
                ),
              ],
              const SizedBox(height: 24),
              // 비밀번호 입력 필드
              const Text(
                '비밀번호',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF666666),
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: '비밀번호를 입력해 주세요.',
                  hintStyle: const TextStyle(
                    color: Color(0xFFCCCCCC),
                    fontSize: 14,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  filled: false,
                  fillColor: const Color(0xFFF5F5F5),
                ),
              ),
              // 비밀번호 찾기 링크
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    '비밀번호를 잊으셨나요?',
                    style: TextStyle(
                      color: Color(0xFF666666),
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              // 다음 버튼
              FilledButton(
                onPressed: _validEmail ? () {} : null,
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6B95),
                  disabledBackgroundColor: const Color(0xFFE5E5E5),
                  minimumSize: const Size.fromHeight(52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  '다음',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}