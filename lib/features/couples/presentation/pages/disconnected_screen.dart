import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:love_keeper/features/couples/presentation/viewmodels/couples_viewmodel.dart';

class DisconnectedScreen extends ConsumerWidget {
  const DisconnectedScreen({super.key});

  void _showBottomSheet(BuildContext context, WidgetRef ref) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    const double baseWidth = 375.0;
    final double scaleFactor = deviceWidth / baseWidth;

    final DateTime expirationDate = DateTime.now().add(
      const Duration(days: 90),
    );
    final String formattedDate =
        "${expirationDate.year.toString().padLeft(4, '0')}.${expirationDate.month.toString().padLeft(2, '0')}.${expirationDate.day.toString().padLeft(2, '0')}";

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
                        SizedBox(height: 44 * scaleFactor),
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
                            onTap: () async {
                              final coupleInfo =
                                  await ref
                                      .read(couplesViewModelProvider.notifier)
                                      .getCoupleInfo();

                              if (coupleInfo != null &&
                                  coupleInfo.coupleStatus == 'DISCONNECTED' &&
                                  coupleInfo.endedAt != null) {
                                final endedAt = DateTime.tryParse(
                                  coupleInfo.endedAt!,
                                );
                                if (endedAt != null &&
                                    DateTime.now().difference(endedAt).inDays <
                                        15) {
                                  context.go('/main');
                                  return;
                                }
                              }
                              context.go('/codeConnect');
                            },
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
  Widget build(BuildContext context, WidgetRef ref) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    const double baseWidth = 375.0;
    final double scaleFactor = deviceWidth / baseWidth;
    final partnerNickname =
        ref.watch(couplesViewModelProvider).value?.partnerNickname ?? '상대방';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20 * scaleFactor),
            child: GestureDetector(
              onTap: () => context.go('/codeConnect'), // ❗ X 버튼 → 새 커플 연결
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
                  children: [
                    TextSpan(
                      text: partnerNickname,
                      style: const TextStyle(color: Color(0xffFB5681)),
                    ),
                    const TextSpan(
                      text: " 님과의 연결이 끊어졌어요",
                      style: TextStyle(color: Color(0xff27282C)),
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
          /*
          Center(
            child: GestureDetector(
              onTap: () => _showBottomSheet(context, ref),
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
          */
        ],
      ),
    );
  }
}

class AccountInfoWidget extends StatelessWidget {
  final String title;
  final String email;

  const AccountInfoWidget({
    super.key,
    required this.title,
    required this.email,
  });

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
                fontWeight: FontWeight.w600,
                height: 26 / 18,
                letterSpacing: -0.025 * (18 * scaleFactor),
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
                fontWeight: FontWeight.w400,
                height: 23 / 16,
                letterSpacing: -0.025 * (16 * scaleFactor),
                color: const Color(0xFF747784),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
