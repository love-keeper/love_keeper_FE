import 'package:freezed_annotation/freezed_annotation.dart';

part 'email_duplication_request.freezed.dart';
part 'email_duplication_request.g.dart';

@freezed
class EmailDuplicationRequest with _$EmailDuplicationRequest {
  const factory EmailDuplicationRequest({
    required String email,
  }) = _EmailDuplicationRequest;

  factory EmailDuplicationRequest.fromJson(Map<String, dynamic> json) =>
      _$EmailDuplicationRequestFromJson(json);
}
