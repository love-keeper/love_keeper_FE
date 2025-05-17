import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_draft_request.freezed.dart';
part 'create_draft_request.g.dart';

enum DraftType {
  @JsonValue('CONCILIATION')
  conciliation,
  @JsonValue('ANSWER')
  answer,
}

@freezed
class CreateDraftRequest with _$CreateDraftRequest {
  const factory CreateDraftRequest({
    required int draftOrder,
    required String content,
    required DraftType draftType,
  }) = _CreateDraftRequest;

  factory CreateDraftRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateDraftRequestFromJson(json);
}
