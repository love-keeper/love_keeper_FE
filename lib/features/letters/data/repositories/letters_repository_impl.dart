import 'package:love_keeper/core/network/client/api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/config/di/dio_module.dart';
import '../../../../core/models/api_response.dart';
import '../../domain/entities/letter.dart';
import '../../domain/entities/letter_list.dart';
import '../../domain/repositories/letters_repository.dart';
import '../models/request/create_letter_request.dart';

part 'letters_repository_impl.g.dart';

class LettersRepositoryImpl implements LettersRepository {
  final ApiClient apiClient;

  LettersRepositoryImpl(this.apiClient);

  @override
  Future<String> createLetter(String content) async {
    final request = CreateLetterRequest(content: content);
    final response = await apiClient.createLetter(request);
    _handleResponse(response);
    return response.result!;
  }

  @override
  Future<LetterList> getLetterList(int page, int size) async {
    final response = await apiClient.getLetterList(page, size);
    _handleResponse(response);
    return LetterList(
      letterList:
          response.result!.letterList
              .map(
                (e) => Letter(
                  senderNickname: e.senderNickname,
                  receiverNickname: e.receiverNickname,
                  content: e.content,
                ),
              )
              .toList(),
      isFirst: response.result!.isFirst,
      isLast: response.result!.isLast,
      hasNext: response.result!.hasNext,
    );
  }

  @override
  Future<int> getLetterCount() async {
    final response = await apiClient.getLetterCount();
    _handleResponse(response);
    return response.result!;
  }

  @override
  Future<LetterList> getLettersByDate(String date, int page, int size) async {
    final response = await apiClient.getLettersByDate(date, page, size);
    _handleResponse(response);
    return LetterList(
      letterList:
          response.result!.letterList
              .map(
                (e) => Letter(
                  senderNickname: e.senderNickname,
                  receiverNickname: e.receiverNickname,
                  content: e.content,
                ),
              )
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
LettersRepository lettersRepository(LettersRepositoryRef ref) {
  final apiClient = ref.watch(apiClientProvider);
  return LettersRepositoryImpl(apiClient);
}
