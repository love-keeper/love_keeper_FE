import 'package:love_keeper/features/calendar/damain/entities/calendar.dart';
import 'package:love_keeper/features/calendar/damain/repositories/calendar_repository.dart';
import 'package:love_keeper/features/calendar/data/repositories/calendar_repository_impl.dart';
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
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }
}
