import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_code_response.freezed.dart';
part 'send_code_response.g.dart';

@freezed
class SendCodeResponse with _$SendCodeResponse {
  const factory SendCodeResponse({
    required String code, // 인증 코드
  }) = _SendCodeResponse;

  factory SendCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$SendCodeResponseFromJson(json);
}
