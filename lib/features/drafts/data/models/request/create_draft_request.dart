import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_draft_request.freezed.dart';
part 'create_draft_request.g.dart';

@freezed
class CreateDraftRequest with _$CreateDraftRequest {
  const factory CreateDraftRequest({
    required int draftOrder,
    required String content,
  }) = _CreateDraftRequest;

  factory CreateDraftRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateDraftRequestFromJson(json);
}
