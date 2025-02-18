// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signup_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SignupRequest _$SignupRequestFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'social':
      return SocialSignupRequest.fromJson(json);
    case 'local':
      return LocalSignupRequest.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'SignupRequest',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$SignupRequest {
  String get email => throw _privateConstructorUsedError;
  String get nickname => throw _privateConstructorUsedError;
  String get birthDate => throw _privateConstructorUsedError;
  String get provider => throw _privateConstructorUsedError;
  String? get profileImage => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email, String nickname, String birthDate,
            String provider, String providerId, String? profileImage)
        social,
    required TResult Function(String email, String password, String nickname,
            String birthDate, String provider, String? profileImage)
        local,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email, String nickname, String birthDate,
            String provider, String providerId, String? profileImage)?
        social,
    TResult? Function(String email, String password, String nickname,
            String birthDate, String provider, String? profileImage)?
        local,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email, String nickname, String birthDate,
            String provider, String providerId, String? profileImage)?
        social,
    TResult Function(String email, String password, String nickname,
            String birthDate, String provider, String? profileImage)?
        local,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SocialSignupRequest value) social,
    required TResult Function(LocalSignupRequest value) local,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SocialSignupRequest value)? social,
    TResult? Function(LocalSignupRequest value)? local,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SocialSignupRequest value)? social,
    TResult Function(LocalSignupRequest value)? local,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SignupRequestCopyWith<SignupRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignupRequestCopyWith<$Res> {
  factory $SignupRequestCopyWith(
          SignupRequest value, $Res Function(SignupRequest) then) =
      _$SignupRequestCopyWithImpl<$Res, SignupRequest>;
  @useResult
  $Res call(
      {String email,
      String nickname,
      String birthDate,
      String provider,
      String? profileImage});
}

/// @nodoc
class _$SignupRequestCopyWithImpl<$Res, $Val extends SignupRequest>
    implements $SignupRequestCopyWith<$Res> {
  _$SignupRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? nickname = null,
    Object? birthDate = null,
    Object? provider = null,
    Object? profileImage = freezed,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      birthDate: null == birthDate
          ? _value.birthDate
          : birthDate // ignore: cast_nullable_to_non_nullable
              as String,
      provider: null == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SocialSignupRequestImplCopyWith<$Res>
    implements $SignupRequestCopyWith<$Res> {
  factory _$$SocialSignupRequestImplCopyWith(_$SocialSignupRequestImpl value,
          $Res Function(_$SocialSignupRequestImpl) then) =
      __$$SocialSignupRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String email,
      String nickname,
      String birthDate,
      String provider,
      String providerId,
      String? profileImage});
}

/// @nodoc
class __$$SocialSignupRequestImplCopyWithImpl<$Res>
    extends _$SignupRequestCopyWithImpl<$Res, _$SocialSignupRequestImpl>
    implements _$$SocialSignupRequestImplCopyWith<$Res> {
  __$$SocialSignupRequestImplCopyWithImpl(_$SocialSignupRequestImpl _value,
      $Res Function(_$SocialSignupRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? nickname = null,
    Object? birthDate = null,
    Object? provider = null,
    Object? providerId = null,
    Object? profileImage = freezed,
  }) {
    return _then(_$SocialSignupRequestImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      birthDate: null == birthDate
          ? _value.birthDate
          : birthDate // ignore: cast_nullable_to_non_nullable
              as String,
      provider: null == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String,
      providerId: null == providerId
          ? _value.providerId
          : providerId // ignore: cast_nullable_to_non_nullable
              as String,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SocialSignupRequestImpl implements SocialSignupRequest {
  const _$SocialSignupRequestImpl(
      {required this.email,
      required this.nickname,
      required this.birthDate,
      required this.provider,
      required this.providerId,
      this.profileImage,
      final String? $type})
      : $type = $type ?? 'social';

  factory _$SocialSignupRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$SocialSignupRequestImplFromJson(json);

  @override
  final String email;
  @override
  final String nickname;
  @override
  final String birthDate;
  @override
  final String provider;
  @override
  final String providerId;
  @override
  final String? profileImage;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SignupRequest.social(email: $email, nickname: $nickname, birthDate: $birthDate, provider: $provider, providerId: $providerId, profileImage: $profileImage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SocialSignupRequestImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.birthDate, birthDate) ||
                other.birthDate == birthDate) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.providerId, providerId) ||
                other.providerId == providerId) &&
            (identical(other.profileImage, profileImage) ||
                other.profileImage == profileImage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, email, nickname, birthDate,
      provider, providerId, profileImage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SocialSignupRequestImplCopyWith<_$SocialSignupRequestImpl> get copyWith =>
      __$$SocialSignupRequestImplCopyWithImpl<_$SocialSignupRequestImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email, String nickname, String birthDate,
            String provider, String providerId, String? profileImage)
        social,
    required TResult Function(String email, String password, String nickname,
            String birthDate, String provider, String? profileImage)
        local,
  }) {
    return social(
        email, nickname, birthDate, provider, providerId, profileImage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email, String nickname, String birthDate,
            String provider, String providerId, String? profileImage)?
        social,
    TResult? Function(String email, String password, String nickname,
            String birthDate, String provider, String? profileImage)?
        local,
  }) {
    return social?.call(
        email, nickname, birthDate, provider, providerId, profileImage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email, String nickname, String birthDate,
            String provider, String providerId, String? profileImage)?
        social,
    TResult Function(String email, String password, String nickname,
            String birthDate, String provider, String? profileImage)?
        local,
    required TResult orElse(),
  }) {
    if (social != null) {
      return social(
          email, nickname, birthDate, provider, providerId, profileImage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SocialSignupRequest value) social,
    required TResult Function(LocalSignupRequest value) local,
  }) {
    return social(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SocialSignupRequest value)? social,
    TResult? Function(LocalSignupRequest value)? local,
  }) {
    return social?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SocialSignupRequest value)? social,
    TResult Function(LocalSignupRequest value)? local,
    required TResult orElse(),
  }) {
    if (social != null) {
      return social(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SocialSignupRequestImplToJson(
      this,
    );
  }
}

abstract class SocialSignupRequest implements SignupRequest {
  const factory SocialSignupRequest(
      {required final String email,
      required final String nickname,
      required final String birthDate,
      required final String provider,
      required final String providerId,
      final String? profileImage}) = _$SocialSignupRequestImpl;

  factory SocialSignupRequest.fromJson(Map<String, dynamic> json) =
      _$SocialSignupRequestImpl.fromJson;

  @override
  String get email;
  @override
  String get nickname;
  @override
  String get birthDate;
  @override
  String get provider;
  String get providerId;
  @override
  String? get profileImage;
  @override
  @JsonKey(ignore: true)
  _$$SocialSignupRequestImplCopyWith<_$SocialSignupRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LocalSignupRequestImplCopyWith<$Res>
    implements $SignupRequestCopyWith<$Res> {
  factory _$$LocalSignupRequestImplCopyWith(_$LocalSignupRequestImpl value,
          $Res Function(_$LocalSignupRequestImpl) then) =
      __$$LocalSignupRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String email,
      String password,
      String nickname,
      String birthDate,
      String provider,
      String? profileImage});
}

