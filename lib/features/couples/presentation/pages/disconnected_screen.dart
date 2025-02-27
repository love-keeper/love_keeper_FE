import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DisconnectedScreen extends StatelessWidget {
  const DisconnectedScreen({super.key});

  void _showBottomSheet(BuildContext context) {
    // 함수 내부에서 scaleFactor 계산
    final double deviceWidth = MediaQuery.of(context).size.width;
    const double baseWidth = 375.0;
    final double scaleFactor = deviceWidth / baseWidth;

    final DateTime expirationDate =
        DateTime.now().add(const Duration(days: 90));
    final String formattedDate =
        "${expirationDate.year.toString().padLeft(4, '0')}.${expirationDate.month.toString().padLeft(2, '0')}.${expirationDate.day.toString().padLeft(2, '0')}";

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // 배경을 투명하게 유지
      isDismissible: true,
      builder: (BuildContext dialogContext) {
        return GestureDetector(
          onTap: () => Navigator.pop(dialogContext), // 배경 클릭 시 닫기
          behavior: HitTestBehavior.opaque,
          child: Stack(
            children: [
              // 전체 화면 오버레이 (앱바 포함) - 투명 배경
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.transparent,
              ),
              // 하단에 바텀시트 배치
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {}, // 바텀시트 자체 터치 시 닫히지 않도록
                  child: Container(
                    width: 375 * scaleFactor,
                    height: 382 * scaleFactor,
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
                        SizedBox(height: 44 * scaleFactor),
                        // 바텀시트 내용: 재사용 가능한 계정 정보 위젯
                        const AccountInfoWidget(
                          title: "내 계정",
                          email: "000@gmail.com",
                        ),
                        SizedBox(height: 21 * scaleFactor),
                        const AccountInfoWidget(
                          title: "상대방 계정",
                          email: "000@gmail.com",
                        ),
                        SizedBox(height: 21 * scaleFactor),
                        AccountInfoWidget(
                          title: "복구 가능한 기간",
                          email: formattedDate,
                        ),
                        SizedBox(height: 26.89 * scaleFactor),
                        Center(
                          child: GestureDetector(
                            onTap: () => context.go('/codeConnect'),
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
                                  "다시 연결하기",
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

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    const double baseWidth = 375.0;
    final double scaleFactor = deviceWidth / baseWidth;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20 * scaleFactor),
              child: GestureDetector(
                onTap: () => context.go('/codeConnect'),
                child: Image.asset(
                  'assets/images/login_page/Ic_Close.png',
                  width: 24 * scaleFactor,
                  height: 24 * scaleFactor,
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            SizedBox(height: 39 * scaleFactor),
            Center(
              child: Container(
                width: 335 * scaleFactor,
                height: 35 * scaleFactor,
                alignment: Alignment.center,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 24 * scaleFactor,
                      fontWeight: FontWeight.w600,
                      height: 35 / 24,
                      letterSpacing: -0.065 * (24 * scaleFactor),
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: "백채은",
                        style: const TextStyle(color: Color(0xffFB5681)),
                      ),
                      TextSpan(
                        text: " 님과의 연결이 끊어졌어요",
                        style: const TextStyle(color: Color(0xff27282C)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 44 * scaleFactor),
            Center(
              child: Image.asset(
                'assets/images/Backup/Img_Lock.png',
                width: 253 * scaleFactor,
                height: 246 * scaleFactor,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 44 * scaleFactor),
            // 이미지 아래 추가 텍스트 영역 (335x48)
            Center(
              child: Container(
                width: 335 * scaleFactor,
                height: 96 * scaleFactor,
                alignment: Alignment.center,
                child: Text(
                  "상대방에 의해 러브키퍼 연결이 끊어졌으며\n모든 자료에 대한 접근이 차단되었습니다.\n다시 상대방과 계정 연결을 원하시면\n동일한 계정을 사용해 연결해 주세요.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xff747784),
                    fontSize: 16 * scaleFactor,
                    fontWeight: FontWeight.w500,
                    height: 24 / 16,
                    letterSpacing: -0.025 * (16 * scaleFactor),
                  ),
                ),
              ),
            ),
            SizedBox(height: 64 * scaleFactor),
            // 하단 불러오기 버튼
            Center(
              child: GestureDetector(
                onTap: () => _showBottomSheet(context),
                child: Container(
                  width: 334 * scaleFactor,
                  height: 52 * scaleFactor,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF859B),
                    borderRadius: BorderRadius.circular(55 * scaleFactor),
                  ),
                  child: Center(
                    child: Text(
                      "불러오기",
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
        ));
  }
}

class AccountInfoWidget extends StatelessWidget {
  final String title;
  final String email;

  const AccountInfoWidget({
    Key? key,
    required this.title,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    const double baseWidth = 375.0;
    final double scaleFactor = deviceWidth / baseWidth;
    return Column(
      children: [
        SizedBox(
          width: 114 * scaleFactor,
          height: 26 * scaleFactor,
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18 * scaleFactor,
                fontWeight: FontWeight.w600, // 세미볼드
                height: 26 / 18,
                letterSpacing: -0.025 * (18 * scaleFactor), // -2.5%
                color: const Color(0xFF27282C),
              ),
            ),
          ),
        ),
        SizedBox(height: 1 * scaleFactor),
        SizedBox(
          width: 300 * scaleFactor,
          height: 23 * scaleFactor,
          child: Center(
            child: Text(
              email,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16 * scaleFactor,
                fontWeight: FontWeight.w400, // 레귤러
                height: 23 / 16,
                letterSpacing: -0.025 * (16 * scaleFactor), // -2.5%
                color: const Color(0xFF747784),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
