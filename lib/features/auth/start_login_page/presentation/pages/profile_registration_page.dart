import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:love_keeper_fe/features/auth/my_page/presentation/widgets/edit_field_widget.dart';
import 'package:love_keeper_fe/features/auth/my_page/presentation/widgets/save_button_widget.dart';

class ProfileRegistrationPage extends StatefulWidget {
  const ProfileRegistrationPage({Key? key}) : super(key: key);

  @override
  _ProfileRegistrationPageState createState() =>
      _ProfileRegistrationPageState();
}

class _ProfileRegistrationPageState extends State<ProfileRegistrationPage> {
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  File? _profileImage;
  // 카메라 아이콘(기본) 이미지 경로
  final String _cameraImagePath = 'assets/images/my_page/Ic_Gallery.png';
  // 기본 프로필 이미지로 사용할 경로
  final String _defaultProfilePath =
      'assets/images/my_page/Ic_Default Profile.png';
  // 사용자가 기본 이미지를 선택했는지 여부
  bool _useDefaultProfile = false;

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

  // 프로필 이미지 선택 바텀시트
  void _showProfileBottomSheet(BuildContext context, double scaleFactor) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // 배경을 투명하게 유지
      isDismissible: true,
      builder: (BuildContext dialogContext) {
        return GestureDetector(
          onTap: () => Navigator.pop(dialogContext),
          behavior: HitTestBehavior.opaque,
          child: Stack(
            children: [
              // 전체 화면 오버레이 (투명)
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.transparent,
              ),
              // 하단에 바텀시트 배치
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {}, // 바텀시트 내부 터치 시 닫히지 않도록
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
                        // 드래그 핸들
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
                        // 바텀시트 상단 텍스트
                        Center(
                          child: Text(
                            "프로필 사진 설정",
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
                        // 두 옵션 버튼
                        Center(
                          child: Column(
                            children: [
                              // 앨범에서 사진 선택 버튼
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
                                        "앨범에서 사진 선택",
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
                              // 기본 이미지 적용 버튼
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
                                        "기본 이미지 적용",
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
                        // 취소 버튼
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
                                  "취소",
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

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    const double baseWidth = 375.0;
    final double scaleFactor = deviceWidth / baseWidth;
    final bool hasNickname = _nicknameController.text.isNotEmpty;
    final bool hasBirthdate = _birthdateController.text.isNotEmpty;

// 정규식을 이용해 YYYY.MM.DD 형식 검사
    final RegExp birthdateRegex =
        RegExp(r'^\d{4}\.(0[1-9]|1[0-2])\.(0[1-9]|[12]\d|3[01]).$');
    final String guideMessage =
        hasBirthdate && !birthdateRegex.hasMatch(_birthdateController.text)
            ? "유효한 날짜 형식(YYYY.MM.DD.)을 입력해 주세요"
            : "";

    // 두 필드 모두 입력되었고, 생년월일 가이드 문구가 없으면 버튼 활성화
    final bool isSaveEnabled = hasNickname &&
        _birthdateController.text.isNotEmpty &&
        guideMessage.isEmpty;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "프로필 등록",
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
        buttonText: "시작하기",
        onPressed: () {
          // 커플 연결 페이지로 이동 (예시: '/relationshipConnection')
          context.push('/codeConnect');
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20 * scaleFactor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 16 * scaleFactor),
            // 프로필 이미지 (80x80) 중앙 정렬, 클릭 시 갤러리 선택/기본 이미지 적용 바텀시트 호출
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
            // 닉네임 입력 필드
            EditFieldWidget(
              label: "닉네임",
              hintText: "닉네임을 입력해 주세요.",
              controller: _nicknameController,
              scaleFactor: scaleFactor,
              autofocus: true,
              guideMessage: "",
            ),
            SizedBox(height: 36 * scaleFactor),
            // 생년월일 입력 필드 (EditFieldWidget 재사용)
            EditFieldWidget(
              label: "생년월일",
              hintText: "YYYY.MM.DD.",
              controller: _birthdateController,
              scaleFactor: scaleFactor,
              autofocus: false,
              guideMessage: guideMessage,
            ),
          ],
        ),
      ),
    );
  }
}
