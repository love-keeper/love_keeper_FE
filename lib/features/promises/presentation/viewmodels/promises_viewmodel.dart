import 'package:love_keeper/features/promises/data/repositories/promises_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/promise_list.dart';
import '../../domain/repositories/promises_repository.dart';

part 'promises_viewmodel.g.dart';

@riverpod
class PromisesViewModel extends _$PromisesViewModel {
  late final PromisesRepository _repository;

  @override
  AsyncValue<dynamic> build() {
    _repository = ref.watch(promisesRepositoryProvider);
    return const AsyncValue.data(null);
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
