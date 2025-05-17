// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_draft_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CreateDraftRequest _$CreateDraftRequestFromJson(Map<String, dynamic> json) {
  return _CreateDraftRequest.fromJson(json);
}

/// @nodoc
mixin _$CreateDraftRequest {
  int get draftOrder => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  DraftType get draftType => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreateDraftRequestCopyWith<CreateDraftRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateDraftRequestCopyWith<$Res> {
  factory $CreateDraftRequestCopyWith(
          CreateDraftRequest value, $Res Function(CreateDraftRequest) then) =
      _$CreateDraftRequestCopyWithImpl<$Res, CreateDraftRequest>;
  @useResult
  $Res call({int draftOrder, String content, DraftType draftType});
}

/// @nodoc
class _$CreateDraftRequestCopyWithImpl<$Res, $Val extends CreateDraftRequest>
    implements $CreateDraftRequestCopyWith<$Res> {
  _$CreateDraftRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? draftOrder = null,
    Object? content = null,
    Object? draftType = null,
  }) {
    return _then(_value.copyWith(
      draftOrder: null == draftOrder
          ? _value.draftOrder
          : draftOrder // ignore: cast_nullable_to_non_nullable
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
abstract class _$$CreateDraftRequestImplCopyWith<$Res>
    implements $CreateDraftRequestCopyWith<$Res> {
  factory _$$CreateDraftRequestImplCopyWith(_$CreateDraftRequestImpl value,
          $Res Function(_$CreateDraftRequestImpl) then) =
      __$$CreateDraftRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int draftOrder, String content, DraftType draftType});
}

/// @nodoc
class __$$CreateDraftRequestImplCopyWithImpl<$Res>
    extends _$CreateDraftRequestCopyWithImpl<$Res, _$CreateDraftRequestImpl>
    implements _$$CreateDraftRequestImplCopyWith<$Res> {
  __$$CreateDraftRequestImplCopyWithImpl(_$CreateDraftRequestImpl _value,
      $Res Function(_$CreateDraftRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? draftOrder = null,
    Object? content = null,
    Object? draftType = null,
  }) {
    return _then(_$CreateDraftRequestImpl(
      draftOrder: null == draftOrder
          ? _value.draftOrder
          : draftOrder // ignore: cast_nullable_to_non_nullable
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
class _$CreateDraftRequestImpl implements _CreateDraftRequest {
  const _$CreateDraftRequestImpl(
      {required this.draftOrder,
      required this.content,
      required this.draftType});

  factory _$CreateDraftRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateDraftRequestImplFromJson(json);

  @override
  final int draftOrder;
  @override
  final String content;
  @override
  final DraftType draftType;

  @override
  String toString() {
    return 'CreateDraftRequest(draftOrder: $draftOrder, content: $content, draftType: $draftType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateDraftRequestImpl &&
            (identical(other.draftOrder, draftOrder) ||
                other.draftOrder == draftOrder) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.draftType, draftType) ||
                other.draftType == draftType));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, draftOrder, content, draftType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateDraftRequestImplCopyWith<_$CreateDraftRequestImpl> get copyWith =>
      __$$CreateDraftRequestImplCopyWithImpl<_$CreateDraftRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateDraftRequestImplToJson(
      this,
    );
  }
}

abstract class _CreateDraftRequest implements CreateDraftRequest {
  const factory _CreateDraftRequest(
      {required final int draftOrder,
      required final String content,
      required final DraftType draftType}) = _$CreateDraftRequestImpl;

  factory _CreateDraftRequest.fromJson(Map<String, dynamic> json) =
      _$CreateDraftRequestImpl.fromJson;

  @override
  int get draftOrder;
  @override
  String get content;
  @override
  DraftType get draftType;
  @override
  @JsonKey(ignore: true)
  _$$CreateDraftRequestImplCopyWith<_$CreateDraftRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
