// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Draft {
  int get order => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  DraftType get draftType => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DraftCopyWith<Draft> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DraftCopyWith<$Res> {
  factory $DraftCopyWith(Draft value, $Res Function(Draft) then) =
      _$DraftCopyWithImpl<$Res, Draft>;
  @useResult
  $Res call({int order, String content, DraftType draftType});
}

/// @nodoc
class _$DraftCopyWithImpl<$Res, $Val extends Draft>
    implements $DraftCopyWith<$Res> {
  _$DraftCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? order = null,
    Object? content = null,
    Object? draftType = null,
  }) {
    return _then(_value.copyWith(
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      draftType: null == draftType
          ? _value.draftType
          : draftType // ignore: cast_nullable_to_non_nullable
              as DraftType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DraftImplCopyWith<$Res> implements $DraftCopyWith<$Res> {
  factory _$$DraftImplCopyWith(
          _$DraftImpl value, $Res Function(_$DraftImpl) then) =
      __$$DraftImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int order, String content, DraftType draftType});
}

/// @nodoc
class __$$DraftImplCopyWithImpl<$Res>
    extends _$DraftCopyWithImpl<$Res, _$DraftImpl>
    implements _$$DraftImplCopyWith<$Res> {
  __$$DraftImplCopyWithImpl(
      _$DraftImpl _value, $Res Function(_$DraftImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? order = null,
    Object? content = null,
    Object? draftType = null,
  }) {
    return _then(_$DraftImpl(
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      draftType: null == draftType
          ? _value.draftType
          : draftType // ignore: cast_nullable_to_non_nullable
              as DraftType,
    ));
  }
}

/// @nodoc

class _$DraftImpl implements _Draft {
  const _$DraftImpl(
      {required this.order, required this.content, required this.draftType});

  @override
  final int order;
  @override
  final String content;
  @override
  final DraftType draftType;

  @override
  String toString() {
    return 'Draft(order: $order, content: $content, draftType: $draftType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DraftImpl &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.draftType, draftType) ||
                other.draftType == draftType));
  }

  @override
  int get hashCode => Object.hash(runtimeType, order, content, draftType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DraftImplCopyWith<_$DraftImpl> get copyWith =>
      __$$DraftImplCopyWithImpl<_$DraftImpl>(this, _$identity);
}

abstract class _Draft implements Draft {
  const factory _Draft(
      {required final int order,
      required final String content,
      required final DraftType draftType}) = _$DraftImpl;

  @override
  int get order;
  @override
  String get content;
  @override
  DraftType get draftType;
  @override
  @JsonKey(ignore: true)
  _$$DraftImplCopyWith<_$DraftImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
