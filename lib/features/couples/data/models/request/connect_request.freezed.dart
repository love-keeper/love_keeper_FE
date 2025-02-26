// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connect_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ConnectRequest _$ConnectRequestFromJson(Map<String, dynamic> json) {
  return _ConnectRequest.fromJson(json);
}

/// @nodoc
mixin _$ConnectRequest {
  String get inviteCode => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConnectRequestCopyWith<ConnectRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectRequestCopyWith<$Res> {
  factory $ConnectRequestCopyWith(
          ConnectRequest value, $Res Function(ConnectRequest) then) =
      _$ConnectRequestCopyWithImpl<$Res, ConnectRequest>;
  @useResult
  $Res call({String inviteCode});
}

/// @nodoc
class _$ConnectRequestCopyWithImpl<$Res, $Val extends ConnectRequest>
    implements $ConnectRequestCopyWith<$Res> {
  _$ConnectRequestCopyWithImpl(this._value, this._then);

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
abstract class _$$ConnectRequestImplCopyWith<$Res>
    implements $ConnectRequestCopyWith<$Res> {
  factory _$$ConnectRequestImplCopyWith(_$ConnectRequestImpl value,
          $Res Function(_$ConnectRequestImpl) then) =
      __$$ConnectRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String inviteCode});
}

/// @nodoc
class __$$ConnectRequestImplCopyWithImpl<$Res>
    extends _$ConnectRequestCopyWithImpl<$Res, _$ConnectRequestImpl>
    implements _$$ConnectRequestImplCopyWith<$Res> {
  __$$ConnectRequestImplCopyWithImpl(
      _$ConnectRequestImpl _value, $Res Function(_$ConnectRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inviteCode = null,
  }) {
    return _then(_$ConnectRequestImpl(
      inviteCode: null == inviteCode
          ? _value.inviteCode
          : inviteCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConnectRequestImpl implements _ConnectRequest {
  const _$ConnectRequestImpl({required this.inviteCode});

  factory _$ConnectRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConnectRequestImplFromJson(json);

  @override
  final String inviteCode;

  @override
  String toString() {
    return 'ConnectRequest(inviteCode: $inviteCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectRequestImpl &&
            (identical(other.inviteCode, inviteCode) ||
                other.inviteCode == inviteCode));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, inviteCode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectRequestImplCopyWith<_$ConnectRequestImpl> get copyWith =>
      __$$ConnectRequestImplCopyWithImpl<_$ConnectRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConnectRequestImplToJson(
      this,
    );
  }
}

abstract class _ConnectRequest implements ConnectRequest {
  const factory _ConnectRequest({required final String inviteCode}) =
      _$ConnectRequestImpl;

  factory _ConnectRequest.fromJson(Map<String, dynamic> json) =
      _$ConnectRequestImpl.fromJson;

  @override
  String get inviteCode;
  @override
  @JsonKey(ignore: true)
  _$$ConnectRequestImplCopyWith<_$ConnectRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
