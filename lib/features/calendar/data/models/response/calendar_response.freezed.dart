// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CalendarResponse _$CalendarResponseFromJson(Map<String, dynamic> json) {
  return _CalendarResponse.fromJson(json);
}

/// @nodoc
mixin _$CalendarResponse {
  List<CalendarItemResponse> get letters => throw _privateConstructorUsedError;
  List<CalendarItemResponse> get promises => throw _privateConstructorUsedError;
  int get totalLetterCount => throw _privateConstructorUsedError;
  int get totalPromiseCount => throw _privateConstructorUsedError;
  int get dailyLetterCount => throw _privateConstructorUsedError;
  int get dailyPromiseCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CalendarResponseCopyWith<CalendarResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalendarResponseCopyWith<$Res> {
  factory $CalendarResponseCopyWith(
          CalendarResponse value, $Res Function(CalendarResponse) then) =
      _$CalendarResponseCopyWithImpl<$Res, CalendarResponse>;
  @useResult
  $Res call(
      {List<CalendarItemResponse> letters,
      List<CalendarItemResponse> promises,
      int totalLetterCount,
      int totalPromiseCount,
      int dailyLetterCount,
      int dailyPromiseCount});
}

/// @nodoc
class _$CalendarResponseCopyWithImpl<$Res, $Val extends CalendarResponse>
    implements $CalendarResponseCopyWith<$Res> {
  _$CalendarResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? letters = null,
    Object? promises = null,
    Object? totalLetterCount = null,
    Object? totalPromiseCount = null,
    Object? dailyLetterCount = null,
    Object? dailyPromiseCount = null,
  }) {
    return _then(_value.copyWith(
      letters: null == letters
          ? _value.letters
          : letters // ignore: cast_nullable_to_non_nullable
              as List<CalendarItemResponse>,
      promises: null == promises
          ? _value.promises
          : promises // ignore: cast_nullable_to_non_nullable
              as List<CalendarItemResponse>,
      totalLetterCount: null == totalLetterCount
          ? _value.totalLetterCount
          : totalLetterCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalPromiseCount: null == totalPromiseCount
          ? _value.totalPromiseCount
          : totalPromiseCount // ignore: cast_nullable_to_non_nullable
              as int,
      dailyLetterCount: null == dailyLetterCount
          ? _value.dailyLetterCount
          : dailyLetterCount // ignore: cast_nullable_to_non_nullable
              as int,
      dailyPromiseCount: null == dailyPromiseCount
          ? _value.dailyPromiseCount
          : dailyPromiseCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CalendarResponseImplCopyWith<$Res>
    implements $CalendarResponseCopyWith<$Res> {
  factory _$$CalendarResponseImplCopyWith(_$CalendarResponseImpl value,
          $Res Function(_$CalendarResponseImpl) then) =
      __$$CalendarResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<CalendarItemResponse> letters,
      List<CalendarItemResponse> promises,
      int totalLetterCount,
      int totalPromiseCount,
      int dailyLetterCount,
      int dailyPromiseCount});
}

/// @nodoc
class __$$CalendarResponseImplCopyWithImpl<$Res>
    extends _$CalendarResponseCopyWithImpl<$Res, _$CalendarResponseImpl>
    implements _$$CalendarResponseImplCopyWith<$Res> {
  __$$CalendarResponseImplCopyWithImpl(_$CalendarResponseImpl _value,
      $Res Function(_$CalendarResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? letters = null,
    Object? promises = null,
    Object? totalLetterCount = null,
    Object? totalPromiseCount = null,
    Object? dailyLetterCount = null,
    Object? dailyPromiseCount = null,
  }) {
    return _then(_$CalendarResponseImpl(
      letters: null == letters
          ? _value._letters
          : letters // ignore: cast_nullable_to_non_nullable
              as List<CalendarItemResponse>,
      promises: null == promises
          ? _value._promises
          : promises // ignore: cast_nullable_to_non_nullable
              as List<CalendarItemResponse>,
      totalLetterCount: null == totalLetterCount
          ? _value.totalLetterCount
          : totalLetterCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalPromiseCount: null == totalPromiseCount
          ? _value.totalPromiseCount
          : totalPromiseCount // ignore: cast_nullable_to_non_nullable
              as int,
      dailyLetterCount: null == dailyLetterCount
          ? _value.dailyLetterCount
          : dailyLetterCount // ignore: cast_nullable_to_non_nullable
              as int,
      dailyPromiseCount: null == dailyPromiseCount
          ? _value.dailyPromiseCount
          : dailyPromiseCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CalendarResponseImpl implements _CalendarResponse {
  const _$CalendarResponseImpl(
      {required final List<CalendarItemResponse> letters,
      required final List<CalendarItemResponse> promises,
      required this.totalLetterCount,
      required this.totalPromiseCount,
      required this.dailyLetterCount,
      required this.dailyPromiseCount})
      : _letters = letters,
        _promises = promises;

  factory _$CalendarResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CalendarResponseImplFromJson(json);

  final List<CalendarItemResponse> _letters;
  @override
  List<CalendarItemResponse> get letters {
    if (_letters is EqualUnmodifiableListView) return _letters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_letters);
  }

  final List<CalendarItemResponse> _promises;
  @override
  List<CalendarItemResponse> get promises {
    if (_promises is EqualUnmodifiableListView) return _promises;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_promises);
  }

  @override
  final int totalLetterCount;
  @override
  final int totalPromiseCount;
  @override
  final int dailyLetterCount;
  @override
  final int dailyPromiseCount;

  @override
  String toString() {
    return 'CalendarResponse(letters: $letters, promises: $promises, totalLetterCount: $totalLetterCount, totalPromiseCount: $totalPromiseCount, dailyLetterCount: $dailyLetterCount, dailyPromiseCount: $dailyPromiseCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CalendarResponseImpl &&
            const DeepCollectionEquality().equals(other._letters, _letters) &&
            const DeepCollectionEquality().equals(other._promises, _promises) &&
            (identical(other.totalLetterCount, totalLetterCount) ||
                other.totalLetterCount == totalLetterCount) &&
            (identical(other.totalPromiseCount, totalPromiseCount) ||
                other.totalPromiseCount == totalPromiseCount) &&
            (identical(other.dailyLetterCount, dailyLetterCount) ||
                other.dailyLetterCount == dailyLetterCount) &&
            (identical(other.dailyPromiseCount, dailyPromiseCount) ||
                other.dailyPromiseCount == dailyPromiseCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_letters),
      const DeepCollectionEquality().hash(_promises),
      totalLetterCount,
      totalPromiseCount,
      dailyLetterCount,
      dailyPromiseCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CalendarResponseImplCopyWith<_$CalendarResponseImpl> get copyWith =>
      __$$CalendarResponseImplCopyWithImpl<_$CalendarResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CalendarResponseImplToJson(
      this,
    );
  }
}

abstract class _CalendarResponse implements CalendarResponse {
  const factory _CalendarResponse(
      {required final List<CalendarItemResponse> letters,
      required final List<CalendarItemResponse> promises,
      required final int totalLetterCount,
      required final int totalPromiseCount,
      required final int dailyLetterCount,
      required final int dailyPromiseCount}) = _$CalendarResponseImpl;

  factory _CalendarResponse.fromJson(Map<String, dynamic> json) =
      _$CalendarResponseImpl.fromJson;

  @override
  List<CalendarItemResponse> get letters;
  @override
  List<CalendarItemResponse> get promises;
  @override
  int get totalLetterCount;
  @override
  int get totalPromiseCount;
  @override
  int get dailyLetterCount;
  @override
  int get dailyPromiseCount;
  @override
  @JsonKey(ignore: true)
  _$$CalendarResponseImplCopyWith<_$CalendarResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
