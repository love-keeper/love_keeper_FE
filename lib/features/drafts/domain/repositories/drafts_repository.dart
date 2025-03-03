import '../entities/draft.dart';

abstract class DraftsRepository {
  Future<String> createDraft(int draftOrder, String content);
  Future<Draft> getDraft(int order);
  Future<void> deleteDraft(int order); // 임시저장 삭제하는 함수
}
