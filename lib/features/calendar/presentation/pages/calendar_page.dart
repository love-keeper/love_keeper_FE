import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper_fe/features/calendar/damain/entities/calendar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:love_keeper_fe/features/calendar/presentation/viewmodels/calendar_viewmodel.dart';
import 'package:love_keeper_fe/features/calendar/presentation/widgets/event_popup.dart';

class CalendarPage extends ConsumerStatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends ConsumerState<CalendarPage> {
  DateTime _focusedDay = DateTime.now();

  // API로부터 데이터를 가져오기 위해, 화면이 로드될 때 getCalendar() 호출
  @override
  void initState() {
    super.initState();
    // 예시: 현재 연도와 월에 대해 API 호출
    ref
        .read(calendarViewModelProvider.notifier)
        .getCalendar(_focusedDay.year, _focusedDay.month);
  }

  @override
  Widget build(BuildContext context) {
    // 뷰모델 상태를 감시합니다.
    final calendarState = ref.watch(calendarViewModelProvider);
    // Calendar 엔티티에서 편지/약속 이벤트가 있는 날짜들을 추출하는 확장(예시 코드에서 작성한 eventDates 확장)을 사용한다고 가정
    final List<DateTime> eventDates = calendarState.when(
      data: (calendar) => calendar?.eventDates ?? [],
      loading: () => [],
      error: (error, stack) => [],
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF27282C),
          ),
          onPressed: () => context.pop(),
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
                // 상단 섹션 (아이콘 및 편지/약속 개수 - 기존 코드 유지)
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
                    // 이벤트가 있는 날짜만 eventDates에 따라 표시
                    eventLoader: (day) =>
                        eventDates.where((d) => isSameDay(d, day)).toList(),
                    daysOfWeekStyle: const DaysOfWeekStyle(
                      weekdayStyle: TextStyle(fontSize: 14, color: Colors.grey),
                      weekendStyle: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    calendarBuilders: CalendarBuilders(
                      todayBuilder: (context, day, focusedDay) {
                        final events =
                            eventDates.where((d) => isSameDay(d, day)).toList();
                        if (events.isNotEmpty) {
                          return GestureDetector(
                            onTap: () {
                              // 오늘 날짜 셀 탭 시 EventPopup 호출
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return EventPopup(
                                    selectedDay: day,
                                    letterCount: 10, // 실제 API 데이터에 따라 수정
                                    promiseCount: 4, // 실제 API 데이터에 따라 수정
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
                              child: Center(
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
                            child: Center(
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
                          );
                        }
                      },
                      defaultBuilder: (context, day, focusedDay) {
                        final events =
                            eventDates.where((d) => isSameDay(d, day)).toList();
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
}
