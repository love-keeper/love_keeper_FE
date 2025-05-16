import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:love_keeper/features/calendar/domain/entities/calendar.dart';
import 'package:love_keeper/features/calendar/domain/repositories/calendar_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'calendar_viewmodel.g.dart';

@riverpod
class CalendarViewModel extends _$CalendarViewModel {
  late final CalendarRepository _repository;

  @override
  AsyncValue<Calendar?> build() {
    _repository = ref.watch(calendarRepositoryProvider);
    return const AsyncValue.data(null);
  }

  Future<Calendar> getCalendar(int year, int month) async {
    state = const AsyncValue.loading();
    try {
      final calendar = await _repository.getCalendar(year, month);
      state = AsyncValue.data(calendar);
      return calendar;
    } catch (e, stackTrace) {
      print('Error in getCalendar: $e\n$stackTrace'); // stackTrace 사용
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  Future<Calendar> getDayDetails(int year, int month, int day) async {
    try {
      return await _repository.getCalendar(year, month, day);
    } catch (e, stackTrace) {
      print('Error fetching day details: $e\n$stackTrace'); // stackTrace 사용
      rethrow;
    }
  }
}
