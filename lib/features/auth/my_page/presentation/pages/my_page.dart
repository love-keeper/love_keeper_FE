import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  File? _profileImage;
  final String _defaultImagePath = 'assets/images/my_page/Img_Profile.png';
  final String _galleryIconPath = 'assets/images/my_page/Ic_Gallery.png';
  final String _enterIconPath = 'assets/images/my_page/Ic_Enter.png';
  final String _settingsIconPath = 'assets/images/my_page/Ic_Settings.png';

  // 기존 _pickImage 대신, 바텀시트를 호출하는 함수 추가
  void _showBottomSheet(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    const double baseWidth = 375.0;
    final double scaleFactor = deviceWidth / baseWidth;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // 배경은 투명하게
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
                        SizedBox(height: 21 * scaleFactor),
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
                        SizedBox(height: 33 * scaleFactor),
                        // 두 개의 옵션 버튼
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
                              SizedBox(height: 30 * scaleFactor), // 두 옵션 사이 간격
                              // 기본 이미지 적용 버튼
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(dialogContext);
                                  setState(() {
                                    _profileImage = null;
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
      });
    }
  }

  /* void _editField(String fieldName) {
    context.pushNamed('editField', pathParameters: {'fieldName': fieldName});
  }*/

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    const double baseWidth = 375.0;
    final double scaleFactor = deviceWidth / baseWidth;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "MY",
          style: TextStyle(
            fontSize: 18 * scaleFactor,
            fontWeight: FontWeight.w600,
            height: 26 / 18,
            letterSpacing: -0.45 * scaleFactor,
            color: const Color(0xFF27282C),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20 * scaleFactor),
            child: GestureDetector(
              onTap: () {
                context.push('/settings');
              },
              child: Image.asset(
                _settingsIconPath,
                width: 24 * scaleFactor,
                height: 24 * scaleFactor,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              extendBodyBehindAppBar: true,
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(0),
                child: Container(),
              ),
              body: Column(
                children: [
                  SizedBox(height: 16 * scaleFactor),
                  Align(
                    alignment: Alignment.center,
                    child: ClipOval(
                      child: _profileImage != null
                          ? Image.file(
                              _profileImage!,
                              width: 84 * scaleFactor,
                              height: 84 * scaleFactor,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              _defaultImagePath,
                              width: 84 * scaleFactor,
                              height: 84 * scaleFactor,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  SizedBox(height: 30 * scaleFactor),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20 * scaleFactor),
                    child: _buildInfoSection(scaleFactor),
                  ),
                  SizedBox(height: 16 * scaleFactor),
                  Container(
                    width: deviceWidth,
                    height: 16 * scaleFactor,
                    color: const Color(0xFFF7F8FB),
                  ),
                  SizedBox(height: 16 * scaleFactor),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20 * scaleFactor),
                    child: _buildMenuSection(scaleFactor),
                  ),
                ],
              ),
            ),
          ),
          // 카메라 아이콘: 기존 _pickImage 대신 _showBottomSheet 호출
          Positioned(
            top: 68 * scaleFactor,
            left: 202 * scaleFactor,
            child: GestureDetector(
              onTap: () => _showBottomSheet(context),
              child: Image.asset(
                _galleryIconPath,
                width: 30 * scaleFactor,
                height: 30 * scaleFactor,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 30 * scaleFactor,
                    height: 30 * scaleFactor,
                    color: Colors.red,
                    child: const Icon(Icons.error, color: Colors.white),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(double scaleFactor) {
    return Column(
      children: [
        _buildBoxedRow("닉네임", "", scaleFactor,
            onTap: () => context.push('/nickname')),
        SizedBox(height: 18 * scaleFactor),
        _buildBoxedRow("생년월일", "", scaleFactor,
            onTap: () => context.push('/birthdate')),
        SizedBox(height: 18 * scaleFactor),
        _buildBoxedRow("연애 시작일", "", scaleFactor,
            onTap: () => context.push('/relationship')),
        SizedBox(height: 18 * scaleFactor),
        _buildBoxedRow("이메일", "", scaleFactor,
            onTap: () => context.push('/emailEdit')),
        SizedBox(height: 18 * scaleFactor),
        _buildBoxedRow("비밀번호 변경", "", scaleFactor,
            hasArrow: true, onTap: () => context.push('/passwordEdit')),
      ],
    );
  }

  Widget _buildMenuSection(double scaleFactor) {
    return Column(
      children: [
        _buildBoxedRow("공지", "", scaleFactor, hasArrow: true, onTap: () {
          debugPrint("공지 클릭");
        }),
        SizedBox(height: 18 * scaleFactor),
        _buildBoxedRow("자주 묻는 질문", "", scaleFactor, hasArrow: true, onTap: () {
          debugPrint("자주 묻는 질문 클릭");
        }),
        SizedBox(height: 18 * scaleFactor),
        _buildBoxedRow("1:1 카카오톡 문의", "", scaleFactor, hasArrow: true,
            onTap: () {
          debugPrint("1:1 카카오톡 문의 클릭");
        }),
      ],
    );
  }

  Widget _buildBoxedRow(String title, String value, double scaleFactor,
      {bool hasArrow = false, VoidCallback? onTap}) {
    bool showArrow = hasArrow;
    if (!hasArrow &&
        (title == "닉네임" ||
            title == "생년월일" ||
            title == "연애 시작일" ||
            title == "이메일")) {
      showArrow = value.isEmpty;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 335 * scaleFactor,
        height: 38 * scaleFactor,
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(vertical: 7 * scaleFactor),
        alignment: Alignment.topLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 16 * scaleFactor,
                fontWeight: FontWeight.w500,
                height: 24 / 16,
                letterSpacing: -0.4 * scaleFactor,
                color: Colors.black,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (value.isNotEmpty)
                  Text(
                    value,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 16 * scaleFactor,
                      fontWeight: FontWeight.w400,
                      height: 20 / 16,
                      letterSpacing: -0.4 * scaleFactor,
                      color: const Color(0xFF4D4F58),
                    ),
                  ),
                if (showArrow)
                  Image.asset(
                    _enterIconPath,
                    width: 14 * scaleFactor,
                    height: 14 * scaleFactor,
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
