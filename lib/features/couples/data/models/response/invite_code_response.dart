import 'package:freezed_annotation/freezed_annotation.dart';

part 'invite_code_response.freezed.dart';
part 'invite_code_response.g.dart';

@freezed
class InviteCodeResponse with _$InviteCodeResponse {
  const factory InviteCodeResponse({
    required String inviteCode,
  }) = _InviteCodeResponse;

  factory InviteCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$InviteCodeResponseFromJson(json);
}
