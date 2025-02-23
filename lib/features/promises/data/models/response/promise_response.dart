import 'package:freezed_annotation/freezed_annotation.dart';

part 'promise_response.freezed.dart';
part 'promise_response.g.dart';

@freezed
class PromiseResponse with _$PromiseResponse {
  const factory PromiseResponse({
    required int memberId,
    required int promiseId,
    required String content,
    required String promisedAt,
  }) = _PromiseResponse;

  factory PromiseResponse.fromJson(Map<String, dynamic> json) =>
      _$PromiseResponseFromJson(json);
}
