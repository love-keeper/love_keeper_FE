import 'package:love_keeper/features/drafts/data/repositories/drafts_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/draft.dart';
import '../../domain/repositories/drafts_repository.dart';
import '../../data/models/request/create_draft_request.dart';

part 'drafts_viewmodel.g.dart';

@riverpod
class DraftsViewModel extends _$DraftsViewModel {
  late final DraftsRepository _repository;

  @override
  AsyncValue<dynamic> build() {
    _repository = ref.watch(draftsRepositoryProvider);
    return const AsyncValue.data(null);
  }

  Future<String> createDraft(
    int draftOrder,
    String content, {
    required DraftType draftType,
  }) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.createDraft(
        draftOrder,
        content,
        draftType,
      );
      state = AsyncValue.data(result);
      return result;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  Future<Draft> getDraft(int order, {required DraftType draftType}) async {
    state = const AsyncValue.loading();

    try {
      final draft = await _repository.getDraft(order, draftType: draftType);
      state = AsyncValue.data(draft);
      return draft;
    } catch (e, stackTrace) {
      print("getDraft 오류: $e");

      // 404 에러인 경우 → 빈 드래프트로 처리
      if (e.toString().contains('404')) {
        final emptyDraft = Draft(
          order: order,
          content: '',
          draftType: draftType,
        );
        state = AsyncValue.data(emptyDraft);
        return emptyDraft;
      }

      // 그 외 에러도 무한 로딩 방지를 위해 fallback 상태로 처리
      state = AsyncValue.data(null); // 또는 에러화면 띄우고 싶다면 AsyncError로 남겨도 됨
      return Draft(order: order, content: '', draftType: draftType);
    }
  }

  Future<void> deleteDraft(int order, {required DraftType draftType}) async {
    state = const AsyncValue.loading();
    try {
      await _repository.deleteDraft(order, draftType: draftType);
      state = const AsyncValue.data(null);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }
}
