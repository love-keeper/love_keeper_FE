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
    return const AsyncValue.data(null);
  }

  Future<CoupleInfo> getCoupleInfo({bool updateState = true}) async {
    try {
      final coupleInfo = await _repository.getCoupleInfo();
      if (updateState) {
        state = AsyncValue.data(coupleInfo);
      }
      return coupleInfo;
    } catch (e, stackTrace) {
      if (updateState) {
        state = AsyncValue.error(e, stackTrace);
      }
      rethrow;
    }
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
    // 이름 변경
    state = const AsyncValue.loading();
    try {
      final days = await _repository.getDaysSinceStarted();
      state = const AsyncValue.data(null); // 상태는 임시로 null
      return days;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  Future<String> getStartDate() async {
    state = const AsyncValue.loading();
    try {
      final startDate = await _repository.getStartDate(); // String 반환
      state = const AsyncValue.data(null); // 상태는 임시로 null (CoupleInfo?와 맞지 않음)
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
}