/// @nodoc
class __$$LocalSignupRequestImplCopyWithImpl<$Res>
    extends _$SignupRequestCopyWithImpl<$Res, _$LocalSignupRequestImpl>
    implements _$$LocalSignupRequestImplCopyWith<$Res> {
  __$$LocalSignupRequestImplCopyWithImpl(_$LocalSignupRequestImpl _value,
      $Res Function(_$LocalSignupRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? nickname = null,
    Object? birthDate = null,
    Object? provider = null,
    Object? profileImage = freezed,
  }) {
    return _then(_$LocalSignupRequestImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      birthDate: null == birthDate
          ? _value.birthDate
          : birthDate // ignore: cast_nullable_to_non_nullable
              as String,
      provider: null == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LocalSignupRequestImpl implements LocalSignupRequest {
  const _$LocalSignupRequestImpl(
      {required this.email,
      required this.password,
      required this.nickname,
      required this.birthDate,
      this.provider = "local",
      this.profileImage,
      final String? $type})
      : $type = $type ?? 'local';

  factory _$LocalSignupRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocalSignupRequestImplFromJson(json);

  @override
  final String email;
  @override
  final String password;
  @override
  final String nickname;
  @override
  final String birthDate;
  @override
  @JsonKey()
  final String provider;
  @override
  final String? profileImage;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SignupRequest.local(email: $email, password: $password, nickname: $nickname, birthDate: $birthDate, provider: $provider, profileImage: $profileImage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocalSignupRequestImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.birthDate, birthDate) ||
                other.birthDate == birthDate) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.profileImage, profileImage) ||
                other.profileImage == profileImage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, email, password, nickname,
      birthDate, provider, profileImage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LocalSignupRequestImplCopyWith<_$LocalSignupRequestImpl> get copyWith =>
      __$$LocalSignupRequestImplCopyWithImpl<_$LocalSignupRequestImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email, String nickname, String birthDate,
            String provider, String providerId, String? profileImage)
        social,
    required TResult Function(String email, String password, String nickname,
            String birthDate, String provider, String? profileImage)
        local,
  }) {
    return local(email, password, nickname, birthDate, provider, profileImage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email, String nickname, String birthDate,
            String provider, String providerId, String? profileImage)?
        social,
    TResult? Function(String email, String password, String nickname,
            String birthDate, String provider, String? profileImage)?
        local,
  }) {
    return local?.call(
        email, password, nickname, birthDate, provider, profileImage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email, String nickname, String birthDate,
            String provider, String providerId, String? profileImage)?
        social,
    TResult Function(String email, String password, String nickname,
            String birthDate, String provider, String? profileImage)?
        local,
    required TResult orElse(),
  }) {
    if (local != null) {
      return local(
          email, password, nickname, birthDate, provider, profileImage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SocialSignupRequest value) social,
    required TResult Function(LocalSignupRequest value) local,
  }) {
    return local(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SocialSignupRequest value)? social,
    TResult? Function(LocalSignupRequest value)? local,
  }) {
    return local?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SocialSignupRequest value)? social,
    TResult Function(LocalSignupRequest value)? local,
    required TResult orElse(),
  }) {
    if (local != null) {
      return local(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LocalSignupRequestImplToJson(
      this,
    );
  }
}

abstract class LocalSignupRequest implements SignupRequest {
  const factory LocalSignupRequest(
      {required final String email,
      required final String password,
      required final String nickname,
      required final String birthDate,
      final String provider,
      final String? profileImage}) = _$LocalSignupRequestImpl;

  factory LocalSignupRequest.fromJson(Map<String, dynamic> json) =
      _$LocalSignupRequestImpl.fromJson;

  @override
  String get email;
  String get password;
  @override
  String get nickname;
  @override
  String get birthDate;
  @override
  String get provider;
  @override
  String? get profileImage;
  @override
  @JsonKey(ignore: true)
  _$$LocalSignupRequestImplCopyWith<_$LocalSignupRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
