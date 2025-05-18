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
    // 디바이스 크기에 따른 반응형 변수
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    // 기본 높이 + 디바이스별 하단 패딩(안전 영역)을 고려한 높이
    final double tabBarHeight = 65.0 + bottomPadding;

    // 화면 크기에 따른 스케일 팩터
    final double scaleFactor = screenWidth / 375.0;

    return Container(
      padding: EdgeInsets.only(
        left: 20.0 * scaleFactor,
        right: 20.0 * scaleFactor,
        bottom: bottomPadding, // SafeArea 대신 하단 패딩 직접 적용
      ),
      height: tabBarHeight,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromRGBO(235, 236, 239, 1),
          width: 1,
        ),
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(22.0 * scaleFactor),
          topRight: Radius.circular(22.0 * scaleFactor),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildTabItem(context, 'assets/images/tab_bar/home.png', '홈', 0),
          _buildTabItem(context, 'assets/images/tab_bar/archive.png', '보관함', 1),
          _buildTabItem(context, 'assets/images/tab_bar/my.png', '마이', 2),
        ],
      ),
    );
  }

  Widget _buildTabItem(
    BuildContext context,
    String imagePath,
    String label,
    int index,
  ) {
    bool isSelected = currentIndex == index;

    // 반응형 디자인을 위한 변수
    final double screenWidth = MediaQuery.of(context).size.width;
    final double scaleFactor = screenWidth / 375.0;

    // 아이템의 너비 계산(화면 너비의 1/3 - 좌우 패딩)
    final double itemWidth = (screenWidth - (40.0 * scaleFactor)) / 3;

    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            onTabSelected(index);
          },
          child: Container(
            width: itemWidth,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start, // 위에서부터 정렬 시작
              children: [
                const SizedBox(height: 10), // 상단 여백 줄임
                Image.asset(
                  imagePath,
                  width: 24 * scaleFactor,
                  height: 24 * scaleFactor,
                  color:
                      isSelected
                          ? const Color.fromRGBO(255, 133, 155, 1)
                          : const Color.fromRGBO(175, 178, 191, 1),
                ),
                SizedBox(height: 2 * scaleFactor),
                Text(
                  label,
                  style: TextStyle(
                    color:
                        isSelected
                            ? const Color.fromRGBO(255, 133, 155, 1)
                            : const Color.fromRGBO(116, 119, 132, 1),
                    fontSize: 12 * scaleFactor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // 하단 여백 제거 (위쪽으로 올림)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
