import 'package:flutter/material.dart';

class TabBarWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabSelected;

  const TabBarWidget({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 83,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromRGBO(235, 236, 239, 1),
          width: 1,
        ),
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(22), // 왼쪽 위 모서리 둥글게
          topRight: Radius.circular(22), // 오른쪽 위 모서리 둥글게
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            offset: Offset(0, 0), // 위쪽으로 그림자
            blurRadius: 13.7, // 흐림 효과
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildTabItem('assets/images/tab_bar/home.png', '홈', 0),
          _buildTabItem('assets/images/tab_bar/archive.png', '보관함', 1),
          _buildTabItem('assets/images/tab_bar/my.png', '마이', 2),
        ],
      ),
    );
  }

  Widget _buildTabItem(String imagePath, String label, int index) {
    bool isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () {
        onTabSelected(index);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 24,
            height: 24,
            color: isSelected
                ? const Color.fromRGBO(255, 133, 155, 1)
                : const Color.fromRGBO(175, 178, 191, 1),
          ),
          const SizedBox(height: 2), // 이미지와 텍스트 간 간격
          Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? const Color.fromRGBO(255, 133, 155, 1)
                  : const Color.fromRGBO(116, 119, 132, 1),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
