import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper/features/calendar/data/models/response/calendar_item_response.dart';
import 'package:love_keeper/features/calendar/domain/entities/calendar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:love_keeper/features/calendar/presentation/viewmodels/calendar_viewmodel.dart';
import 'package:love_keeper/features/calendar/presentation/widgets/event_popup.dart';

class CalendarPage extends ConsumerStatefulWidget {
  const CalendarPage({super.key});

  @override
  ConsumerState<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends ConsumerState<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  bool _isFirstLoad = true;
  late BuildContext _scaffoldContext;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isFirstLoad) {
      Future.microtask(
        () => ref
            .read(calendarViewModelProvider.notifier)
            .getCalendar(_focusedDay.year, _focusedDay.month),
      );
      _isFirstLoad = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    _scaffoldContext = context;
    final calendarState = ref.watch(calendarViewModelProvider);
    final calendar = calendarState.when(
      data: (calendar) => calendar,
      loading: () => null,
      error: (error, stack) => null,
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
              'assets/images/storage_page/Img_ArchivedCalender_BG.png',
            ),
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
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                    const SizedBox(height: 9),
                                    Text(
                                      '편지 ${calendar?.totalLetterCount ?? 0}건',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        letterSpacing: -0.3,
                                        height: 20 / 12,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF747784),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                          'assets/images/storage_page/C_promise.png',
                                          width: 54,
                                          height: 54,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 9),
                                    Text(
                                      '약속 ${calendar?.totalPromiseCount ?? 0}건',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        letterSpacing: -0.3,
                                        height: 20 / 12,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF747784),
                                      ),
                                    ),
                                  ],
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
                  child: calendarState.when(
                    data:
                        (calendar) => TableCalendar(
                          locale: 'ko_KR',
                          firstDay: DateTime(2020, 1, 1),
                          lastDay: DateTime(2030, 12, 31),
                          focusedDay: _focusedDay,
                          headerVisible: false,
                          eventLoader:
                              (day) =>
                                  calendar != null
                                      ? [
                                            ...calendar.letters,
                                            ...calendar.promises,
                                          ]
                                          .where(
                                            (item) =>
                                                isSameDay(
                                                  DateTime.parse(item.date),
                                                  day,
                                                ) &&
                                                item.count >= 1,
                                          )
                                          .toList()
                                      : [],
                          daysOfWeekStyle: const DaysOfWeekStyle(
                            weekdayStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                            weekendStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          calendarBuilders: CalendarBuilders(
                            todayBuilder: (context, day, focusedDay) {
                              final hasEvent =
                                  calendar != null &&
                                  [
                                    ...calendar.letters,
                                    ...calendar.promises,
                                  ].any(
                                    (item) =>
                                        isSameDay(
                                          DateTime.parse(item.date),
                                          day,
                                        ) &&
                                        item.count >= 1,
                                  );
                              return _buildDay(
                                context,
                                day,
                                hasEvent,
                                isToday: true,
                              );
                            },
                            defaultBuilder: (context, day, focusedDay) {
                              final hasEvent =
                                  calendar != null &&
                                  [
                                    ...calendar.letters,
                                    ...calendar.promises,
                                  ].any(
                                    (item) =>
                                        isSameDay(
                                          DateTime.parse(item.date),
                                          day,
                                        ) &&
                                        item.count >= 1,
                                  );
                              return _buildDay(context, day, hasEvent);
                            },
                            markerBuilder:
                                (context, day, events) =>
                                    const SizedBox.shrink(),
                          ),
                          rowHeight: 54,
                        ),
                    loading:
                        () => const Center(child: CircularProgressIndicator()),
                    error: (error, stack) => Center(child: Text('오류: $error')),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDay(
    BuildContext context,
    DateTime day,
    bool hasEvent, {
    bool isToday = false,
  }) {
    return GestureDetector(
      onTap:
          hasEvent
              ? () async {
                final calendar = ref.read(calendarViewModelProvider).value;
                if (calendar == null) {
                  await ref
                      .read(calendarViewModelProvider.notifier)
                      .getCalendar(_focusedDay.year, _focusedDay.month);
                }
                final dayCalendar = await ref
                    .read(calendarViewModelProvider.notifier)
                    .getDayDetails(
                      _focusedDay.year,
                      _focusedDay.month,
                      day.day,
                    );
                final letterCount = dayCalendar.dailyLetterCount;
                final promiseCount = dayCalendar.dailyPromiseCount;
                if (mounted) {
                  showDialog(
                    context: _scaffoldContext,
                    builder:
                        (context) => EventPopup(
                          selectedDay: day,
                          letterCount: letterCount,
                          promiseCount: promiseCount,
                        ),
                  );
                }
              }
              : null,
      child: Container(
        width: 38,
        height: 38,
        margin: const EdgeInsets.symmetric(horizontal: 3.5, vertical: 8),
        decoration: BoxDecoration(
          color:
              hasEvent
                  ? const Color(0xffFF859B)
                  : (isToday ? Colors.white : null),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            '${day.day}',
            style: TextStyle(
              fontSize: 16,
              letterSpacing: -0.4,
              height: 24 / 16,
              color: hasEvent ? Colors.white : Colors.black,
              fontWeight: isToday ? FontWeight.bold : FontWeight.w600,
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
                      1,
                    );
                    ref
                        .read(calendarViewModelProvider.notifier)
                        .getCalendar(_focusedDay.year, _focusedDay.month);
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
                      1,
                    );
                    ref
                        .read(calendarViewModelProvider.notifier)
                        .getCalendar(_focusedDay.year, _focusedDay.month);
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
