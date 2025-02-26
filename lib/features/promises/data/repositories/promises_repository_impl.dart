import 'package:love_keeper_fe/core/network/client/api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/config/di/dio_module.dart';
import '../../../../core/models/api_response.dart';
import '../../domain/entities/promise.dart';
import '../../domain/entities/promise_list.dart';
import '../../domain/repositories/promises_repository.dart';
import '../models/request/create_promise_request.dart';

part 'promises_repository_impl.g.dart';

class PromisesRepositoryImpl implements PromisesRepository {
  final ApiClient apiClient;

  PromisesRepositoryImpl(this.apiClient);

  @override
  Future<String> createPromise(String content) async {
    final request = CreatePromiseRequest(content: content);
    final response = await apiClient.createPromise(request);
    _handleResponse(response);
    return response.result!;
  }

  @override
  Future<PromiseList> getPromises(int page, int size) async {
    final response = await apiClient.getPromises(page, size);
    _handleResponse(response);
    return PromiseList(
      promiseList: response.result!.promiseList
          .map((e) => Promise(
                memberId: e.memberId,
                promiseId: e.promiseId,
                content: e.content,
                promisedAt: e.promisedAt,
              ))
          .toList(),
      isFirst: response.result!.isFirst,
      isLast: response.result!.isLast,
      hasNext: response.result!.hasNext,
    );
  }

  @override
  Future<String> deletePromise(int promiseId) async {
    final response = await apiClient.deletePromise(promiseId);
    _handleResponse(response);
    return response.result!;
  }

  @override
  Future<int> getPromiseCount() async {
    final response = await apiClient.getPromiseCount();
    _handleResponse(response);
    return response.result!;
  }

  @override
  Future<PromiseList> getPromisesByDate(String date, int page, int size) async {
    final response = await apiClient.getPromisesByDate(date, page, size);
    _handleResponse(response);
    return PromiseList(
      promiseList: response.result!.promiseList
          .map((e) => Promise(
                memberId: e.memberId,
                promiseId: e.promiseId,
                content: e.content,
                promisedAt: e.promisedAt,
              ))
          .toList(),
      isFirst: response.result!.isFirst,
      isLast: response.result!.isLast,
      hasNext: response.result!.hasNext,
    );
  }

  void _handleResponse(ApiResponse response) {
    if (response.code != 'COMMON200') {
      throw Exception('${response.code}: ${response.message}');
    }
  }
}

@riverpod
PromisesRepository promisesRepository(PromisesRepositoryRef ref) {
  final apiClient = ref.watch(apiClientProvider);
  return PromisesRepositoryImpl(apiClient);
}
