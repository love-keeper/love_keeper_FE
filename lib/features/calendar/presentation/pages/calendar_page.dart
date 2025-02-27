import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // GoRouter 확장을 위해 추가
import 'package:table_calendar/table_calendar.dart';
import 'package:love_keeper_fe/features/main/presentation/widgets/event_popup.dart';
import 'package:love_keeper_fe/features/main/presentation/widgets/fallback_circle_avatar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();

  final List<DateTime> _eventDays = [
    DateTime(2025, 2, 13),
    DateTime(2025, 3, 1),
    DateTime(2025, 3, 5),
    DateTime(2025, 3, 10),
    DateTime(2025, 3, 15),
  ];

  List<dynamic> _getEventsForDay(DateTime day) {
    return _eventDays.where((eventDay) => isSameDay(eventDay, day)).toList();
  }

  Widget _buildCustomCalendarHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 1, left: 10, bottom: 15, right: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              text: '${_focusedDay.year}년 ',
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.575,
                color: Color(0xFF27282C),
                height: 40 / 23,
              ),
              children: [
                TextSpan(
                  text: '${_focusedDay.month}월',
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                    color: Color(0xffFF859B),
                    letterSpacing: -0.575,
                    height: 40 / 23,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Color(0xffFF859B),
                  size: 24,
                ),
                onPressed: () {
                  setState(() {
                    _focusedDay = DateTime(
                      _focusedDay.year,
                      _focusedDay.month - 1,
                      _focusedDay.day,
                    );
                  });
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Color(0xffFF859B),
                  size: 24,
                ),
                onPressed: () {
                  setState(() {
                    _focusedDay = DateTime(
                      _focusedDay.year,
                      _focusedDay.month + 1,
                      _focusedDay.day,
                    );
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 셀 높이 54 (38 + 16)
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent, // 앱바 투명
        scrolledUnderElevation: 0,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF27282C),
          ),
          onPressed: () => context.pop(), // GoRouter 사용
        ),
        title: const Text(
          '캘린더',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.45,
            color: Color(0xFF27282C),
          ),
        ),
        actions: const [],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/storage_page/Img_ArchivedCalender_BG.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            height: 580,
            width: 350,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                // 상단 섹션: 아이콘 및 편지/약속 개수 (기존 그대로)
                SizedBox(
                  height: 125,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: 66,
                                  height: 66,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xffFDBBC9),
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      'assets/images/storage_page/C_letter.png',
                                      width: 43,
                                      height: 46.46,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 66,
                                  height: 66,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xffFDBBC9),
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      'assets/images/storage_page/C_promise.png',
                                      width: 54,
                                      height: 54,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 9),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  '편지 10건',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF747784),
                                  ),
                                ),
                                Text(
                                  '약속 4건',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF747784),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Divider(
                          thickness: 1,
                          color: Color.fromRGBO(195, 198, 207, 1),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                _buildCustomCalendarHeader(),
                Expanded(
                  child: TableCalendar(
                    locale: 'ko_KR',
                    firstDay: DateTime(2020, 1, 1),
                    lastDay: DateTime(2030, 12, 31),
                    focusedDay: _focusedDay,
                    headerVisible: false,
                    eventLoader: _getEventsForDay,
                    daysOfWeekStyle: const DaysOfWeekStyle(
                      weekdayStyle: TextStyle(fontSize: 14, color: Colors.grey),
                      weekendStyle: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    calendarBuilders: CalendarBuilders(
                      todayBuilder: (context, day, focusedDay) {
                        final events = _getEventsForDay(day);
                        if (events.isNotEmpty) {
                          return GestureDetector(
                            onTap: () {
                              // 오늘 날짜 셀 탭 시, EventPopup 호출 (예시)
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return EventPopup(
                                    selectedDay: day,
                                    letterCount: 10,
                                    promiseCount: 4,
                                  );
                                },
                              );
                            },
                            child: Container(
                              width: 38,
                              height: 38,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 3.5, vertical: 8),
                              clipBehavior: Clip.none,
                              decoration: BoxDecoration(
                                color: const Color(0xffFF859B),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Center(
                                    child: Text(
                                      '${day.day}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        letterSpacing: -0.4,
                                        height: 24 / 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const Positioned(
                                    bottom: -15,
                                    left: 0,
                                    right: 0,
                                    child: Center(
                                      child: Text(
                                        '오늘',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Color(0xffFC6383),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return Container(
                            width: 38,
                            height: 38,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 3.5, vertical: 8),
                            clipBehavior: Clip.none,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Center(
                                  child: Text(
                                    '${day.day}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      letterSpacing: -0.4,
                                      height: 24 / 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const Positioned(
                                  bottom: -10,
                                  left: 0,
                                  right: 0,
                                  child: Center(
                                    child: Text(
                                      '오늘',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Color(0xffFC6383),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      defaultBuilder: (context, day, focusedDay) {
                        final events = _getEventsForDay(day);
                        if (events.isNotEmpty) {
                          return GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return EventPopup(
                                    selectedDay: day,
                                    letterCount: 10,
                                    promiseCount: 4,
                                  );
                                },
                              );
                            },
                            child: Container(
                              width: 38,
                              height: 38,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 3.5, vertical: 8),
                              decoration: BoxDecoration(
                                color: const Color(0xffFF859B),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '${day.day}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  letterSpacing: -0.4,
                                  height: 24 / 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Container(
                            width: 38,
                            height: 38,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 3.5, vertical: 8),
                            alignment: Alignment.center,
                            child: Text(
                              '${day.day}',
                              style: const TextStyle(
                                fontSize: 16,
                                letterSpacing: -0.4,
                                height: 24 / 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }
                      },
                      markerBuilder: (context, day, events) {
                        return const SizedBox.shrink();
                      },
                    ),
                    rowHeight: 54,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
