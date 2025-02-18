import 'package:flutter/material.dart';
import 'package:love_keeper_fe/features/main/widgets/fallback_circle_avatar.dart';

class DdayBox extends StatelessWidget {
  final String dday; // 디데이 숫자
  final double width; // 아이콘 크기 조정을 위해 필요

  const DdayBox({
    super.key,
    required this.dday,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            offset: Offset(0, 0),
            blurRadius: 5,
            spreadRadius: 0,
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // user1의 프로필 이미지, 실패 시 fallback 이미지 사용
          const FallbackCircleAvatar(
            imagePath: 'assets/images/main_page/user1.JPG',
            fallbackPath: 'assets/images/main_page/Img_Profile.png',
            radius: 18,
          ),
          const SizedBox(width: 12),
          // user2의 프로필 이미지, 실패 시 fallback 이미지 사용
          const FallbackCircleAvatar(
            imagePath: 'assets/images/main_page/user2.JPG',
            fallbackPath: 'assets/images/main_page/Img_Profile.png',
            radius: 18,
          ),
          Expanded(
            child: RichText(
              textAlign: TextAlign.end,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: dday,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      letterSpacing: -0.6,
                    ),
                  ),
                  const WidgetSpan(child: SizedBox(width: 4)),
                  const TextSpan(
                    text: '일째',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      letterSpacing: -0.45,
                    ),
                  ),
                  const WidgetSpan(child: SizedBox(width: 4)),
                  WidgetSpan(
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: width * 0.05,
                      color: const Color.fromRGBO(77, 79, 88, 1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
