// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_start_date_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UpdateStartDateRequest _$UpdateStartDateRequestFromJson(
    Map<String, dynamic> json) {
  return _UpdateStartDateRequest.fromJson(json);
}

/// @nodoc
mixin _$UpdateStartDateRequest {
  String get newStartDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UpdateStartDateRequestCopyWith<UpdateStartDateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateStartDateRequestCopyWith<$Res> {
  factory $UpdateStartDateRequestCopyWith(UpdateStartDateRequest value,
          $Res Function(UpdateStartDateRequest) then) =
      _$UpdateStartDateRequestCopyWithImpl<$Res, UpdateStartDateRequest>;
  @useResult
  $Res call({String newStartDate});
}

/// @nodoc
class _$UpdateStartDateRequestCopyWithImpl<$Res,
        $Val extends UpdateStartDateRequest>
    implements $UpdateStartDateRequestCopyWith<$Res> {
  _$UpdateStartDateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newStartDate = null,
  }) {
    return _then(_value.copyWith(
      newStartDate: null == newStartDate
          ? _value.newStartDate
          : newStartDate // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdateStartDateRequestImplCopyWith<$Res>
    implements $UpdateStartDateRequestCopyWith<$Res> {
  factory _$$UpdateStartDateRequestImplCopyWith(
          _$UpdateStartDateRequestImpl value,
          $Res Function(_$UpdateStartDateRequestImpl) then) =
      __$$UpdateStartDateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String newStartDate});
}

/// @nodoc
class __$$UpdateStartDateRequestImplCopyWithImpl<$Res>
    extends _$UpdateStartDateRequestCopyWithImpl<$Res,
        _$UpdateStartDateRequestImpl>
    implements _$$UpdateStartDateRequestImplCopyWith<$Res> {
  __$$UpdateStartDateRequestImplCopyWithImpl(
      _$UpdateStartDateRequestImpl _value,
      $Res Function(_$UpdateStartDateRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newStartDate = null,
  }) {
    return _then(_$UpdateStartDateRequestImpl(
      newStartDate: null == newStartDate
          ? _value.newStartDate
          : newStartDate // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateStartDateRequestImpl implements _UpdateStartDateRequest {
  const _$UpdateStartDateRequestImpl({required this.newStartDate});

  factory _$UpdateStartDateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateStartDateRequestImplFromJson(json);

  @override
  final String newStartDate;

  @override
  String toString() {
    return 'UpdateStartDateRequest(newStartDate: $newStartDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateStartDateRequestImpl &&
            (identical(other.newStartDate, newStartDate) ||
                other.newStartDate == newStartDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, newStartDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateStartDateRequestImplCopyWith<_$UpdateStartDateRequestImpl>
      get copyWith => __$$UpdateStartDateRequestImplCopyWithImpl<
          _$UpdateStartDateRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateStartDateRequestImplToJson(
      this,
    );
  }
}

abstract class _UpdateStartDateRequest implements UpdateStartDateRequest {
  const factory _UpdateStartDateRequest({required final String newStartDate}) =
      _$UpdateStartDateRequestImpl;

  factory _UpdateStartDateRequest.fromJson(Map<String, dynamic> json) =
      _$UpdateStartDateRequestImpl.fromJson;

  @override
  String get newStartDate;
  @override
  @JsonKey(ignore: true)
  _$$UpdateStartDateRequestImplCopyWith<_$UpdateStartDateRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
