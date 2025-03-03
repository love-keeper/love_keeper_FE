import 'package:love_keeper_fe/features/couples/data/models/response/couples_response.dart';
import 'package:love_keeper_fe/features/couples/data/repositories/couples_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/invite_code.dart';
import '../../domain/repositories/couples_repository.dart';

part 'couples_viewmodel.g.dart';

@riverpod
class CouplesViewModel extends _$CouplesViewModel {
  late final CouplesRepository _repository;

  @override
  AsyncValue<CoupleInfo?> build() {
    _repository = ref.watch(couplesRepositoryProvider);
    // 초기 로드
    Future.microtask(() => getCoupleInfo());
    return const AsyncValue.loading(); // 초기 상태를 로딩으로 설정
  }

  Future<CoupleInfo> getCoupleInfo({bool forceRefresh = false}) async {
    if (state.value != null && !forceRefresh) {
      return state.value!;
    }
    state = const AsyncValue.loading();
    try {
      final coupleInfo = await _repository.getCoupleInfo();
      state = AsyncValue.data(coupleInfo);
      return coupleInfo;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
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

  Future<String> getStartDate() async {
    try {
      final startDate = await _repository.getStartDate();
      final currentCoupleInfo = state.value ?? await getCoupleInfo();
      return startDate;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  Future<String> updateStartDate(String newStartDate) async {
    try {
      final result = await _repository.updateStartDate(newStartDate);
      await getCoupleInfo(forceRefresh: true);
      return result;
    } catch (e, stackTrace) {
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
