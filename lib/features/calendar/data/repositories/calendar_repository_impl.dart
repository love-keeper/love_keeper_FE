import 'package:love_keeper_fe/core/network/client/api_client.dart';
import 'package:love_keeper_fe/features/calendar/domain/entities/calendar.dart';
import 'package:love_keeper_fe/features/calendar/data/models/response/calendar_response.dart';
import 'package:love_keeper_fe/features/calendar/domain/repositories/calendar_repository.dart';

class CalendarRepositoryImpl implements CalendarRepository {
  final ApiClient _apiClient;

  CalendarRepositoryImpl(this._apiClient);

  @override
  Future<Calendar> getCalendar(int year, int month, int? day) async {
    try {
      print('Fetching calendar for $year-$month${day != null ? '-$day' : ''}');
      final response = await _apiClient.getCalendar(year, month, day);
      print('Response received: ${response.toString()}');
      if (response.result == null) {
        throw Exception('Calendar data not found in response');
      }
      return Calendar.fromResponse(response.result!);
    } catch (e) {
      print('Failed to fetch calendar: $e');
      rethrow;
    }
  }
}
