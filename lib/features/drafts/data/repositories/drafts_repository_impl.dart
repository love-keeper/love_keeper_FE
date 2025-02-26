import 'package:love_keeper_fe/core/network/client/api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/config/di/dio_module.dart';
import '../../../../core/models/api_response.dart';
import '../../domain/entities/draft.dart';
import '../../domain/repositories/drafts_repository.dart';
import '../models/request/create_draft_request.dart';

part 'drafts_repository_impl.g.dart';

class DraftsRepositoryImpl implements DraftsRepository {
  final ApiClient apiClient;

  DraftsRepositoryImpl(this.apiClient);

  @override
  Future<String> createDraft(int draftOrder, String content) async {
    final request =
        CreateDraftRequest(draftOrder: draftOrder, content: content);
    final response = await apiClient.createDraft(request);
    _handleResponse(response);
    return response.result!;
  }

  @override
  Future<Draft> getDraft(int order) async {
    final response = await apiClient.getDraft(order);
    _handleResponse(response);
    return Draft(
        order: response.result!.order, content: response.result!.content);
  }

  void _handleResponse(ApiResponse response) {
    if (response.code != 'COMMON200') {
      throw Exception('${response.code}: ${response.message}');
    }
  }
}

@riverpod
DraftsRepository draftsRepository(DraftsRepositoryRef ref) {
  final apiClient = ref.watch(apiClientProvider);
  return DraftsRepositoryImpl(apiClient);
}
