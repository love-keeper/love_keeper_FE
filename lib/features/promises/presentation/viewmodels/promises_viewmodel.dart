import 'package:love_keeper/features/promises/data/repositories/promises_repository_impl.dart';
import 'package:love_keeper/features/promises/domain/entities/promise_list.dart';
import 'package:love_keeper/features/promises/domain/repositories/promises_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'promises_viewmodel.g.dart';

@riverpod
class PromisesViewModel extends _$PromisesViewModel {
  late final PromisesRepository _repository;

  int _page = 0;
  final int _size = 10;
  bool _hasNext = true;
  bool _isFetching = false;

  @override
  AsyncValue<PromiseList?> build() {
    _repository = ref.watch(promisesRepositoryProvider);
    fetchInitial();
    return const AsyncValue.loading();
  }

  Future<void> fetchInitial() async {
    _page = 0;
    _hasNext = true;
    try {
      final result = await _repository.getPromises(_page, _size);
      state = AsyncValue.data(result);
      _hasNext = result.hasNext;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> fetchMore() async {
    if (_isFetching || !_hasNext) return;
    _isFetching = true;
    _page++;

    try {
      final newList = await _repository.getPromises(_page, _size);
      final current = state.value;

      if (current != null) {
        final merged = PromiseList(
          promiseList: [...current.promiseList, ...newList.promiseList],
          isFirst: newList.isFirst,
          isLast: newList.isLast,
          hasNext: newList.hasNext,
        );
        state = AsyncValue.data(merged);
      } else {
        state = AsyncValue.data(newList);
      }

      _hasNext = newList.hasNext;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    } finally {
      _isFetching = false;
    }
  }

  Future<void> refresh() async {
    _page = 0;
    _hasNext = true;
    await fetchInitial();
  }

  Future<String> createPromise(String content) async {
    try {
      final result = await _repository.createPromise(content);
      await refresh();
      return result;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<String> deletePromise(int promiseId) async {
    try {
      final result = await _repository.deletePromise(promiseId);
      await refresh();
      return result;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<int> getPromiseCount() async {
    try {
      final count = await _repository.getPromiseCount();
      return count;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<PromiseList> getPromisesByDate(String date, int page, int size) async {
    try {
      final promiseList = await _repository.getPromisesByDate(date, page, size);
      state = AsyncValue.data(promiseList);
      return promiseList;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}
