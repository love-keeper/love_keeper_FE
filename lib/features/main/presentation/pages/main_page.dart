import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper/features/main/presentation/widgets/dday_box.dart';
import 'package:love_keeper/features/main/presentation/widgets/reconciliation_card.dart';
import 'package:love_keeper/features/main/presentation/widgets/custom_info_card.dart';
import 'package:love_keeper/features/main/presentation/widgets/storage_section.dart';
import 'package:love_keeper/features/main/presentation/widgets/ad_section.dart';

class MainPage extends StatelessWidget {
  // initialIndex 관련 코드는 ShellRoute에서 관리하므로 제거합니다.
  const MainPage({super.key});

  Widget _buildHomeScreen(double width, BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  // DdayPage로 이동 (GoRouter 사용)
                  context.push('/dday');
                },
                child: DdayBox(width: width),
              ),
              const SizedBox(height: 12),
              const ReconciliationCard(),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // '우리의 약속' 카드를 탭하면 StoragePage의 약속 탭으로 이동
                        context.push('/storage?initialTab=1');
                      },
                      child: const CustomInfoCard(
                        title: '우리의 약속',
                        imagePath: 'assets/images/main_page/promise.png',
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: CustomInfoCard(
                      title: '비밀 쪽지',
                      imagePath: 'assets/images/main_page/secret_note.png',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const StorageSection(),
              const SizedBox(height: 12),
              const AdSection(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Image.asset(
            'assets/images/main_page/img_logo.png',
            width: 40,
            height: 35,
            fit: BoxFit.contain,
          ),
        ),
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/images/main_page/Ic_alarm_normal.png',
              width: 24,
              height: 24,
            ),
            onPressed: () {
              // NotificationPage로 이동
              context.push('/notificationPage');
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(255, 231, 235, 1),
              Color.fromRGBO(255, 206, 215, 1),
            ],
            begin: FractionalOffset(0.12, 0.0),
            end: FractionalOffset(0.88, 1.0),
          ),
        ),
        child: _buildHomeScreen(width, context),
      ),
      // 탭바는 이제 ShellRoute에서 공통으로 관리하므로 MainPage에서는 제거합니다.
    );
  }
}
