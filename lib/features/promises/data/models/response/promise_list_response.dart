import 'package:freezed_annotation/freezed_annotation.dart';
import 'promise_response.dart';

part 'promise_list_response.freezed.dart';
part 'promise_list_response.g.dart';

@freezed
class PromiseListResponse with _$PromiseListResponse {
  const factory PromiseListResponse({
    required List<PromiseResponse> promiseList,
    required bool isFirst,
    required bool isLast,
    required bool hasNext,
  }) = _PromiseListResponse;

  factory PromiseListResponse.fromJson(Map<String, dynamic> json) =>
      _$PromiseListResponseFromJson(json);
}
