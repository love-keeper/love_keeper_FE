// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_item_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CalendarItemResponse _$CalendarItemResponseFromJson(Map<String, dynamic> json) {
  return _CalendarItemResponse.fromJson(json);
}

/// @nodoc
mixin _$CalendarItemResponse {
  String get date => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CalendarItemResponseCopyWith<CalendarItemResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalendarItemResponseCopyWith<$Res> {
  factory $CalendarItemResponseCopyWith(CalendarItemResponse value,
          $Res Function(CalendarItemResponse) then) =
      _$CalendarItemResponseCopyWithImpl<$Res, CalendarItemResponse>;
  @useResult
  $Res call({String date, int count});
}

/// @nodoc
class _$CalendarItemResponseCopyWithImpl<$Res,
        $Val extends CalendarItemResponse>
    implements $CalendarItemResponseCopyWith<$Res> {
  _$CalendarItemResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? count = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CalendarItemResponseImplCopyWith<$Res>
    implements $CalendarItemResponseCopyWith<$Res> {
  factory _$$CalendarItemResponseImplCopyWith(_$CalendarItemResponseImpl value,
          $Res Function(_$CalendarItemResponseImpl) then) =
      __$$CalendarItemResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String date, int count});
}

/// @nodoc
class __$$CalendarItemResponseImplCopyWithImpl<$Res>
    extends _$CalendarItemResponseCopyWithImpl<$Res, _$CalendarItemResponseImpl>
    implements _$$CalendarItemResponseImplCopyWith<$Res> {
  __$$CalendarItemResponseImplCopyWithImpl(_$CalendarItemResponseImpl _value,
      $Res Function(_$CalendarItemResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? count = null,
  }) {
    return _then(_$CalendarItemResponseImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CalendarItemResponseImpl implements _CalendarItemResponse {
  const _$CalendarItemResponseImpl({required this.date, required this.count});

  factory _$CalendarItemResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CalendarItemResponseImplFromJson(json);

  @override
  final String date;
  @override
  final int count;

  @override
  String toString() {
    return 'CalendarItemResponse(date: $date, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CalendarItemResponseImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, date, count);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CalendarItemResponseImplCopyWith<_$CalendarItemResponseImpl>
      get copyWith =>
          __$$CalendarItemResponseImplCopyWithImpl<_$CalendarItemResponseImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CalendarItemResponseImplToJson(
      this,
    );
  }
}

abstract class _CalendarItemResponse implements CalendarItemResponse {
  const factory _CalendarItemResponse(
      {required final String date,
      required final int count}) = _$CalendarItemResponseImpl;

  factory _CalendarItemResponse.fromJson(Map<String, dynamic> json) =
      _$CalendarItemResponseImpl.fromJson;

  @override
  String get date;
  @override
  int get count;
  @override
  @JsonKey(ignore: true)
  _$$CalendarItemResponseImplCopyWith<_$CalendarItemResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
