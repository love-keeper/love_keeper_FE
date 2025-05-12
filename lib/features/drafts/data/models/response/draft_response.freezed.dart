// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'draft_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DraftResponse _$DraftResponseFromJson(Map<String, dynamic> json) {
  return _DraftResponse.fromJson(json);
}

/// @nodoc
mixin _$DraftResponse {
  int get order => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _draftTypeFromJson, toJson: _draftTypeToJson)
  DraftType get draftType => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DraftResponseCopyWith<DraftResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DraftResponseCopyWith<$Res> {
  factory $DraftResponseCopyWith(
          DraftResponse value, $Res Function(DraftResponse) then) =
      _$DraftResponseCopyWithImpl<$Res, DraftResponse>;
  @useResult
  $Res call(
      {int order,
      String content,
      @JsonKey(fromJson: _draftTypeFromJson, toJson: _draftTypeToJson)
      DraftType draftType});
}

/// @nodoc
class _$DraftResponseCopyWithImpl<$Res, $Val extends DraftResponse>
    implements $DraftResponseCopyWith<$Res> {
  _$DraftResponseCopyWithImpl(this._value, this._then);

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
abstract class _$$DraftResponseImplCopyWith<$Res>
    implements $DraftResponseCopyWith<$Res> {
  factory _$$DraftResponseImplCopyWith(
          _$DraftResponseImpl value, $Res Function(_$DraftResponseImpl) then) =
      __$$DraftResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int order,
      String content,
      @JsonKey(fromJson: _draftTypeFromJson, toJson: _draftTypeToJson)
      DraftType draftType});
}

/// @nodoc
class __$$DraftResponseImplCopyWithImpl<$Res>
    extends _$DraftResponseCopyWithImpl<$Res, _$DraftResponseImpl>
    implements _$$DraftResponseImplCopyWith<$Res> {
  __$$DraftResponseImplCopyWithImpl(
      _$DraftResponseImpl _value, $Res Function(_$DraftResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? order = null,
    Object? content = null,
    Object? draftType = null,
  }) {
    return _then(_$DraftResponseImpl(
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
@JsonSerializable()
class _$DraftResponseImpl implements _DraftResponse {
  const _$DraftResponseImpl(
      {required this.order,
      required this.content,
      @JsonKey(fromJson: _draftTypeFromJson, toJson: _draftTypeToJson)
      required this.draftType});

  factory _$DraftResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$DraftResponseImplFromJson(json);

  @override
  final int order;
  @override
  final String content;
  @override
  @JsonKey(fromJson: _draftTypeFromJson, toJson: _draftTypeToJson)
  final DraftType draftType;

  @override
  String toString() {
    return 'DraftResponse(order: $order, content: $content, draftType: $draftType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DraftResponseImpl &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.draftType, draftType) ||
                other.draftType == draftType));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, order, content, draftType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DraftResponseImplCopyWith<_$DraftResponseImpl> get copyWith =>
      __$$DraftResponseImplCopyWithImpl<_$DraftResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DraftResponseImplToJson(
      this,
    );
  }
}

abstract class _DraftResponse implements DraftResponse {
  const factory _DraftResponse(
      {required final int order,
      required final String content,
      @JsonKey(fromJson: _draftTypeFromJson, toJson: _draftTypeToJson)
      required final DraftType draftType}) = _$DraftResponseImpl;

  factory _DraftResponse.fromJson(Map<String, dynamic> json) =
      _$DraftResponseImpl.fromJson;

  @override
  int get order;
  @override
  String get content;
  @override
  @JsonKey(fromJson: _draftTypeFromJson, toJson: _draftTypeToJson)
  DraftType get draftType;
  @override
  @JsonKey(ignore: true)
  _$$DraftResponseImplCopyWith<_$DraftResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
