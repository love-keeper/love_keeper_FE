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
    final bottomInset = MediaQuery.of(context).viewPadding.bottom;

    return Material(
      elevation: 20,
      color: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(minHeight: 60),
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 12,
          bottom: bottomInset > 0 ? bottomInset : 24, // ✅ SafeArea 대비 추가 여백
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color.fromRGBO(235, 236, 239, 1),
            width: 1,
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(22),
            topRight: Radius.circular(22),
          ),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              offset: Offset(0, 0),
              blurRadius: 13.7,
              spreadRadius: 0,
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTabItem('assets/images/tab_bar/home.png', '홈', 0),
              _buildTabItem('assets/images/tab_bar/archive.png', '보관함', 1),
              _buildTabItem('assets/images/tab_bar/my.png', '마이', 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabItem(String imagePath, String label, int index) {
    final isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () => onTabSelected(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            imagePath,
            width: 24,
            height: 24,
            color:
                isSelected
                    ? const Color.fromRGBO(255, 133, 155, 1)
                    : const Color.fromRGBO(175, 178, 191, 1),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color:
                  isSelected
                      ? const Color.fromRGBO(255, 133, 155, 1)
                      : const Color.fromRGBO(116, 119, 132, 1),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
