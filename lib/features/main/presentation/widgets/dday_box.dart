import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:love_keeper_fe/features/main/presentation/widgets/fallback_circle_avatar.dart';
import 'package:love_keeper_fe/features/members/domain/entities/member_info.dart';
import 'package:love_keeper_fe/features/members/presentation/viewmodels/members_viewmodel.dart';
import 'package:love_keeper_fe/features/couples/presentation/viewmodels/couples_viewmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DdayBox extends ConsumerWidget {
  final String dday; // 디데이 숫자
  final double width; // 아이콘 크기 조정을 위해 필요

  const DdayBox({
    super.key,
    required this.dday,
    required this.width,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memberState = ref.watch(membersViewModelProvider); // 내 프로필 상태
    // couplesViewModelProvider의 상태는 String? 반환, 별도로 getCoupleInfo 호출
    final coupleState = ref.watch(couplesViewModelProvider);

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
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // user1: MemberInfo.profileImageUrl 사용
          memberState.when(
            data: (memberInfo) => memberInfo?.profileImageUrl != null &&
                    memberInfo!.profileImageUrl!.isNotEmpty
                ? ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: memberInfo.profileImageUrl!,
                      width: 36,
                      height: 36,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => _buildCircleImage(
                          'assets/images/main_page/Img_Profile.png'),
                    ),
                  )
                : _buildCircleImage('assets/images/main_page/Img_Profile.png'),
            loading: () => const CircularProgressIndicator(),
            error: (error, stack) =>
                _buildCircleImage('assets/images/main_page/Img_Profile.png'),
          ),
          const SizedBox(width: 12),
          // user2: CoupleInfo.partnerProfileImageUrl 사용
          FutureBuilder(
            future: ref.read(couplesViewModelProvider.notifier).getCoupleInfo(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final partnerImageUrl = snapshot.data!.partnerProfileImageUrl;
                return ClipOval(
                  child: partnerImageUrl != null && partnerImageUrl.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: partnerImageUrl,
                          width: 36,
                          height: 36,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              _buildCircleImage(
                                  'assets/images/main_page/Img_Profile.png'),
                        )
                      : _buildCircleImage(
                          'assets/images/main_page/Img_Profile.png'),
                );
              }
              return const CircularProgressIndicator(); // 로딩 중
            },
          ),
          const SizedBox(width: 12),
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

  Widget _buildCircleImage(String imagePath) {
    return FallbackCircleAvatar(
      imagePath: imagePath,
      fallbackPath: 'assets/images/main_page/Img_Profile.png',
      radius: 18,
    );
  }
}
