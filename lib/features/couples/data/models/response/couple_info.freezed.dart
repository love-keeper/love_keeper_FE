// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'couple_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CoupleInfo _$CoupleInfoFromJson(Map<String, dynamic> json) {
  return _CoupleInfo.fromJson(json);
}

/// @nodoc
mixin _$CoupleInfo {
  int get coupleId => throw _privateConstructorUsedError;
  String get partnerNickname => throw _privateConstructorUsedError;
  String? get myProfileImageUrl => throw _privateConstructorUsedError;
  String? get partnerProfileImageUrl => throw _privateConstructorUsedError;
  String get startedAt => throw _privateConstructorUsedError;
  int get days => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CoupleInfoCopyWith<CoupleInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CoupleInfoCopyWith<$Res> {
  factory $CoupleInfoCopyWith(
          CoupleInfo value, $Res Function(CoupleInfo) then) =
      _$CoupleInfoCopyWithImpl<$Res, CoupleInfo>;
  @useResult
  $Res call(
      {int coupleId,
      String partnerNickname,
      String? myProfileImageUrl,
      String? partnerProfileImageUrl,
      String startedAt,
      int days});
}

/// @nodoc
class _$CoupleInfoCopyWithImpl<$Res, $Val extends CoupleInfo>
    implements $CoupleInfoCopyWith<$Res> {
  _$CoupleInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coupleId = null,
    Object? partnerNickname = null,
    Object? myProfileImageUrl = freezed,
    Object? partnerProfileImageUrl = freezed,
    Object? startedAt = null,
    Object? days = null,
  }) {
    return _then(_value.copyWith(
      coupleId: null == coupleId
          ? _value.coupleId
          : coupleId // ignore: cast_nullable_to_non_nullable
              as int,
      partnerNickname: null == partnerNickname
          ? _value.partnerNickname
          : partnerNickname // ignore: cast_nullable_to_non_nullable
              as String,
      myProfileImageUrl: freezed == myProfileImageUrl
          ? _value.myProfileImageUrl
          : myProfileImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      partnerProfileImageUrl: freezed == partnerProfileImageUrl
          ? _value.partnerProfileImageUrl
          : partnerProfileImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      startedAt: null == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as String,
      days: null == days
          ? _value.days
          : days // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CoupleInfoImplCopyWith<$Res>
    implements $CoupleInfoCopyWith<$Res> {
  factory _$$CoupleInfoImplCopyWith(
          _$CoupleInfoImpl value, $Res Function(_$CoupleInfoImpl) then) =
      __$$CoupleInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int coupleId,
      String partnerNickname,
      String? myProfileImageUrl,
      String? partnerProfileImageUrl,
      String startedAt,
      int days});
}

/// @nodoc
class __$$CoupleInfoImplCopyWithImpl<$Res>
    extends _$CoupleInfoCopyWithImpl<$Res, _$CoupleInfoImpl>
    implements _$$CoupleInfoImplCopyWith<$Res> {
  __$$CoupleInfoImplCopyWithImpl(
      _$CoupleInfoImpl _value, $Res Function(_$CoupleInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coupleId = null,
    Object? partnerNickname = null,
    Object? myProfileImageUrl = freezed,
    Object? partnerProfileImageUrl = freezed,
    Object? startedAt = null,
    Object? days = null,
  }) {
    return _then(_$CoupleInfoImpl(
      coupleId: null == coupleId
          ? _value.coupleId
          : coupleId // ignore: cast_nullable_to_non_nullable
              as int,
      partnerNickname: null == partnerNickname
          ? _value.partnerNickname
          : partnerNickname // ignore: cast_nullable_to_non_nullable
              as String,
      myProfileImageUrl: freezed == myProfileImageUrl
          ? _value.myProfileImageUrl
          : myProfileImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      partnerProfileImageUrl: freezed == partnerProfileImageUrl
          ? _value.partnerProfileImageUrl
          : partnerProfileImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      startedAt: null == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as String,
      days: null == days
          ? _value.days
          : days // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CoupleInfoImpl implements _CoupleInfo {
  const _$CoupleInfoImpl(
      {required this.coupleId,
      required this.partnerNickname,
      this.myProfileImageUrl = null,
      this.partnerProfileImageUrl = null,
      required this.startedAt,
      required this.days});

  factory _$CoupleInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CoupleInfoImplFromJson(json);

  @override
  final int coupleId;
  @override
  final String partnerNickname;
  @override
  @JsonKey()
  final String? myProfileImageUrl;
  @override
  @JsonKey()
  final String? partnerProfileImageUrl;
  @override
  final String startedAt;
  @override
  final int days;

  @override
  String toString() {
    return 'CoupleInfo(coupleId: $coupleId, partnerNickname: $partnerNickname, myProfileImageUrl: $myProfileImageUrl, partnerProfileImageUrl: $partnerProfileImageUrl, startedAt: $startedAt, days: $days)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CoupleInfoImpl &&
            (identical(other.coupleId, coupleId) ||
                other.coupleId == coupleId) &&
            (identical(other.partnerNickname, partnerNickname) ||
                other.partnerNickname == partnerNickname) &&
            (identical(other.myProfileImageUrl, myProfileImageUrl) ||
                other.myProfileImageUrl == myProfileImageUrl) &&
            (identical(other.partnerProfileImageUrl, partnerProfileImageUrl) ||
                other.partnerProfileImageUrl == partnerProfileImageUrl) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.days, days) || other.days == days));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, coupleId, partnerNickname,
      myProfileImageUrl, partnerProfileImageUrl, startedAt, days);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CoupleInfoImplCopyWith<_$CoupleInfoImpl> get copyWith =>
      __$$CoupleInfoImplCopyWithImpl<_$CoupleInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CoupleInfoImplToJson(
      this,
    );
  }
}

abstract class _CoupleInfo implements CoupleInfo {
  const factory _CoupleInfo(
      {required final int coupleId,
      required final String partnerNickname,
      final String? myProfileImageUrl,
      final String? partnerProfileImageUrl,
      required final String startedAt,
      required final int days}) = _$CoupleInfoImpl;

  factory _CoupleInfo.fromJson(Map<String, dynamic> json) =
      _$CoupleInfoImpl.fromJson;

  @override
  int get coupleId;
  @override
  String get partnerNickname;
  @override
  String? get myProfileImageUrl;
  @override
  String? get partnerProfileImageUrl;
  @override
  String get startedAt;
  @override
  int get days;
  @override
  @JsonKey(ignore: true)
  _$$CoupleInfoImplCopyWith<_$CoupleInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
