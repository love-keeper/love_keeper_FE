import 'package:flutter/material.dart';
import 'package:love_keeper/features/calendar/presentation/pages/detail_page.dart';

class EventPopup extends StatelessWidget {
  final DateTime selectedDay;
  final int letterCount;
  final int promiseCount;

  const EventPopup({
    super.key,
    required this.selectedDay,
    required this.letterCount,
    required this.promiseCount,
  });

  String _getKoreanWeekday(DateTime day) {
    switch (day.weekday) {
      case DateTime.monday:
        return '월요일';
      case DateTime.tuesday:
        return '화요일';
      case DateTime.wednesday:
        return '수요일';
      case DateTime.thursday:
        return '목요일';
      case DateTime.friday:
        return '금요일';
      case DateTime.saturday:
        return '토요일';
      case DateTime.sunday:
        return '일요일';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 500, minHeight: 350),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.18),
              blurRadius: 30,
              spreadRadius: 0,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${selectedDay.month}월 ${selectedDay.day}일 ${_getKoreanWeekday(selectedDay)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.45,
                  height: 26 / 18,
                  color: Color(0xFF27282C),
                ),
              ),
              const SizedBox(height: 20),

              /// 🔹 편지 박스
              _buildInfoBox(
                context: context,
                iconPath: 'assets/images/storage_page/C_letter.png',
                countText: '편지 $letterCount건',
                description: '그날의 진심을 다시 느껴 보세요',
                onTap:
                    letterCount > 0
                        ? () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => DetailPage(
                                  selectedDay: selectedDay,
                                  type: 'letter',
                                ),
                          ),
                        )
                        : null,
              ),

              const SizedBox(height: 12),

              /// 🔹 약속 박스
              _buildInfoBox(
                context: context,
                iconPath: 'assets/images/storage_page/C_promise.png',
                countText: '우리의 약속 $promiseCount건',
                description: '둘만의 다짐을 되새겨 보세요',
                onTap:
                    promiseCount > 0
                        ? () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => DetailPage(
                                  selectedDay: selectedDay,
                                  type: 'promise',
                                ),
                          ),
                        )
                        : null,
                isDisabled: promiseCount == 0,
              ),

              const SizedBox(height: 20),

              /// 닫기 버튼
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffFF859B),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(45),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  child: const Text(
                    '닫기',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.4,
                      height: 26 / 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoBox({
    required BuildContext context,
    required String iconPath,
    required String countText,
    required String description,
    required VoidCallback? onTap,
    bool isDisabled = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Opacity(
        opacity: isDisabled ? 0.4 : 1.0,
        child: Container(
          height: 90,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xffFFF5F7),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffFDBBC9),
                ),
                child: Center(
                  child: Image.asset(
                    iconPath,
                    width: 40,
                    height: 40,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      countText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.4,
                        height: 26 / 16,
                        color: Color(0xFF27282C),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.35,
                        height: 20 / 14,
                        color: Color(0xff747784),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Color(0xffFF859B),
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
