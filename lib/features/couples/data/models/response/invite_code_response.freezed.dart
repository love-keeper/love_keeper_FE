// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invite_code_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

InviteCodeResponse _$InviteCodeResponseFromJson(Map<String, dynamic> json) {
  return _InviteCodeResponse.fromJson(json);
}

/// @nodoc
mixin _$InviteCodeResponse {
  String get inviteCode => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InviteCodeResponseCopyWith<InviteCodeResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InviteCodeResponseCopyWith<$Res> {
  factory $InviteCodeResponseCopyWith(
          InviteCodeResponse value, $Res Function(InviteCodeResponse) then) =
      _$InviteCodeResponseCopyWithImpl<$Res, InviteCodeResponse>;
  @useResult
  $Res call({String inviteCode});
}

/// @nodoc
class _$InviteCodeResponseCopyWithImpl<$Res, $Val extends InviteCodeResponse>
    implements $InviteCodeResponseCopyWith<$Res> {
  _$InviteCodeResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inviteCode = null,
  }) {
    return _then(_value.copyWith(
      inviteCode: null == inviteCode
          ? _value.inviteCode
          : inviteCode // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InviteCodeResponseImplCopyWith<$Res>
    implements $InviteCodeResponseCopyWith<$Res> {
  factory _$$InviteCodeResponseImplCopyWith(_$InviteCodeResponseImpl value,
          $Res Function(_$InviteCodeResponseImpl) then) =
      __$$InviteCodeResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String inviteCode});
}

/// @nodoc
class __$$InviteCodeResponseImplCopyWithImpl<$Res>
    extends _$InviteCodeResponseCopyWithImpl<$Res, _$InviteCodeResponseImpl>
    implements _$$InviteCodeResponseImplCopyWith<$Res> {
  __$$InviteCodeResponseImplCopyWithImpl(_$InviteCodeResponseImpl _value,
      $Res Function(_$InviteCodeResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inviteCode = null,
  }) {
    return _then(_$InviteCodeResponseImpl(
      inviteCode: null == inviteCode
          ? _value.inviteCode
          : inviteCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InviteCodeResponseImpl implements _InviteCodeResponse {
  const _$InviteCodeResponseImpl({required this.inviteCode});

  factory _$InviteCodeResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$InviteCodeResponseImplFromJson(json);

  @override
  final String inviteCode;

  @override
  String toString() {
    return 'InviteCodeResponse(inviteCode: $inviteCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InviteCodeResponseImpl &&
            (identical(other.inviteCode, inviteCode) ||
                other.inviteCode == inviteCode));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, inviteCode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InviteCodeResponseImplCopyWith<_$InviteCodeResponseImpl> get copyWith =>
      __$$InviteCodeResponseImplCopyWithImpl<_$InviteCodeResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InviteCodeResponseImplToJson(
      this,
    );
  }
}

abstract class _InviteCodeResponse implements InviteCodeResponse {
  const factory _InviteCodeResponse({required final String inviteCode}) =
      _$InviteCodeResponseImpl;

  factory _InviteCodeResponse.fromJson(Map<String, dynamic> json) =
      _$InviteCodeResponseImpl.fromJson;

  @override
  String get inviteCode;
  @override
  @JsonKey(ignore: true)
  _$$InviteCodeResponseImplCopyWith<_$InviteCodeResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
