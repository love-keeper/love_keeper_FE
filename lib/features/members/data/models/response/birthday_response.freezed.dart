// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'birthday_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BirthdayResponse _$BirthdayResponseFromJson(Map<String, dynamic> json) {
  return _BirthdayResponse.fromJson(json);
}

/// @nodoc
mixin _$BirthdayResponse {
  String get birthday => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BirthdayResponseCopyWith<BirthdayResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BirthdayResponseCopyWith<$Res> {
  factory $BirthdayResponseCopyWith(
          BirthdayResponse value, $Res Function(BirthdayResponse) then) =
      _$BirthdayResponseCopyWithImpl<$Res, BirthdayResponse>;
  @useResult
  $Res call({String birthday});
}

/// @nodoc
class _$BirthdayResponseCopyWithImpl<$Res, $Val extends BirthdayResponse>
    implements $BirthdayResponseCopyWith<$Res> {
  _$BirthdayResponseCopyWithImpl(this._value, this._then);

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
abstract class _$$BirthdayResponseImplCopyWith<$Res>
    implements $BirthdayResponseCopyWith<$Res> {
  factory _$$BirthdayResponseImplCopyWith(_$BirthdayResponseImpl value,
          $Res Function(_$BirthdayResponseImpl) then) =
      __$$BirthdayResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String birthday});
}

/// @nodoc
class __$$BirthdayResponseImplCopyWithImpl<$Res>
    extends _$BirthdayResponseCopyWithImpl<$Res, _$BirthdayResponseImpl>
    implements _$$BirthdayResponseImplCopyWith<$Res> {
  __$$BirthdayResponseImplCopyWithImpl(_$BirthdayResponseImpl _value,
      $Res Function(_$BirthdayResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? birthday = null,
  }) {
    return _then(_$BirthdayResponseImpl(
      birthday: null == birthday
          ? _value.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BirthdayResponseImpl implements _BirthdayResponse {
  const _$BirthdayResponseImpl({required this.birthday});

  factory _$BirthdayResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$BirthdayResponseImplFromJson(json);

  @override
  final String birthday;

  @override
  String toString() {
    return 'BirthdayResponse(birthday: $birthday)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BirthdayResponseImpl &&
            (identical(other.birthday, birthday) ||
                other.birthday == birthday));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, birthday);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BirthdayResponseImplCopyWith<_$BirthdayResponseImpl> get copyWith =>
      __$$BirthdayResponseImplCopyWithImpl<_$BirthdayResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BirthdayResponseImplToJson(
      this,
    );
  }
}

abstract class _BirthdayResponse implements BirthdayResponse {
  const factory _BirthdayResponse({required final String birthday}) =
      _$BirthdayResponseImpl;

  factory _BirthdayResponse.fromJson(Map<String, dynamic> json) =
      _$BirthdayResponseImpl.fromJson;

  @override
  String get birthday;
  @override
  @JsonKey(ignore: true)
  _$$BirthdayResponseImplCopyWith<_$BirthdayResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
