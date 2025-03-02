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
  int get memberId => throw _privateConstructorUsedError;
  String get nickname => throw _privateConstructorUsedError;
  String get birthday => throw _privateConstructorUsedError;
  String get relationshipStartDate => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get profileImageUrl =>
      throw _privateConstructorUsedError; // null을 기본값으로 설정
  String get coupleNickname => throw _privateConstructorUsedError;

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
      {int memberId,
      String nickname,
      String birthday,
      String relationshipStartDate,
      String email,
      String? profileImageUrl,
      String coupleNickname});
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
    Object? memberId = null,
    Object? nickname = null,
    Object? birthday = null,
    Object? relationshipStartDate = null,
    Object? email = null,
    Object? profileImageUrl = freezed,
    Object? coupleNickname = null,
  }) {
    return _then(_value.copyWith(
      memberId: null == memberId
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as int,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      birthday: null == birthday
          ? _value.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as String,
      relationshipStartDate: null == relationshipStartDate
          ? _value.relationshipStartDate
          : relationshipStartDate // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      profileImageUrl: freezed == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      coupleNickname: null == coupleNickname
          ? _value.coupleNickname
          : coupleNickname // ignore: cast_nullable_to_non_nullable
              as String,
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
      {int memberId,
      String nickname,
      String birthday,
      String relationshipStartDate,
      String email,
      String? profileImageUrl,
      String coupleNickname});
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
    Object? memberId = null,
    Object? nickname = null,
    Object? birthday = null,
    Object? relationshipStartDate = null,
    Object? email = null,
    Object? profileImageUrl = freezed,
    Object? coupleNickname = null,
  }) {
    return _then(_$CoupleInfoImpl(
      memberId: null == memberId
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as int,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      birthday: null == birthday
          ? _value.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as String,
      relationshipStartDate: null == relationshipStartDate
          ? _value.relationshipStartDate
          : relationshipStartDate // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      profileImageUrl: freezed == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      coupleNickname: null == coupleNickname
          ? _value.coupleNickname
          : coupleNickname // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CoupleInfoImpl implements _CoupleInfo {
  const _$CoupleInfoImpl(
      {required this.memberId,
      required this.nickname,
      required this.birthday,
      required this.relationshipStartDate,
      required this.email,
      this.profileImageUrl = null,
      required this.coupleNickname});

  factory _$CoupleInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CoupleInfoImplFromJson(json);

  @override
  final int memberId;
  @override
  final String nickname;
  @override
  final String birthday;
  @override
  final String relationshipStartDate;
  @override
  final String email;
  @override
  @JsonKey()
  final String? profileImageUrl;
// null을 기본값으로 설정
  @override
  final String coupleNickname;

  @override
  String toString() {
    return 'CoupleInfo(memberId: $memberId, nickname: $nickname, birthday: $birthday, relationshipStartDate: $relationshipStartDate, email: $email, profileImageUrl: $profileImageUrl, coupleNickname: $coupleNickname)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CoupleInfoImpl &&
            (identical(other.memberId, memberId) ||
                other.memberId == memberId) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.birthday, birthday) ||
                other.birthday == birthday) &&
            (identical(other.relationshipStartDate, relationshipStartDate) ||
                other.relationshipStartDate == relationshipStartDate) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.profileImageUrl, profileImageUrl) ||
                other.profileImageUrl == profileImageUrl) &&
            (identical(other.coupleNickname, coupleNickname) ||
                other.coupleNickname == coupleNickname));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, memberId, nickname, birthday,
      relationshipStartDate, email, profileImageUrl, coupleNickname);

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
      {required final int memberId,
      required final String nickname,
      required final String birthday,
      required final String relationshipStartDate,
      required final String email,
      final String? profileImageUrl,
      required final String coupleNickname}) = _$CoupleInfoImpl;

  factory _CoupleInfo.fromJson(Map<String, dynamic> json) =
      _$CoupleInfoImpl.fromJson;

  @override
  int get memberId;
  @override
  String get nickname;
  @override
  String get birthday;
  @override
  String get relationshipStartDate;
  @override
  String get email;
  @override
  String? get profileImageUrl;
  @override // null을 기본값으로 설정
  String get coupleNickname;
  @override
  @JsonKey(ignore: true)
  _$$CoupleInfoImplCopyWith<_$CoupleInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
