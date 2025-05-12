// 최상단에 빈 줄 없이 시작
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import '../request/create_draft_request.dart';

part 'draft_response.freezed.dart';
part 'draft_response.g.dart';

@freezed
class DraftResponse with _$DraftResponse {
  const factory DraftResponse({
    required int order,
    required String content,
    @JsonKey(fromJson: _draftTypeFromJson, toJson: _draftTypeToJson)
    required DraftType draftType,
  }) = _DraftResponse;

  factory DraftResponse.fromJson(Map<String, dynamic> json) =>
      _$DraftResponseFromJson(json);
}

// 문자열을 enum으로 변환
DraftType _draftTypeFromJson(dynamic value) {
  if (value is String) {
    final upperValue = value.toUpperCase();
    if (upperValue == 'CONCILIATION') return DraftType.conciliation;
    if (upperValue == 'ANSWER') return DraftType.answer;
    throw Exception('알 수 없는 DraftType: $value');
  }
  throw Exception('유효하지 않은 DraftType 값: $value');
}

// enum을 문자열로 변환
String _draftTypeToJson(DraftType draftType) {
  switch (draftType) {
    case DraftType.conciliation:
      return 'CONCILIATION';
    case DraftType.answer:
      return 'ANSWER';
    default:
      return draftType.toString().split('.').last.toUpperCase();
  }
}
