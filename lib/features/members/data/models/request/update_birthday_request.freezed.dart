// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_birthday_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UpdateBirthdayRequest _$UpdateBirthdayRequestFromJson(
    Map<String, dynamic> json) {
  return _UpdateBirthdayRequest.fromJson(json);
}

/// @nodoc
mixin _$UpdateBirthdayRequest {
  String get birthday => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UpdateBirthdayRequestCopyWith<UpdateBirthdayRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateBirthdayRequestCopyWith<$Res> {
  factory $UpdateBirthdayRequestCopyWith(UpdateBirthdayRequest value,
          $Res Function(UpdateBirthdayRequest) then) =
      _$UpdateBirthdayRequestCopyWithImpl<$Res, UpdateBirthdayRequest>;
  @useResult
  $Res call({String birthday});
}

/// @nodoc
class _$UpdateBirthdayRequestCopyWithImpl<$Res,
        $Val extends UpdateBirthdayRequest>
    implements $UpdateBirthdayRequestCopyWith<$Res> {
  _$UpdateBirthdayRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? birthday = null,
  }) {
    return _then(_value.copyWith(
      birthday: null == birthday
          ? _value.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdateBirthdayRequestImplCopyWith<$Res>
    implements $UpdateBirthdayRequestCopyWith<$Res> {
  factory _$$UpdateBirthdayRequestImplCopyWith(
          _$UpdateBirthdayRequestImpl value,
          $Res Function(_$UpdateBirthdayRequestImpl) then) =
      __$$UpdateBirthdayRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String birthday});
}

/// @nodoc
class __$$UpdateBirthdayRequestImplCopyWithImpl<$Res>
    extends _$UpdateBirthdayRequestCopyWithImpl<$Res,
        _$UpdateBirthdayRequestImpl>
    implements _$$UpdateBirthdayRequestImplCopyWith<$Res> {
  __$$UpdateBirthdayRequestImplCopyWithImpl(_$UpdateBirthdayRequestImpl _value,
      $Res Function(_$UpdateBirthdayRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? birthday = null,
  }) {
    return _then(_$UpdateBirthdayRequestImpl(
      birthday: null == birthday
          ? _value.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateBirthdayRequestImpl implements _UpdateBirthdayRequest {
  const _$UpdateBirthdayRequestImpl({required this.birthday});

  factory _$UpdateBirthdayRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateBirthdayRequestImplFromJson(json);

  @override
  final String birthday;

  @override
  String toString() {
    return 'UpdateBirthdayRequest(birthday: $birthday)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateBirthdayRequestImpl &&
            (identical(other.birthday, birthday) ||
                other.birthday == birthday));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, birthday);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateBirthdayRequestImplCopyWith<_$UpdateBirthdayRequestImpl>
      get copyWith => __$$UpdateBirthdayRequestImplCopyWithImpl<
          _$UpdateBirthdayRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateBirthdayRequestImplToJson(
      this,
    );
  }
}

abstract class _UpdateBirthdayRequest implements UpdateBirthdayRequest {
  const factory _UpdateBirthdayRequest({required final String birthday}) =
      _$UpdateBirthdayRequestImpl;

  factory _UpdateBirthdayRequest.fromJson(Map<String, dynamic> json) =
      _$UpdateBirthdayRequestImpl.fromJson;

  @override
  String get birthday;
  @override
  @JsonKey(ignore: true)
  _$$UpdateBirthdayRequestImplCopyWith<_$UpdateBirthdayRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
