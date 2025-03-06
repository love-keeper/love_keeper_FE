import 'package:love_keeper/features/drafts/data/repositories/drafts_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/draft.dart';
import '../../domain/repositories/drafts_repository.dart';

part 'drafts_viewmodel.g.dart';

@riverpod
class DraftsViewModel extends _$DraftsViewModel {
  late final DraftsRepository _repository;

  @override
  AsyncValue<dynamic> build() {
    _repository = ref.watch(draftsRepositoryProvider);
    return const AsyncValue.data(null);
  }

  Future<String> createDraft(int draftOrder, String content) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.createDraft(draftOrder, content);
      state = AsyncValue.data(result);
      return result;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  Future<Draft> getDraft(int order) async {
    state = const AsyncValue.loading();
    try {
      final draft = await _repository.getDraft(order);
      state = AsyncValue.data(draft);
      return draft;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  // 새로 추가: 드래프트 삭제
  Future<void> deleteDraft(int order) async {
    state = const AsyncValue.loading();
    try {
      await _repository.deleteDraft(order);
      state = const AsyncValue.data(null);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }
}
