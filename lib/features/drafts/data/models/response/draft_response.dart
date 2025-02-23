import 'package:freezed_annotation/freezed_annotation.dart';

part 'draft_response.freezed.dart';
part 'draft_response.g.dart';

@freezed
class DraftResponse with _$DraftResponse {
  const factory DraftResponse({
    required int order,
    required String content,
  }) = _DraftResponse;

  factory DraftResponse.fromJson(Map<String, dynamic> json) =>
      _$DraftResponseFromJson(json);
}
