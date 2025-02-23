import '../entities/draft.dart';

abstract class DraftsRepository {
  Future<String> createDraft(int draftOrder, String content);
  Future<Draft> getDraft(int order);
}
