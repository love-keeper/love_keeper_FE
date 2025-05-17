import 'dart:core';

import 'package:dio/dio.dart';
import 'package:love_keeper/features/couples/data/models/response/couple_info.dart';
import 'package:love_keeper/features/couples/data/repositories/couples_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/invite_code.dart';
import '../../domain/repositories/couples_repository.dart';

part 'couples_viewmodel.g.dart';

@riverpod
class CouplesViewModel extends _$CouplesViewModel {
  late final CouplesRepository _repository;
  bool _initialized = false;

  @override
  AsyncValue<CoupleInfo?> build() {
    _repository = ref.watch(couplesRepositoryProvider);

    if (!_initialized) {
      _initialized = true;
      _fetchInitialCoupleInfo();
    }

    return const AsyncValue.loading();
  }

  Future<void> _fetchInitialCoupleInfo() async {
    try {
      final coupleInfo = await _repository.getCoupleInfo();
      state = AsyncValue.data(coupleInfo);
      print('Fetched couple info: ${coupleInfo.startedAt}');
    } catch (e, stackTrace) {
      if (e is DioException && e.response?.statusCode == 404) {
        print('No couple info found (404), setting state to null');
        state = const AsyncValue.data(null);
        return;
      }
      print('Get couple info failed: $e');
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<CoupleInfo?> getCoupleInfo({bool forceRefresh = false}) async {
    if (state.value != null && !forceRefresh) {
      return state.value;
    }
    state = const AsyncValue.loading();
    try {
      final coupleInfo = await _repository.getCoupleInfo();
      state = AsyncValue.data(coupleInfo);
      return coupleInfo;
    } catch (e, stackTrace) {
      if (e is DioException && e.response?.statusCode == 404) {
        state = const AsyncValue.data(null);
        return null;
      }
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  String getDday() {
    final coupleInfo = state.value;
    if (coupleInfo == null || coupleInfo.startedAt.isEmpty) {
      return '0';
    }
    final startedAt = DateTime.parse(coupleInfo.startedAt);
    final days = DateTime.now().difference(startedAt).inDays + 1;
    return '$days';
  }

  Future<InviteCode> generateCode() async {
    try {
      final inviteCode = await _repository.generateCode();
      return inviteCode;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  Future<String> connect(String inviteCode) async {
    try {
      final result = await _repository.connect(inviteCode);
      await getCoupleInfo(forceRefresh: true);
      return result;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  Future<int> getDaysSinceStarted() async {
    try {
      final days = await _repository.getDaysSinceStarted();
      return days;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  Future<String> updateStartDate(String newStartDate) async {
    try {
      final result = await _repository.updateStartDate(newStartDate);
      final updatedCoupleInfo = await _repository.getCoupleInfo();
      state = AsyncValue.data(updatedCoupleInfo);
      print('Start date updated: ${updatedCoupleInfo.startedAt}');
      return result;
    } catch (e, stackTrace) {
      print('Update failed: $e');
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  Future<String> deleteCouple() async {
    try {
      final result = await _repository.deleteCouple();
      state = const AsyncValue.data(null);
      return result;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }
}
