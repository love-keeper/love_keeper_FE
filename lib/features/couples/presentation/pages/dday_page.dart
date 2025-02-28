import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:love_keeper_fe/features/couples/presentation/viewmodels/couples_viewmodel.dart';
import 'package:love_keeper_fe/features/main/presentation/widgets/fallback_circle_avatar.dart';

class DdayPage extends ConsumerStatefulWidget {
  const DdayPage({super.key});

  @override
  _DdayPageState createState() => _DdayPageState();
}

class _DdayPageState extends ConsumerState<DdayPage> {
  // 초기 날짜는 임시 값, 실제 시작 날짜는 API 호출로 받아옴.
  DateTime _selectedDate = DateTime(2024, 12, 5);

  @override
  void initState() {
    super.initState();
    // CouplesViewModel을 통해 시작 날짜를 API에서 받아옵니다.
    ref
        .read(couplesViewModelProvider.notifier)
        .getStartDate()
        .then((startDateString) {
      setState(() {
        // 백엔드에서 "yyyy-MM-dd" 형식으로 보낸다고 가정
        _selectedDate = DateTime.parse(startDateString);
      });
    }).catchError((e) {
      debugPrint('시작 날짜를 받아오지 못했습니다: $e');
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
                    // 사용자가 선택한 날짜를 "yyyy-MM-dd" 형식의 문자열로 변환합니다.
                    final newDateStr =
                        DateFormat('yyyy-MM-dd').format(_selectedDate);
                    try {
                      // updateStartDate API 호출
                      await ref
                          .read(couplesViewModelProvider.notifier)
                          .updateStartDate(newDateStr);
                      // 선택한 날짜를 다시 API를 통해 가져와서 업데이트할 수도 있습니다.
                      final updatedStartDate = await ref
                          .read(couplesViewModelProvider.notifier)
                          .getStartDate();
                      setState(() {
                        _selectedDate = DateTime.parse(updatedStartDate);
                      });
                    } catch (e) {
                      debugPrint('시작 날짜 업데이트 실패: $e');
                    }
                    // 변경 후 바텀시트 닫기
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
    // 디데이 계산이나 기타 UI 로직은 필요에 따라 추가하세요.
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
          child: Column(
            children: [
              const SizedBox(height: 154),
              _buildAnniversaryCard(),
              const SizedBox(height: 29),
              _buildDdayList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnniversaryCard() {
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
          // 프로필 이미지는 FallbackCircleAvatar로 대체
          Positioned(
            left: 20,
            top: 20,
            child: _buildCircleImage('assets/images/main_page/user1.JPG'),
          ),
          Positioned(
            right: 20,
            top: 20,
            child: _buildCircleImage('assets/images/main_page/user2.JPG'),
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
