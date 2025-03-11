import 'package:love_keeper/features/promises/data/repositories/promises_repository_impl.dart';
import 'package:love_keeper/features/promises/domain/entities/promise_list.dart';
import 'package:love_keeper/features/promises/domain/repositories/promises_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'promises_viewmodel.g.dart';

@riverpod
class PromisesViewModel extends _$PromisesViewModel {
  late final PromisesRepository _repository; // late로 변경

  @override
  AsyncValue<dynamic> build() {
    _repository = ref.watch(promisesRepositoryProvider);
    print('PromisesViewModel build called');
    getPromises(0, 10); // 초기 데이터 로드
    return const AsyncValue.loading(); // 초기 상태를 로딩으로 설정
  }

  Future<String> createPromise(String content) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.createPromise(content);
      state = AsyncValue.data(result);
      return result;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  Future<PromiseList> getPromises(int page, int size) async {
    state = const AsyncValue.loading();
    try {
      final promiseList = await _repository.getPromises(page, size);
      print(
        'Fetched promises: ${promiseList.promiseList.map((p) => p.toJson())}',
      );
      state = AsyncValue.data(promiseList);
      return promiseList;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  Future<String> deletePromise(int promiseId) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.deletePromise(promiseId);
      state = AsyncValue.data(result);
      return result;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  Future<int> getPromiseCount() async {
    state = const AsyncValue.loading();
    try {
      final count = await _repository.getPromiseCount();
      state = AsyncValue.data(count);
      return count;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  Future<PromiseList> getPromisesByDate(String date, int page, int size) async {
    state = const AsyncValue.loading();
    try {
      final promiseList = await _repository.getPromisesByDate(date, page, size);
      state = AsyncValue.data(promiseList);
      return promiseList;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }
}
