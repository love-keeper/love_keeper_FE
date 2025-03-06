// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Calendar {
  List<CalendarItemResponse> get letters => throw _privateConstructorUsedError;
  List<CalendarItemResponse> get promises => throw _privateConstructorUsedError;
  int get totalLetterCount => throw _privateConstructorUsedError;
  int get totalPromiseCount => throw _privateConstructorUsedError;
  int get dailyLetterCount => throw _privateConstructorUsedError;
  int get dailyPromiseCount => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CalendarCopyWith<Calendar> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalendarCopyWith<$Res> {
  factory $CalendarCopyWith(Calendar value, $Res Function(Calendar) then) =
      _$CalendarCopyWithImpl<$Res, Calendar>;
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
class _$CalendarCopyWithImpl<$Res, $Val extends Calendar>
    implements $CalendarCopyWith<$Res> {
  _$CalendarCopyWithImpl(this._value, this._then);

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
abstract class _$$CalendarImplCopyWith<$Res>
    implements $CalendarCopyWith<$Res> {
  factory _$$CalendarImplCopyWith(
          _$CalendarImpl value, $Res Function(_$CalendarImpl) then) =
      __$$CalendarImplCopyWithImpl<$Res>;
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
class __$$CalendarImplCopyWithImpl<$Res>
    extends _$CalendarCopyWithImpl<$Res, _$CalendarImpl>
    implements _$$CalendarImplCopyWith<$Res> {
  __$$CalendarImplCopyWithImpl(
      _$CalendarImpl _value, $Res Function(_$CalendarImpl) _then)
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
    return _then(_$CalendarImpl(
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

class _$CalendarImpl implements _Calendar {
  const _$CalendarImpl(
      {required final List<CalendarItemResponse> letters,
      required final List<CalendarItemResponse> promises,
      required this.totalLetterCount,
      required this.totalPromiseCount,
      required this.dailyLetterCount,
      required this.dailyPromiseCount})
      : _letters = letters,
        _promises = promises;

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
    return 'Calendar(letters: $letters, promises: $promises, totalLetterCount: $totalLetterCount, totalPromiseCount: $totalPromiseCount, dailyLetterCount: $dailyLetterCount, dailyPromiseCount: $dailyPromiseCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CalendarImpl &&
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
  _$$CalendarImplCopyWith<_$CalendarImpl> get copyWith =>
      __$$CalendarImplCopyWithImpl<_$CalendarImpl>(this, _$identity);
}

abstract class _Calendar implements Calendar {
  const factory _Calendar(
      {required final List<CalendarItemResponse> letters,
      required final List<CalendarItemResponse> promises,
      required final int totalLetterCount,
      required final int totalPromiseCount,
      required final int dailyLetterCount,
      required final int dailyPromiseCount}) = _$CalendarImpl;

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
  _$$CalendarImplCopyWith<_$CalendarImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
