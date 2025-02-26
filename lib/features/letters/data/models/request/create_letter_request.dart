import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_letter_request.freezed.dart';
part 'create_letter_request.g.dart';

@freezed
class CreateLetterRequest with _$CreateLetterRequest {
  const factory CreateLetterRequest({
    required String content,
  }) = _CreateLetterRequest;

  factory CreateLetterRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateLetterRequestFromJson(json);
}
