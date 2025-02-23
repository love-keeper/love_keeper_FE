import 'package:freezed_annotation/freezed_annotation.dart';

part 'draft.freezed.dart';

@freezed
class Draft with _$Draft {
  const factory Draft({
    required int order,
    required String content,
  }) = _Draft;
}
