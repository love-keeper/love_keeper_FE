import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:love_keeper/core/network/client/api_client.dart';
import 'package:love_keeper/features/calendar/domain/entities/calendar.dart';
import 'package:love_keeper/features/calendar/data/repositories/calendar_repository_impl.dart';
import 'package:love_keeper/core/config/di/dio_module.dart';

part 'calendar_repository.g.dart';

abstract class CalendarRepository {
  Future<Calendar> getCalendar(int year, int month, [int? day]); // day 추가
}

@riverpod
CalendarRepository calendarRepository(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return CalendarRepositoryImpl(apiClient);
}
