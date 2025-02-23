import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_promise_request.freezed.dart';
part 'create_promise_request.g.dart';

@freezed
class CreatePromiseRequest with _$CreatePromiseRequest {
  const factory CreatePromiseRequest({
    required String content,
  }) = _CreatePromiseRequest;

  factory CreatePromiseRequest.fromJson(Map<String, dynamic> json) =>
      _$CreatePromiseRequestFromJson(json);
}
