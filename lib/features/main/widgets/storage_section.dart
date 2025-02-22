import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StorageSection extends StatelessWidget {
  const StorageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160, // 전체 박스 높이
      padding: const EdgeInsets.all(18), // 외부 패딩
      decoration: BoxDecoration(
        color: Colors.white, // 배경 흰색
        borderRadius: BorderRadius.circular(20), // 모서리 둥글게
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            offset: Offset(0, 0), // 그림자 방향
            blurRadius: 5,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '보관함',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF27282C), // 텍스트 색상 적용
            ),
          ),
          const SizedBox(height: 18), // 보관함과 첫 번째 항목 간 간격
          _buildListItem(
            context,
            '편지',
            'assets/images/main_page/icon_letter.png',
            () {
              // 편지 항목 탭 시 StoragePage의 편지 탭으로 이동 (initialTab=0)
              context.push('/storage?initialTab=0');
            },
          ),
          const SizedBox(height: 10), // 리스트 간 간격
          _buildListItem(
            context,
            '우리의 약속',
            'assets/images/main_page/icon_promise.png',
            () {
              // 약속 항목 탭 시 StoragePage의 약속 탭으로 이동 (initialTab=1)
              context.push('/storage?initialTab=1');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(
    BuildContext context,
    String title,
    String iconPath,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(255, 157, 175, 1), // 아이콘 배경색
                ),
                child: Center(
                  child: Image.asset(
                    iconPath,
                    width: 24,
                    height: 24,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(width: 10), // 아이콘과 텍스트 간 간격
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF27282C), // 폰트 색상 적용
                  letterSpacing: -0.4, // 자간 (-2.5% 적용)
                  height: 1.5, // 라인 높이 (24px)
                ),
              ),
            ],
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 20,
            color: Color(0xFF27282C), // 화살표 색상 적용
          ),
        ],
      ),
    );
  }
}
