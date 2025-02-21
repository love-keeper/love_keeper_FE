import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    required int memberId,
    String? email,
    String? role,
    bool? social,
  }) = _User;
}
