import 'package:freezed_annotation/freezed_annotation.dart';
import 'letter.dart';

part 'letter_list.freezed.dart';

@freezed
class LetterList with _$LetterList {
  const factory LetterList({
    required List<Letter> letters,
    required bool isFirst,
    required bool isLast,
    required bool hasNext,
  }) = _LetterList;
}
