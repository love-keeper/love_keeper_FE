// lib/features/home/views/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // 상단 프로필 및 알림
              Row(
                children: [
                  // 프로필 이미지들
                  Stack(
                    children: [
                      const CircleAvatar(radius: 20),
                      Transform.translate(
                        offset: const Offset(30, 0),
                        child: const CircleAvatar(radius: 20),
                      ),
                    ],
                  ),
                  const SizedBox(width: 40),
                  // 일째 표시
                  Text(
                    '1,626 일째',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  // 알림 아이콘
                  const Icon(Icons.notifications_outlined),
                ],
              ),
              const SizedBox(height: 20),
              // 메인 기능 카드들
              _buildFeatureCard(
                title: '화해 요청하기',
                subtitle: '사과의 마음을 편지에 담아 보세요',
                icon: Icons.favorite_border,
              ),
              const SizedBox(height: 16),
              // 나머지 UI 구현...
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border),
            label: '보관함',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: '마이',
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Card(
      elevation: 0,
      color: Colors.grey[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(subtitle),
          ],
        ),
      ),
    );
  }
}