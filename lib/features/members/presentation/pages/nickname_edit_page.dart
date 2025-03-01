import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper_fe/features/members/presentation/viewmodels/members_viewmodel.dart';
import 'package:love_keeper_fe/features/members/presentation/widgets/edit_field_widget.dart';
import 'package:love_keeper_fe/features/members/presentation/widgets/save_button_widget.dart';

class NicknameEditPage extends ConsumerStatefulWidget {
  const NicknameEditPage({super.key});

  @override
  _NicknameEditPageState createState() => _NicknameEditPageState();
}

class _NicknameEditPageState extends ConsumerState<NicknameEditPage> {
  final TextEditingController _nicknameController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nicknameController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

  Future<void> _updateNickname() async {
    final nickname = _nicknameController.text;
    if (nickname.isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final result = await ref
          .read(membersViewModelProvider.notifier)
          .updateNickname(nickname);
      setState(() {
        _isLoading = false;
      });
      if (result == '닉네임 변경 성공') {
        // 백엔드 응답에 따라 수정
        context.pop();
      }
    } catch (e) {
      debugPrint('Update nickname error: $e');
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('닉네임 변경 실패: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    const double baseWidth = 375.0;
    final double scaleFactor = deviceWidth / baseWidth;
    final bool hasText = _nicknameController.text.isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          '닉네임 변경',
          style: TextStyle(
            fontSize: 18 * scaleFactor,
            fontWeight: FontWeight.w600,
            height: 26 / 18,
            letterSpacing: -0.45 * scaleFactor,
            color: const Color(0xFF27282C),
          ),
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
      bottomNavigationBar: SaveButtonWidget(
        scaleFactor: scaleFactor,
        enabled: hasText && !_isLoading,
        buttonText: '변경하기',
        onPressed: _isLoading ? null : _updateNickname,
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20 * scaleFactor),
            child: EditFieldWidget(
              label: '닉네임',
              hintText: '사용할 닉네임을 입력해 주세요',
              controller: _nicknameController,
              scaleFactor: scaleFactor,
              autofocus: true,
            ),
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
