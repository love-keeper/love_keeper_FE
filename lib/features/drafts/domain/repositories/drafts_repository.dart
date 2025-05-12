import '../entities/draft.dart';
import '../../data/models/request/create_draft_request.dart'; // DraftType enum 가져오기

abstract class DraftsRepository {
  Future<String> createDraft(
    int draftOrder,
    String content,
    DraftType draftType,
  );
  Future<Draft> getDraft(int order, {required DraftType draftType});
  Future<void> deleteDraft(int order, {required DraftType draftType});
}
