// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_nickname_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UpdateNicknameRequest _$UpdateNicknameRequestFromJson(
    Map<String, dynamic> json) {
  return _UpdateNicknameRequest.fromJson(json);
}

/// @nodoc
mixin _$UpdateNicknameRequest {
  String get nickname => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UpdateNicknameRequestCopyWith<UpdateNicknameRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateNicknameRequestCopyWith<$Res> {
  factory $UpdateNicknameRequestCopyWith(UpdateNicknameRequest value,
          $Res Function(UpdateNicknameRequest) then) =
      _$UpdateNicknameRequestCopyWithImpl<$Res, UpdateNicknameRequest>;
  @useResult
  $Res call({String nickname});
}

/// @nodoc
class _$UpdateNicknameRequestCopyWithImpl<$Res,
        $Val extends UpdateNicknameRequest>
    implements $UpdateNicknameRequestCopyWith<$Res> {
  _$UpdateNicknameRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nickname = null,
  }) {
    return _then(_value.copyWith(
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdateNicknameRequestImplCopyWith<$Res>
    implements $UpdateNicknameRequestCopyWith<$Res> {
  factory _$$UpdateNicknameRequestImplCopyWith(
          _$UpdateNicknameRequestImpl value,
          $Res Function(_$UpdateNicknameRequestImpl) then) =
      __$$UpdateNicknameRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String nickname});
}

/// @nodoc
class __$$UpdateNicknameRequestImplCopyWithImpl<$Res>
    extends _$UpdateNicknameRequestCopyWithImpl<$Res,
        _$UpdateNicknameRequestImpl>
    implements _$$UpdateNicknameRequestImplCopyWith<$Res> {
  __$$UpdateNicknameRequestImplCopyWithImpl(_$UpdateNicknameRequestImpl _value,
      $Res Function(_$UpdateNicknameRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nickname = null,
  }) {
    return _then(_$UpdateNicknameRequestImpl(
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateNicknameRequestImpl implements _UpdateNicknameRequest {
  const _$UpdateNicknameRequestImpl({required this.nickname});

  factory _$UpdateNicknameRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateNicknameRequestImplFromJson(json);

  @override
  final String nickname;

  @override
  String toString() {
    return 'UpdateNicknameRequest(nickname: $nickname)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateNicknameRequestImpl &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, nickname);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateNicknameRequestImplCopyWith<_$UpdateNicknameRequestImpl>
      get copyWith => __$$UpdateNicknameRequestImplCopyWithImpl<
          _$UpdateNicknameRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateNicknameRequestImplToJson(
      this,
    );
  }
}

abstract class _UpdateNicknameRequest implements UpdateNicknameRequest {
  const factory _UpdateNicknameRequest({required final String nickname}) =
      _$UpdateNicknameRequestImpl;

  factory _UpdateNicknameRequest.fromJson(Map<String, dynamic> json) =
      _$UpdateNicknameRequestImpl.fromJson;

  @override
  String get nickname;
  @override
  @JsonKey(ignore: true)
  _$$UpdateNicknameRequestImplCopyWith<_$UpdateNicknameRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
