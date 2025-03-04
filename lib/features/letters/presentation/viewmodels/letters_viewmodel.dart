import 'package:love_keeper/features/letters/data/repositories/letters_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/letter_list.dart';
import '../../domain/repositories/letters_repository.dart';

part 'letters_viewmodel.g.dart';

@riverpod
class LettersViewModel extends _$LettersViewModel {
  late final LettersRepository _repository;

  @override
  AsyncValue<dynamic> build() {
    _repository = ref.watch(lettersRepositoryProvider);
    return const AsyncValue.data(null);
  }

  Future<String> createLetter(String content) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.createLetter(content);
      state = AsyncValue.data(result);
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
      state = AsyncValue.data(count);
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
