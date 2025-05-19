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
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    // 화면 크기에 따른 스케일 팩터
    final double scaleFactor = screenWidth / 375.0;

    // 기본 높이 + 디바이스별 하단 패딩(안전 영역)을 고려한 높이
    // 오버플로우 방지를 위해 충분한 높이 확보
    final double tabBarHeight = 55.0 + bottomPadding;

    return Container(
      padding: EdgeInsets.only(bottom: bottomPadding), // 하단 패딩만 적용
      height: tabBarHeight, // 충분한 높이 확보
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
      // 스크롤이 필요하지 않도록 SingleChildScrollView로 감싸기
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(), // 스크롤 비활성화
        child: SizedBox(
          height: 60.0, // 내부 컨텐츠 높이 제한
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center, // 중앙 정렬
            children: [
              _buildTabItem(context, 'assets/images/tab_bar/home.png', '홈', 0),
              _buildTabItem(
                context,
                'assets/images/tab_bar/archive.png',
                '보관함',
                1,
              ),
              _buildTabItem(context, 'assets/images/tab_bar/my.png', '마이', 2),
            ],
          ),
        ),
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

    return GestureDetector(
      onTap: () {
        onTabSelected(index);
      },
      behavior: HitTestBehavior.opaque, // 투명 영역까지 탭 가능하게
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 4 * scaleFactor, // 수직 패딩 감소
          horizontal: 8 * scaleFactor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // 최소 크기만 차지
          mainAxisAlignment: MainAxisAlignment.center, // 중앙 정렬로 변경
          children: [
            SizedBox(height: 5 * scaleFactor),
            // 상단 여백 제거
            Image.asset(
              imagePath,
              width: 24 * scaleFactor,
              height: 24 * scaleFactor,
              color:
                  isSelected
                      ? const Color.fromRGBO(255, 133, 155, 1)
                      : const Color.fromRGBO(175, 178, 191, 1),
            ),
            SizedBox(height: 2 * scaleFactor), // 간격 줄임
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
          ],
        ),
      ),
    );
  }
}
