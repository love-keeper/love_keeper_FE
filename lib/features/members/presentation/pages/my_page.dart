import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart'; // image_picker 패키지 추가
import 'package:love_keeper/features/members/domain/entities/member_info.dart';
import 'package:love_keeper/features/members/presentation/viewmodels/members_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart'; // url_launcher 패키지 추가

class MyPage extends ConsumerStatefulWidget {
  const MyPage({super.key});

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends ConsumerState<MyPage> {
  File? _profileImage;
  final String _defaultImagePath = 'assets/images/my_page/Img_Profile.png';
  final String _galleryIconPath = 'assets/images/my_page/Ic_Gallery.png';
  final String _enterIconPath = 'assets/images/my_page/Ic_Enter.png';
  final String _settingsIconPath = 'assets/images/my_page/Ic_Settings.png';

  // 외부 링크 URL 정의
  final String _noticeUrl =
      'https://www.notion.so/1ad62ef3fe5180cc8d4afa4fe916aaf6?v=1ad62ef3fe518053974e000c55785d6a';
  final String _faqUrl =
      'https://www.notion.so/FAQ-1ad62ef3fe5180a29395dbc2115eee58';
  final String _kakaoUrl = 'http://pf.kakao.com/_zAEPn';

  @override
  void initState() {
    super.initState();
    Future(() {
      ref
          .read(membersViewModelProvider.notifier)
          .fetchMemberInfo(); // 항상 새로 불러오기
    });
  }

  // URL 열기 함수 (최신 API 사용)
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      debugPrint('URL 열기 실패: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('URL을 열 수 없습니다: $e')));
    }
  }

