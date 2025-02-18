import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper_fe/features/main/widgets/tab_bar.dart';
import 'package:love_keeper_fe/features/main/widgets/dday_box.dart';
import 'package:love_keeper_fe/features/main/widgets/reconciliation_card.dart';
import 'package:love_keeper_fe/features/main/widgets/custom_info_card.dart';
import 'package:love_keeper_fe/features/main/widgets/storage_section.dart';
import 'package:love_keeper_fe/features/main/widgets/ad_section.dart';

class MainPage extends StatefulWidget {
  final int initialIndex;
  const MainPage({super.key, this.initialIndex = 0}); // 초기값 0 (홈)

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _onTabSelected(int index) {
    if (index == 1) {
      // StoragePage로 이동 (GoRouter 사용)
      context.push('/storage');
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
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
              // NotificationPage로 이동 (GoRouter 사용)
              context.push('/notification');
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Container(
        decoration: _currentIndex == 0
            ? const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(255, 231, 235, 1),
                    Color.fromRGBO(255, 206, 215, 1),
                  ],
                  begin: FractionalOffset(0.12, 0.0),
                  end: FractionalOffset(0.88, 1.0),
                ),
              )
            : const BoxDecoration(color: Colors.white),
        child: IndexedStack(
          index: _currentIndex,
          children: [
            _buildHomeScreen(width),
            _buildMyScreen(),
          ],
        ),
      ),
      bottomNavigationBar: TabBarWidget(
        currentIndex: _currentIndex,
        onTabSelected: _onTabSelected,
      ),
    );
  }

  Widget _buildHomeScreen(double width) {
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
                child: DdayBox(
                  dday: '1,626',
                  width: width,
                ),
              ),
              const SizedBox(height: 12),
              const ReconciliationCard(),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // '우리의 약속' 카드를 탭하면 StoragePage로 이동 (예: 약속 탭)
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

  Widget _buildMyScreen() {
    return const Center(
      child: Text(
        '마이 화면',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
