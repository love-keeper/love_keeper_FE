import 'package:freezed_annotation/freezed_annotation.dart';

part 'nickname_response.freezed.dart';
part 'nickname_response.g.dart';

@freezed
class NicknameResponse with _$NicknameResponse {
  const factory NicknameResponse({
    required String nickname,
  }) = _NicknameResponse;

  factory NicknameResponse.fromJson(Map<String, dynamic> json) =>
      _$NicknameResponseFromJson(json);
}
