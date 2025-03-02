import 'package:love_keeper_fe/core/network/client/api_client.dart';
import 'package:love_keeper_fe/features/couples/data/models/response/couple_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/config/di/dio_module.dart';
import '../../../../core/models/api_response.dart';
import '../../domain/entities/invite_code.dart';
import '../../domain/repositories/couples_repository.dart';
import '../models/request/connect_request.dart';
import '../models/request/update_start_date_request.dart';

part 'couples_repository_impl.g.dart';

class CouplesRepositoryImpl implements CouplesRepository {
  final ApiClient apiClient;

  CouplesRepositoryImpl(this.apiClient);

  @override
  Future<InviteCode> generateCode() async {
    final response = await apiClient.generateCode();
    _handleResponse(response);
    return InviteCode(inviteCode: response.result!.inviteCode);
  }

  @override
  Future<String> connect(String inviteCode) async {
    final request = ConnectRequest(inviteCode: inviteCode);
    final response = await apiClient.connect(request);
    _handleResponse(response);
    return response.result!;
  }

  @override
  Future<int> getDaysSinceStarted() async {
    final response = await apiClient.getDaysSinceStarted();
    _handleResponse(response);
    return response.result!;
  }

  @override
  Future<String> getStartDate() async {
    final response = await apiClient.getStartDate();
    _handleResponse(response);
    return response.result!;
  }

  @override
  Future<String> updateStartDate(String newStartDate) async {
    final request = UpdateStartDateRequest(newStartDate: newStartDate);
    final response = await apiClient.updateStartDate(request);
    _handleResponse(response);
    return response.result!;
  }

  @override
  Future<String> deleteCouple() async {
    final response = await apiClient.deleteCouple();
    _handleResponse(response);
    return response.result!;
  }

  @override
  Future<CoupleInfo> getCoupleInfo() async {
    final response = await apiClient.getCoupleInfo();
    _handleResponse(response);
    return response.result!;
  }

  void _handleResponse(ApiResponse response) {
    if (response.code != 'COMMON200') {
      throw Exception('${response.code}: ${response.message}');
    }
  }
}

@riverpod
CouplesRepository couplesRepository(CouplesRepositoryRef ref) {
  final apiClient = ref.watch(apiClientProvider);
  return CouplesRepositoryImpl(apiClient);
}
