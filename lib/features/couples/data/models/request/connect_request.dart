import 'package:freezed_annotation/freezed_annotation.dart';

part 'connect_request.freezed.dart';
part 'connect_request.g.dart';

@freezed
class ConnectRequest with _$ConnectRequest {
  const factory ConnectRequest({
    required String inviteCode,
  }) = _ConnectRequest;

  factory ConnectRequest.fromJson(Map<String, dynamic> json) =>
      _$ConnectRequestFromJson(json);
}
