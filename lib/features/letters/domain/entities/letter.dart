import 'package:freezed_annotation/freezed_annotation.dart';

part 'letter.freezed.dart';

@freezed
class Letter with _$Letter {
  const factory Letter({
    required String senderNickname,
    required String receiverNickname,
    required String content,
  }) = _Letter;
}
