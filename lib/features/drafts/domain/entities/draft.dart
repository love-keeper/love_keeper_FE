import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/request/create_draft_request.dart';

part 'draft.freezed.dart';

@freezed
class Draft with _$Draft {
  const factory Draft({
    required int order,
    required String content,
    required DraftType draftType,
  }) = _Draft;
}
