import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:love_keeper_fe/features/couples/presentation/viewmodels/couples_viewmodel.dart';
import 'package:love_keeper_fe/features/members/presentation/viewmodels/members_viewmodel.dart';
import 'package:love_keeper_fe/features/main/presentation/widgets/fallback_circle_avatar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:love_keeper_fe/features/members/domain/entities/member_info.dart';

class DdayPage extends ConsumerStatefulWidget {
  const DdayPage({super.key});

  @override
  _DdayPageState createState() => _DdayPageState();
}

class _DdayPageState extends ConsumerState<DdayPage> {
  DateTime _selectedDate = DateTime(2024, 12, 5);
  String? _partnerProfileImageUrl;
  final String _defaultImagePath = 'assets/images/main_page/Img_Profile.png';

  @override
  void initState() {
    super.initState();
    Future(() {
      ref
          .read(couplesViewModelProvider.notifier)
          .getStartDate()
          .then((startDate) {
        if (mounted) {
          setState(() {
            _selectedDate = DateTime.parse(startDate);
          });
        }
      }).catchError((e) {
        debugPrint('시작 날짜를 받아오지 못했습니다: $e');
      });

      ref
          .read(couplesViewModelProvider.notifier)
          .getCoupleInfo()
          .then((coupleInfo) {
        if (mounted) {
          setState(() {
            _partnerProfileImageUrl = coupleInfo.partnerProfileImageUrl;
            _selectedDate =
                DateTime.parse(coupleInfo.startedAt); // startDate와 동기화
          });
        }
      }).catchError((e) {
        debugPrint('커플 정보를 받아오지 못했습니다: $e');
      });
    });
  }

  void _showDatePicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          margin: const EdgeInsets.only(top: 100),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 243,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: _selectedDate,
                  minimumDate: DateTime(2000),
                  maximumDate: DateTime.now(),
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() {
                      _selectedDate = newDate;
                    });
                  },
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 52,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF859B),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () async {
                    final newDateStr =
                        DateFormat('yyyy-MM-dd').format(_selectedDate);
                    try {
                      await ref
                          .read(couplesViewModelProvider.notifier)
                          .updateStartDate(newDateStr);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('날짜가 성공적으로 업데이트되었습니다')),
                      );
                    } catch (e) {
                      debugPrint('시작 날짜 업데이트 실패: $e');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('날짜 업데이트 실패: $e')),
                      );
                    }
                    context.pop();
                  },
                  child: const Text(
                    '변경하기',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final memberState = ref.watch(membersViewModelProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          '기념일',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF27282C),
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF27282C),
          ),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: memberState.when(
            data: (memberInfo) => Column(
              children: [
                const SizedBox(height: 154),
                _buildAnniversaryCard(memberInfo),
                const SizedBox(height: 29),
                _buildDdayList(),
              ],
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(child: Text('Error: $error')),
          ),
        ),
      ),
    );
  }

  Widget _buildAnniversaryCard(MemberInfo? memberInfo) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    const double baseWidth = 375.0;
    final double scaleFactor = deviceWidth / baseWidth;

    return Container(
      height: 128,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            blurRadius: 5,
            spreadRadius: 0,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            left: 20,
            top: 20,
            child: memberInfo?.profileImageUrl != null &&
                    memberInfo!.profileImageUrl!.isNotEmpty
                ? ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: memberInfo.profileImageUrl!,
                      width: 54 * scaleFactor,
                      height: 54 * scaleFactor,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          _buildCircleImage(_defaultImagePath),
                    ),
                  )
                : _buildCircleImage(_defaultImagePath),
          ),
          Positioned(
            right: 20,
            top: 20,
            child: _partnerProfileImageUrl != null &&
                    _partnerProfileImageUrl!.isNotEmpty
                ? ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: _partnerProfileImageUrl!,
                      width: 54 * scaleFactor,
                      height: 54 * scaleFactor,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          _buildCircleImage(_defaultImagePath),
                    ),
                  )
                : _buildCircleImage(
                    _defaultImagePath), // 파트너 이미지가 null이면 기본 이미지
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '함께한 지',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.4,
                    color: Color(0xFF27282C),
                  ),
                ),
                const SizedBox(height: 0),
                Text(
                  '${DateTime.now().difference(_selectedDate).inDays} 일째',
                  style: const TextStyle(
                    fontSize: 24,
                    letterSpacing: -0.6,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF27282C),
                  ),
                ),
                GestureDetector(
                  onTap: _showDatePicker,
                  child: Text(
                    DateFormat('yyyy. MM. dd.').format(_selectedDate),
                    style: const TextStyle(
                      fontSize: 12,
                      letterSpacing: -0.3,
                      color: Color(0xFFFC6383),
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                      decorationColor: Color(0xFFFC6383),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDdayList() {
    final Set<int> ddaySet = {};

    for (int i = 100; i <= 36500; i += 100) {
      ddaySet.add(i);
    }
    for (int i = 365; i <= 36500; i += 365) {
      ddaySet.add(i);
    }

    List<int> ddayIntervals = ddaySet.toList()..sort();

    List<int> futureIntervals = ddayIntervals
        .where((days) =>
            _selectedDate.add(Duration(days: days)).isAfter(DateTime.now()))
        .take(10)
        .toList();

    return Container(
      height: 385,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            blurRadius: 5,
            spreadRadius: 0,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          children: futureIntervals.map((days) {
            final DateTime anniversaryDate =
                _selectedDate.add(Duration(days: days));
            final int remainingDays =
                anniversaryDate.difference(DateTime.now()).inDays;
            final bool isAnniversary = days % 365 == 0;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 9.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isAnniversary ? '${days ~/ 365}주년' : '$days일',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: isAnniversary
                          ? const Color(0xFFFC6383)
                          : const Color(0xFF27282C),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        remainingDays == 0 ? '오늘' : 'D-$remainingDays',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.4,
                          height: 1.143,
                          color: isAnniversary
                              ? const Color(0xFFFC6383)
                              : const Color(0xFF27282C),
                        ),
                      ),
                      const SizedBox(height: 0),
                      Text(
                        DateFormat('yyyy. MM. dd.').format(anniversaryDate),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          height: 1.167,
                          letterSpacing: -0.3,
                          color: Color(0xFF27282C),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

Widget _buildCircleImage(String imagePath) {
  return FallbackCircleAvatar(
    imagePath: imagePath,
    fallbackPath: 'assets/images/main_page/Img_Profile.png',
    radius: 27,
  );
}
