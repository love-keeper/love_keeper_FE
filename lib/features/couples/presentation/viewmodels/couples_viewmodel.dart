import 'package:love_keeper/features/couples/data/models/response/couple_info.dart';
import 'package:love_keeper/features/couples/data/repositories/couples_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/invite_code.dart';
import '../../domain/repositories/couples_repository.dart';

part 'couples_viewmodel.g.dart';

@riverpod
class CouplesViewModel extends _$CouplesViewModel {
  late final CouplesRepository _repository;

  @override
  AsyncValue<dynamic> build() {
    _repository = ref.watch(couplesRepositoryProvider);
    return const AsyncValue.data(null);
  }

  Future<InviteCode> generateCode() async {
    state = const AsyncValue.loading();
    try {
      final inviteCode = await _repository.generateCode();
      state = AsyncValue.data(inviteCode);
      return inviteCode;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  Future<String> connect(String inviteCode) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.connect(inviteCode);
      state = AsyncValue.data(result);
      return result;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  Future<int> getDaysSinceStarted() async {
    state = const AsyncValue.loading();
    try {
      final days = await _repository.getDaysSinceStarted();
      state = AsyncValue.data(days);
      return days;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  Future<String> getStartDate() async {
    state = const AsyncValue.loading();
    try {
      final startDate = await _repository.getStartDate();
      state = AsyncValue.data(startDate);
      return startDate;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  Future<String> updateStartDate(String newStartDate) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.updateStartDate(newStartDate);
      state = AsyncValue.data(result);
      return result;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  Future<String> deleteCouple() async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.deleteCouple();
      state = AsyncValue.data(result);
      return result;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  Future<CoupleInfo> getCoupleInfo() async {
    state = const AsyncValue.loading();
    try {
      final coupleInfo = await _repository.getCoupleInfo();
      print(
        'Couple info retrieved successfully: ${coupleInfo.coupleId}, ${coupleInfo.partnerNickname}',
      );
      state = AsyncValue.data(coupleInfo);
      return coupleInfo;
    } catch (e, stackTrace) {
      print('Failed to get couple info: $e, StackTrace: $stackTrace');
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }
}
