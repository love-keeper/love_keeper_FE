import 'package:love_keeper/features/letters/data/repositories/letters_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/letter_list.dart';
import '../../domain/repositories/letters_repository.dart';

part 'letters_viewmodel.g.dart';

@riverpod
class LettersViewModel extends _$LettersViewModel {
  late final LettersRepository _repository;

  int _page = 0;
  final int _size = 20;
  bool _hasNext = true;
  bool _isFetching = false;

  @override
  AsyncValue<LetterList?> build() {
    _repository = ref.watch(lettersRepositoryProvider);
    return const AsyncValue.loading();
  }

  Future<void> fetchInitialLetters() async {
    _page = 0;
    _hasNext = true;
    await fetchMoreLetters();
  }

  Future<void> refreshLetters() async {
    _page = 0;
    _hasNext = true;
    await fetchMoreLetters();
  }

  Future<void> fetchMoreLetters() async {
    if (_isFetching || !_hasNext) return;
    _isFetching = true;
    try {
      final newLetters = await _repository.getLetterList(_page, _size);
      final current = state.value;
      if (current != null) {
        final merged = LetterList(
          letters: [...current.letters, ...newLetters.letters],
          isFirst: newLetters.isFirst,
          isLast: newLetters.isLast,
          hasNext: newLetters.hasNext,
        );
        state = AsyncValue.data(merged);
      } else {
        state = AsyncValue.data(newLetters);
      }
      _hasNext = newLetters.hasNext;
      _page++;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    } finally {
      _isFetching = false;
    }
  }

  Future<String> createLetter(String content) async {
    try {
      final result = await _repository.createLetter(content);
      await refreshLetters();
      return result;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  Future<LetterList> getLetterList(int page, int size) async {
    state = const AsyncValue.loading();
    try {
      final letterList = await _repository.getLetterList(page, size);
      state = AsyncValue.data(letterList);
      return letterList;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  Future<int> getLetterCount() async {
    state = const AsyncValue.loading();
    try {
      final count = await _repository.getLetterCount();
      return count;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  Future<LetterList> getLettersByDate(String date, int page, int size) async {
    state = const AsyncValue.loading();
    try {
      final letterList = await _repository.getLettersByDate(date, page, size);
      state = AsyncValue.data(letterList);
      return letterList;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }
}
