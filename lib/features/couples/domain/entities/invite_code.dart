import 'package:freezed_annotation/freezed_annotation.dart';

part 'invite_code.freezed.dart';

@freezed
class InviteCode with _$InviteCode {
  const factory InviteCode({
    required String inviteCode,
  }) = _InviteCode;
}
