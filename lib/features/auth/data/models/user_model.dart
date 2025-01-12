import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required int id,
    required String email,
    required String nickname,
    String? profileImageUrl,
    required String role,
    required String provider,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  const UserModel._();

  User toEntity() => User(
        id: id,
        email: email,
        nickname: nickname,
        profileImageUrl: profileImageUrl,
        role: role,
        provider: provider,
      );
}