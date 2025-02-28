import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:love_keeper_fe/core/config/routes/route_names.dart';
import 'package:love_keeper_fe/core/providers/auth_state_provider.dart';
import 'package:love_keeper_fe/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:love_keeper_fe/features/members/presentation/widgets/edit_field_widget.dart';
import 'package:love_keeper_fe/features/members/presentation/widgets/save_button_widget.dart';

class ProfileRegistrationPage extends ConsumerStatefulWidget {
  const ProfileRegistrationPage({super.key});

  @override
  _ProfileRegistrationPageState createState() =>
      _ProfileRegistrationPageState();
}

class _ProfileRegistrationPageState
    extends ConsumerState<ProfileRegistrationPage> {
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  File? _profileImage;
  final String _cameraImagePath = 'assets/images/my_page/Ic_Gallery.png';
  final String _defaultProfilePath =
      'assets/images/my_page/Ic_Default Profile.png';
  bool _useDefaultProfile = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nicknameController.addListener(() {
      setState(() {});
    });
    _birthdateController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _birthdateController.dispose();
    super.dispose();
  }

  void _showProfileBottomSheet(BuildContext context, double scaleFactor) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      builder: (BuildContext dialogContext) {
        return GestureDetector(
          onTap: () => Navigator.pop(dialogContext),
          behavior: HitTestBehavior.opaque,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.transparent,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 375 * scaleFactor,
                    height: 299 * scaleFactor,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16 * scaleFactor),
                        topRight: Radius.circular(16 * scaleFactor),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 7 * scaleFactor),
                        Container(
                          width: 50 * scaleFactor,
                          height: 5 * scaleFactor,
                          decoration: BoxDecoration(
                            color: const Color(0xFFC3C6CF),
                            borderRadius:
                                BorderRadius.circular(26 * scaleFactor),
                          ),
                        ),
                        SizedBox(height: 20 * scaleFactor),
                        Center(
                          child: Text(
                            '프로필 사진 설정',
                            style: TextStyle(
                              fontSize: 14 * scaleFactor,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF747784),
                              height: 23 / 14,
                              letterSpacing: -0.025 * (14 * scaleFactor),
                            ),
                          ),
                        ),
                        SizedBox(height: 34 * scaleFactor),
                        Center(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(dialogContext);
                                  _pickImage();
                                },
                                child: Container(
                                  width: 168 * scaleFactor,
                                  height: 26 * scaleFactor,
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        'assets/images/my_page/Ic_albumpic.png',
                                        width: 24 * scaleFactor,
                                        height: 24 * scaleFactor,
                                      ),
                                      SizedBox(width: 15 * scaleFactor),
                                      Text(
                                        '앨범에서 사진 선택',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18 * scaleFactor,
                                          fontWeight: FontWeight.w600,
                                          height: 26 / 18,
                                          letterSpacing:
                                              -0.025 * (18 * scaleFactor),
                                          color: const Color(0xFF27282C),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 30 * scaleFactor),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(dialogContext);
                                  setState(() {
                                    _profileImage = null;
                                    _useDefaultProfile = true;
                                  });
                                },
                                child: Container(
                                  width: 168 * scaleFactor,
                                  height: 26 * scaleFactor,
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        'assets/images/my_page/Ic_Default Profile.png',
                                        width: 24 * scaleFactor,
                                        height: 24 * scaleFactor,
                                      ),
                                      SizedBox(width: 15 * scaleFactor),
                                      Text(
                                        '기본 이미지 적용',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18 * scaleFactor,
                                          fontWeight: FontWeight.w600,
                                          height: 26 / 18,
                                          letterSpacing:
                                              -0.025 * (18 * scaleFactor),
                                          color: const Color(0xFF27282C),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24 * scaleFactor),
                        Center(
                          child: GestureDetector(
                            onTap: () => Navigator.pop(dialogContext),
                            child: Container(
                              width: 334 * scaleFactor,
                              height: 52 * scaleFactor,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFF859B),
                                borderRadius:
                                    BorderRadius.circular(55 * scaleFactor),
                              ),
                              child: Center(
                                child: Text(
                                  '취소',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16 * scaleFactor,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    height: 24 / 16,
                                    letterSpacing: -0.025 * (16 * scaleFactor),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
        _useDefaultProfile = false;
      });
    }
  }

  Future<void> _registerProfile() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final authState = ref.read(authStateNotifierProvider);
      final email = authState.email ?? '';
      final password = authState.password;
      final provider = authState.provider ?? 'LOCAL';
      final providerId = authState.providerId;

      if (email.isEmpty) {
        throw Exception('Email is not set in AuthStateProvider');
      }

      // YYYY.MM.DD -> YYYY-MM-DD 변환
      final formattedBirthdate = _birthdateController.text.replaceAll('.', '-');

      // 1. Signup 호출
      await ref.read(authViewModelProvider.notifier).signup(
            email: email,
            nickname: _nicknameController.text,
            birthDate: formattedBirthdate,
            provider: provider,
            password: provider == 'LOCAL' ? password : null,
            providerId: provider != 'LOCAL' ? providerId : null,
            profileImage: _profileImage,
          );

      // 2. Signup 성공 후 Login 호출 (LOCAL일 경우만)
      if (provider == 'LOCAL' && password != null) {
        await ref.read(authViewModelProvider.notifier).login(
              email: email,
              provider: 'LOCAL',
              password: password,
              providerId: null,
            );
      }

      setState(() {
        _isLoading = false;
      });
      context.pushNamed(RouteNames.codeConnectPage);
    } catch (e) {
      debugPrint('Profile registration error: $e');
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('프로필 등록 실패: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    const double baseWidth = 375.0;
    final double scaleFactor = deviceWidth / baseWidth;
    final bool hasNickname = _nicknameController.text.isNotEmpty;
    final bool hasBirthdate = _birthdateController.text.isNotEmpty;

    final RegExp birthdateRegex =
        RegExp(r'^\d{4}\.(0[1-9]|1[0-2])\.(0[1-9]|[12]\d|3[01])$');
    final String guideMessage =
        hasBirthdate && !birthdateRegex.hasMatch(_birthdateController.text)
            ? '유효한 날짜 형식(YYYY.MM.DD)을 입력해 주세요'
            : '';

    final bool isSaveEnabled =
        hasNickname && hasBirthdate && guideMessage.isEmpty && !_isLoading;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          '프로필 등록',
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
        enabled: isSaveEnabled,
        buttonText: '시작하기',
        onPressed: _isLoading ? null : _registerProfile,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20 * scaleFactor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 16 * scaleFactor),
                GestureDetector(
                  onTap: () => _showProfileBottomSheet(context, scaleFactor),
                  child: _profileImage != null
                      ? ClipOval(
                          child: Image.file(
                            _profileImage!,
                            width: 80 * scaleFactor,
                            height: 80 * scaleFactor,
                            fit: BoxFit.cover,
                          ),
                        )
                      : _useDefaultProfile
                          ? ClipOval(
                              child: Image.asset(
                                _defaultProfilePath,
                                width: 80 * scaleFactor,
                                height: 80 * scaleFactor,
                                fit: BoxFit.cover,
                              ),
                            )
                          : ClipOval(
                              child: Image.asset(
                                _cameraImagePath,
                                width: 80 * scaleFactor,
                                height: 80 * scaleFactor,
                                fit: BoxFit.cover,
                              ),
                            ),
                ),
                SizedBox(height: 36 * scaleFactor),
                EditFieldWidget(
                  label: '닉네임',
                  hintText: '닉네임을 입력해 주세요.',
                  controller: _nicknameController,
                  scaleFactor: scaleFactor,
                  autofocus: true,
                  guideMessage: '',
                ),
                SizedBox(height: 36 * scaleFactor),
                EditFieldWidget(
                  label: '생년월일',
                  hintText: 'YYYY.MM.DD',
                  controller: _birthdateController,
                  scaleFactor: scaleFactor,
                  autofocus: false,
                  guideMessage: guideMessage,
                ),
              ],
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
