// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nickname_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NicknameResponse _$NicknameResponseFromJson(Map<String, dynamic> json) {
  return _NicknameResponse.fromJson(json);
}

/// @nodoc
mixin _$NicknameResponse {
  String get nickname => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NicknameResponseCopyWith<NicknameResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NicknameResponseCopyWith<$Res> {
  factory $NicknameResponseCopyWith(
          NicknameResponse value, $Res Function(NicknameResponse) then) =
      _$NicknameResponseCopyWithImpl<$Res, NicknameResponse>;
  @useResult
  $Res call({String nickname});
}

/// @nodoc
class _$NicknameResponseCopyWithImpl<$Res, $Val extends NicknameResponse>
    implements $NicknameResponseCopyWith<$Res> {
  _$NicknameResponseCopyWithImpl(this._value, this._then);

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
abstract class _$$NicknameResponseImplCopyWith<$Res>
    implements $NicknameResponseCopyWith<$Res> {
  factory _$$NicknameResponseImplCopyWith(_$NicknameResponseImpl value,
          $Res Function(_$NicknameResponseImpl) then) =
      __$$NicknameResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String nickname});
}

/// @nodoc
class __$$NicknameResponseImplCopyWithImpl<$Res>
    extends _$NicknameResponseCopyWithImpl<$Res, _$NicknameResponseImpl>
    implements _$$NicknameResponseImplCopyWith<$Res> {
  __$$NicknameResponseImplCopyWithImpl(_$NicknameResponseImpl _value,
      $Res Function(_$NicknameResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nickname = null,
  }) {
    return _then(_$NicknameResponseImpl(
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NicknameResponseImpl implements _NicknameResponse {
  const _$NicknameResponseImpl({required this.nickname});

  factory _$NicknameResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$NicknameResponseImplFromJson(json);

  @override
  final String nickname;

  @override
  String toString() {
    return 'NicknameResponse(nickname: $nickname)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NicknameResponseImpl &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, nickname);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NicknameResponseImplCopyWith<_$NicknameResponseImpl> get copyWith =>
      __$$NicknameResponseImplCopyWithImpl<_$NicknameResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NicknameResponseImplToJson(
      this,
    );
  }
}

abstract class _NicknameResponse implements NicknameResponse {
  const factory _NicknameResponse({required final String nickname}) =
      _$NicknameResponseImpl;

  factory _NicknameResponse.fromJson(Map<String, dynamic> json) =
      _$NicknameResponseImpl.fromJson;

  @override
  String get nickname;
  @override
  @JsonKey(ignore: true)
  _$$NicknameResponseImplCopyWith<_$NicknameResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