  void _showBottomSheet(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    const double baseWidth = 375.0;
    final double scaleFactor = deviceWidth / baseWidth;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
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
                            borderRadius: BorderRadius.circular(
                              26 * scaleFactor,
                            ),
                          ),
                        ),
                        SizedBox(height: 21 * scaleFactor),
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
                        SizedBox(height: 33 * scaleFactor),
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
                                  });
                                  ref
                                      .read(membersViewModelProvider.notifier)
                                      .updateProfileImage(null)
                                      .then((_) {
                                        print('Profile image set to default');
                                      })
                                      .catchError((e) {
                                        print(
                                          'Error setting default image: $e',
                                        );
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
                                borderRadius: BorderRadius.circular(
                                  55 * scaleFactor,
                                ),
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

  // image_picker를 사용한 이미지 선택 함수
  Future<void> _pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      // 갤러리에서 이미지 선택
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        File file = File(image.path);
        setState(() {
          _profileImage = file;
        });
        await ref
            .read(membersViewModelProvider.notifier)
            .updateProfileImage(file);
        print('프로필 이미지가 성공적으로 업데이트되었습니다.');
      } else {
        print('이미지가 선택되지 않았습니다.');
      }
    } catch (e) {
      print('이미지 선택 중 오류 발생: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('이미지 선택 중 오류가 발생했습니다: $e')));
    }
  }

  Widget _buildBoxedRow(
    String title,
    String value,
    double scaleFactor, {
    bool hasArrow = false,
    VoidCallback? onTap,
  }) {
    bool showArrow = hasArrow;
    if (!hasArrow &&
        (title == '닉네임' ||
            title == '생년월일' ||
            title == '연애 시작일' ||
            title == '이메일')) {
      showArrow = value.isEmpty;
    }

    // 전체 컨테이너를 GestureDetector로 감싸서 탭 가능 영역 확장
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 335 * scaleFactor,
        height: 38 * scaleFactor,
        padding: EdgeInsets.symmetric(vertical: 7 * scaleFactor),
        alignment: Alignment.topLeft,
        // 터치 피드백을 제공하기 위한 배경색 추가 (선택 사항)
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4 * scaleFactor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16 * scaleFactor,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.4 * scaleFactor,
                height: 24 / 16,
                color: Colors.black,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,

              children: [
                if (value.isNotEmpty)
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 16 * scaleFactor,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.4 * scaleFactor,
                      height: 20 / (16 * scaleFactor),
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(double scaleFactor, MemberInfo? memberInfo) {
    return Column(
      children: [
        // 각 항목 사이에 구분선 추가 (선택 사항)
        _buildBoxedRow(
          '닉네임',
          memberInfo?.nickname ?? '',
          scaleFactor,
          onTap: () => context.push('/nicknameEdit'),
        ),
        SizedBox(height: 18 * scaleFactor),
        _buildBoxedRow(
          '생년월일',
          memberInfo?.birthday ?? '',
          scaleFactor,
          onTap: () => context.push('/birthdateEdit'),
        ),
        SizedBox(height: 18 * scaleFactor),
        _buildBoxedRow(
          '연애 시작일',
          memberInfo?.relationshipStartDate ?? '',
          scaleFactor,
          onTap: () => context.push('/relationshipStartEdit'),
        ),
        SizedBox(height: 18 * scaleFactor),
        _buildBoxedRow(
          '이메일',
          memberInfo?.email ?? '',
          scaleFactor,
          onTap:
              memberInfo?.email != null && memberInfo!.email!.isNotEmpty
                  ? null // 이메일이 있으면 수정 불가능
                  : () => context.push('/emailEdit'),
        ),
        SizedBox(height: 18 * scaleFactor),
        _buildBoxedRow(
          '비밀번호 변경',
          '',
          scaleFactor,
          hasArrow: true,
          onTap: () => context.push('/myPasswordEdit'),
        ),
      ],
    );
  }

  Widget _buildMenuSection(double scaleFactor) {
    return Column(
      children: [
        _buildBoxedRow(
          '공지',
          '',
          scaleFactor,
          hasArrow: true,
          onTap: () {
            _launchURL(_noticeUrl); // 공지 링크 열기
          },
        ),
        SizedBox(height: 18 * scaleFactor),
        _buildBoxedRow(
          '자주 묻는 질문',
          '',
          scaleFactor,
          hasArrow: true,
          onTap: () {
            _launchURL(_faqUrl); // FAQ 링크 열기
          },
        ),
        SizedBox(height: 18 * scaleFactor),
        _buildBoxedRow(
          '1:1 카카오톡 문의',
          '',
          scaleFactor,
          hasArrow: true,
          onTap: () {
            _launchURL(_kakaoUrl); // 카카오톡 링크 열기
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    const double baseWidth = 375.0;
    final double scaleFactor = deviceWidth / baseWidth;

    final memberState = ref.watch(membersViewModelProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0, // 스크롤 시 그림자 효과 제거
        elevation: 0,
        centerTitle: true,
        surfaceTintColor:
            Colors.transparent, // 스크롤 시 surface tint 색상 제거 (Material 3)
        foregroundColor: const Color(0xFF27282C), // 앱바 콘텐츠 색상 설정
        title: Text(
          'MY',
          style: TextStyle(
            fontSize: 18 * scaleFactor,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.45 * scaleFactor,
            height: 26 / (18 * scaleFactor),
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
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: memberState.when(
          data:
              (memberInfo) => Stack(
                children: [
                  // 메인 스크롤 영역
                  CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            SizedBox(height: 16 * scaleFactor),
                            // 프로필 사진 - 전체를 GestureDetector로 감싸서 탭 가능하게 함
                            GestureDetector(
                              onTap: () => _showBottomSheet(context),
                              child: SizedBox(
                                height: 84 * scaleFactor,
                                width: 84 * scaleFactor,
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: ClipOval(
                                        child:
                                            _profileImage != null
                                                ? Image.file(
                                                  _profileImage!,
                                                  width: 84 * scaleFactor,
                                                  height: 84 * scaleFactor,
                                                  fit: BoxFit.cover,
                                                )
                                                : memberInfo?.profileImageUrl !=
                                                        null &&
                                                    memberInfo!
                                                        .profileImageUrl!
                                                        .isNotEmpty
                                                ? CachedNetworkImage(
                                                  imageUrl:
                                                      memberInfo
                                                          .profileImageUrl!,
                                                  width: 84 * scaleFactor,
                                                  height: 84 * scaleFactor,
                                                  fit: BoxFit.cover,
                                                  placeholder:
                                                      (context, url) =>
                                                          const CircularProgressIndicator(),
                                                  errorWidget:
                                                      (
                                                        context,
                                                        url,
                                                        error,
                                                      ) => Image.asset(
                                                        _defaultImagePath,
                                                        width: 84 * scaleFactor,
                                                        height:
                                                            84 * scaleFactor,
                                                        fit: BoxFit.cover,
                                                      ),
                                                )
                                                : Image.asset(
                                                  _defaultImagePath,
                                                  width: 84 * scaleFactor,
                                                  height: 84 * scaleFactor,
                                                  fit: BoxFit.cover,
                                                ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Image.asset(
                                        _galleryIconPath,
                                        width: 30 * scaleFactor,
                                        height: 30 * scaleFactor,
                                        errorBuilder: (
                                          context,
                                          error,
                                          stackTrace,
                                        ) {
                                          return Container(
                                            width: 30 * scaleFactor,
                                            height: 30 * scaleFactor,
                                            color: Colors.red,
                                            child: const Icon(
                                              Icons.error,
                                              color: Colors.white,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 30 * scaleFactor),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20 * scaleFactor,
                              ),
                              child: _buildInfoSection(scaleFactor, memberInfo),
                            ),
                            SizedBox(height: 16 * scaleFactor),
                            Container(
                              width: deviceWidth,
                              height: 16 * scaleFactor,
                              color: const Color(0xFFF7F8FB),
                            ),
                            SizedBox(height: 16 * scaleFactor),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20 * scaleFactor,
                              ),
                              child: _buildMenuSection(scaleFactor),
                            ),
                            SizedBox(
                              height: 100 * scaleFactor,
                            ), // 하단 탭바를 위한 여유 공간
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error: $error')),
        ),
      ),
    );
  }
}
