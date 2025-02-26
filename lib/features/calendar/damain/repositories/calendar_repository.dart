import '../entities/calendar.dart';

abstract class CalendarRepository {
  Future<Calendar> getCalendar(int year, int month);
}
