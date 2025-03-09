import 'package:freezed_annotation/freezed_annotation.dart';

part 'letter.freezed.dart';

@freezed
class Letter with _$Letter {
  const factory Letter({
    required String senderNickname,
    required String receiverNickname,
    required String content,
    required String sentDate, // 서버에서 제공하는 sentDate 추가
  }) = _Letter;
}
