import 'package:love_keeper/core/network/client/api_client.dart';
import 'package:love_keeper/features/calendar/damain/entities/calendar.dart';
import 'package:love_keeper/features/calendar/damain/entities/calendar_item.dart';
import 'package:love_keeper/features/calendar/damain/repositories/calendar_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/config/di/dio_module.dart';
import '../../../../core/models/api_response.dart';

part 'calendar_repository_impl.g.dart';

class CalendarRepositoryImpl implements CalendarRepository {
  final ApiClient apiClient;

  CalendarRepositoryImpl(this.apiClient);

  @override
  Future<Calendar> getCalendar(int year, int month) async {
    final response = await apiClient.getCalendar(year, month);
    _handleResponse(response);
    return Calendar(
      letters:
          response.result!.letters
              .map((e) => CalendarItem(date: e.date, count: e.count))
              .toList(),
      promises:
          response.result!.promises
              .map((e) => CalendarItem(date: e.date, count: e.count))
              .toList(),
    );
  }

  void _handleResponse(ApiResponse response) {
    if (response.code != 'COMMON200') {
      throw Exception('${response.code}: ${response.message}');
    }
  }
}

@riverpod
CalendarRepository calendarRepository(CalendarRepositoryRef ref) {
  final apiClient = ref.watch(apiClientProvider);
  return CalendarRepositoryImpl(apiClient);
}
