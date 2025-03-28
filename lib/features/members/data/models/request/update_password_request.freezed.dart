// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_password_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UpdatePasswordRequest _$UpdatePasswordRequestFromJson(
    Map<String, dynamic> json) {
  return _UpdatePasswordRequest.fromJson(json);
}

/// @nodoc
mixin _$UpdatePasswordRequest {
  String get currentPassword => throw _privateConstructorUsedError;
  String get newPassword => throw _privateConstructorUsedError;
  String get newPasswordConfirm => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UpdatePasswordRequestCopyWith<UpdatePasswordRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdatePasswordRequestCopyWith<$Res> {
  factory $UpdatePasswordRequestCopyWith(UpdatePasswordRequest value,
          $Res Function(UpdatePasswordRequest) then) =
      _$UpdatePasswordRequestCopyWithImpl<$Res, UpdatePasswordRequest>;
  @useResult
  $Res call(
      {String currentPassword, String newPassword, String newPasswordConfirm});
}

/// @nodoc
class _$UpdatePasswordRequestCopyWithImpl<$Res,
        $Val extends UpdatePasswordRequest>
    implements $UpdatePasswordRequestCopyWith<$Res> {
  _$UpdatePasswordRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPassword = null,
    Object? newPassword = null,
    Object? newPasswordConfirm = null,
  }) {
    return _then(_value.copyWith(
      currentPassword: null == currentPassword
          ? _value.currentPassword
          : currentPassword // ignore: cast_nullable_to_non_nullable
              as String,
      newPassword: null == newPassword
          ? _value.newPassword
          : newPassword // ignore: cast_nullable_to_non_nullable
              as String,
      newPasswordConfirm: null == newPasswordConfirm
          ? _value.newPasswordConfirm
          : newPasswordConfirm // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdatePasswordRequestImplCopyWith<$Res>
    implements $UpdatePasswordRequestCopyWith<$Res> {
  factory _$$UpdatePasswordRequestImplCopyWith(
          _$UpdatePasswordRequestImpl value,
          $Res Function(_$UpdatePasswordRequestImpl) then) =
      __$$UpdatePasswordRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String currentPassword, String newPassword, String newPasswordConfirm});
}

/// @nodoc
class __$$UpdatePasswordRequestImplCopyWithImpl<$Res>
    extends _$UpdatePasswordRequestCopyWithImpl<$Res,
        _$UpdatePasswordRequestImpl>
    implements _$$UpdatePasswordRequestImplCopyWith<$Res> {
  __$$UpdatePasswordRequestImplCopyWithImpl(_$UpdatePasswordRequestImpl _value,
      $Res Function(_$UpdatePasswordRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPassword = null,
    Object? newPassword = null,
    Object? newPasswordConfirm = null,
  }) {
    return _then(_$UpdatePasswordRequestImpl(
      currentPassword: null == currentPassword
          ? _value.currentPassword
          : currentPassword // ignore: cast_nullable_to_non_nullable
              as String,
      newPassword: null == newPassword
          ? _value.newPassword
          : newPassword // ignore: cast_nullable_to_non_nullable
              as String,
      newPasswordConfirm: null == newPasswordConfirm
          ? _value.newPasswordConfirm
          : newPasswordConfirm // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdatePasswordRequestImpl implements _UpdatePasswordRequest {
  const _$UpdatePasswordRequestImpl(
      {required this.currentPassword,
      required this.newPassword,
      required this.newPasswordConfirm});

  factory _$UpdatePasswordRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdatePasswordRequestImplFromJson(json);

  @override
  final String currentPassword;
  @override
  final String newPassword;
  @override
  final String newPasswordConfirm;

  @override
  String toString() {
    return 'UpdatePasswordRequest(currentPassword: $currentPassword, newPassword: $newPassword, newPasswordConfirm: $newPasswordConfirm)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdatePasswordRequestImpl &&
            (identical(other.currentPassword, currentPassword) ||
                other.currentPassword == currentPassword) &&
            (identical(other.newPassword, newPassword) ||
                other.newPassword == newPassword) &&
            (identical(other.newPasswordConfirm, newPasswordConfirm) ||
                other.newPasswordConfirm == newPasswordConfirm));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, currentPassword, newPassword, newPasswordConfirm);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdatePasswordRequestImplCopyWith<_$UpdatePasswordRequestImpl>
      get copyWith => __$$UpdatePasswordRequestImplCopyWithImpl<
          _$UpdatePasswordRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdatePasswordRequestImplToJson(
      this,
    );
  }
}

abstract class _UpdatePasswordRequest implements UpdatePasswordRequest {
  const factory _UpdatePasswordRequest(
      {required final String currentPassword,
      required final String newPassword,
      required final String newPasswordConfirm}) = _$UpdatePasswordRequestImpl;

  factory _UpdatePasswordRequest.fromJson(Map<String, dynamic> json) =
      _$UpdatePasswordRequestImpl.fromJson;

  @override
  String get currentPassword;
  @override
  String get newPassword;
  @override
  String get newPasswordConfirm;
  @override
  @JsonKey(ignore: true)
  _$$UpdatePasswordRequestImplCopyWith<_$UpdatePasswordRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
