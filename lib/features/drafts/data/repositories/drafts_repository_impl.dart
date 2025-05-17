import 'package:dio/dio.dart';
import 'package:love_keeper/core/network/client/api_client.dart';
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
  Future<String> createDraft(
    int draftOrder,
    String content,
    DraftType draftType,
  ) async {
    final request = CreateDraftRequest(
      draftOrder: draftOrder, // 편지 인덱스
      content: content,
      draftType: draftType,
    );
    final response = await apiClient.createDraft(request);
    _handleResponse(response);
    return response.result!;
  }

  @override
  Future<Draft> getDraft(int order, {required DraftType draftType}) async {
    try {
      // draftType을 String으로 변환 (enum의 값을 대문자 문자열로)
      final draftTypeStr = draftType.toString().split('.').last.toUpperCase();

      final response = await apiClient.getDraft(order, draftTypeStr);
      _handleResponse(response);

      return Draft(
        order: response.result!.order, // 단계 순서 (1~4)
        content: response.result!.content,
        draftType: response.result!.draftType,
      );
    } catch (e) {
      // 오류 로깅
      print('getDraft 오류: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteDraft(int order, {required DraftType draftType}) async {
    try {
      // draftType을 String으로 변환 (enum의 값을 대문자 문자열로)
      final draftTypeStr = draftType.toString().split('.').last.toUpperCase();

      final response = await apiClient.deleteDraft(order, draftTypeStr);
      _handleResponse(response);
    } on DioException catch (e) {
      if (e.response?.statusCode != 200) {
        throw Exception('드래프트 삭제 실패: ${e.response?.statusCode} - ${e.message}');
      }
    } catch (e) {
      throw Exception('드래프트 삭제 실패: $e');
    }
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
