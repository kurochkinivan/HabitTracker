// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'registration_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RegistrationEvent {
  String get email => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email, String name, String password)
        register,
    required TResult Function(String email) getVerificationCode,
    required TResult Function(String code, String email, String fingerprint)
        verifyEmail,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email, String name, String password)? register,
    TResult? Function(String email)? getVerificationCode,
    TResult? Function(String code, String email, String fingerprint)?
        verifyEmail,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email, String name, String password)? register,
    TResult Function(String email)? getVerificationCode,
    TResult Function(String code, String email, String fingerprint)?
        verifyEmail,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RegisterUser value) register,
    required TResult Function(GetVerificationCode value) getVerificationCode,
    required TResult Function(VerifyEmail value) verifyEmail,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegisterUser value)? register,
    TResult? Function(GetVerificationCode value)? getVerificationCode,
    TResult? Function(VerifyEmail value)? verifyEmail,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegisterUser value)? register,
    TResult Function(GetVerificationCode value)? getVerificationCode,
    TResult Function(VerifyEmail value)? verifyEmail,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of RegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RegistrationEventCopyWith<RegistrationEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegistrationEventCopyWith<$Res> {
  factory $RegistrationEventCopyWith(
          RegistrationEvent value, $Res Function(RegistrationEvent) then) =
      _$RegistrationEventCopyWithImpl<$Res, RegistrationEvent>;
  @useResult
  $Res call({String email});
}

/// @nodoc
class _$RegistrationEventCopyWithImpl<$Res, $Val extends RegistrationEvent>
    implements $RegistrationEventCopyWith<$Res> {
  _$RegistrationEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RegisterUserImplCopyWith<$Res>
    implements $RegistrationEventCopyWith<$Res> {
  factory _$$RegisterUserImplCopyWith(
          _$RegisterUserImpl value, $Res Function(_$RegisterUserImpl) then) =
      __$$RegisterUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, String name, String password});
}

/// @nodoc
class __$$RegisterUserImplCopyWithImpl<$Res>
    extends _$RegistrationEventCopyWithImpl<$Res, _$RegisterUserImpl>
    implements _$$RegisterUserImplCopyWith<$Res> {
  __$$RegisterUserImplCopyWithImpl(
      _$RegisterUserImpl _value, $Res Function(_$RegisterUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? name = null,
    Object? password = null,
  }) {
    return _then(_$RegisterUserImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RegisterUserImpl implements RegisterUser {
  const _$RegisterUserImpl(
      {required this.email, required this.name, required this.password});

  @override
  final String email;
  @override
  final String name;
  @override
  final String password;

  @override
  String toString() {
    return 'RegistrationEvent.register(email: $email, name: $name, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterUserImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, name, password);

  /// Create a copy of RegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterUserImplCopyWith<_$RegisterUserImpl> get copyWith =>
      __$$RegisterUserImplCopyWithImpl<_$RegisterUserImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email, String name, String password)
        register,
    required TResult Function(String email) getVerificationCode,
    required TResult Function(String code, String email, String fingerprint)
        verifyEmail,
  }) {
    return register(email, name, password);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email, String name, String password)? register,
    TResult? Function(String email)? getVerificationCode,
    TResult? Function(String code, String email, String fingerprint)?
        verifyEmail,
  }) {
    return register?.call(email, name, password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email, String name, String password)? register,
    TResult Function(String email)? getVerificationCode,
    TResult Function(String code, String email, String fingerprint)?
        verifyEmail,
    required TResult orElse(),
  }) {
    if (register != null) {
      return register(email, name, password);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RegisterUser value) register,
    required TResult Function(GetVerificationCode value) getVerificationCode,
    required TResult Function(VerifyEmail value) verifyEmail,
  }) {
    return register(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegisterUser value)? register,
    TResult? Function(GetVerificationCode value)? getVerificationCode,
    TResult? Function(VerifyEmail value)? verifyEmail,
  }) {
    return register?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegisterUser value)? register,
    TResult Function(GetVerificationCode value)? getVerificationCode,
    TResult Function(VerifyEmail value)? verifyEmail,
    required TResult orElse(),
  }) {
    if (register != null) {
      return register(this);
    }
    return orElse();
  }
}

abstract class RegisterUser implements RegistrationEvent {
  const factory RegisterUser(
      {required final String email,
      required final String name,
      required final String password}) = _$RegisterUserImpl;

  @override
  String get email;
  String get name;
  String get password;

  /// Create a copy of RegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegisterUserImplCopyWith<_$RegisterUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GetVerificationCodeImplCopyWith<$Res>
    implements $RegistrationEventCopyWith<$Res> {
  factory _$$GetVerificationCodeImplCopyWith(_$GetVerificationCodeImpl value,
          $Res Function(_$GetVerificationCodeImpl) then) =
      __$$GetVerificationCodeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email});
}

/// @nodoc
class __$$GetVerificationCodeImplCopyWithImpl<$Res>
    extends _$RegistrationEventCopyWithImpl<$Res, _$GetVerificationCodeImpl>
    implements _$$GetVerificationCodeImplCopyWith<$Res> {
  __$$GetVerificationCodeImplCopyWithImpl(_$GetVerificationCodeImpl _value,
      $Res Function(_$GetVerificationCodeImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
  }) {
    return _then(_$GetVerificationCodeImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GetVerificationCodeImpl implements GetVerificationCode {
  const _$GetVerificationCodeImpl({required this.email});

  @override
  final String email;

  @override
  String toString() {
    return 'RegistrationEvent.getVerificationCode(email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetVerificationCodeImpl &&
            (identical(other.email, email) || other.email == email));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email);

  /// Create a copy of RegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetVerificationCodeImplCopyWith<_$GetVerificationCodeImpl> get copyWith =>
      __$$GetVerificationCodeImplCopyWithImpl<_$GetVerificationCodeImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email, String name, String password)
        register,
    required TResult Function(String email) getVerificationCode,
    required TResult Function(String code, String email, String fingerprint)
        verifyEmail,
  }) {
    return getVerificationCode(email);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email, String name, String password)? register,
    TResult? Function(String email)? getVerificationCode,
    TResult? Function(String code, String email, String fingerprint)?
        verifyEmail,
  }) {
    return getVerificationCode?.call(email);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email, String name, String password)? register,
    TResult Function(String email)? getVerificationCode,
    TResult Function(String code, String email, String fingerprint)?
        verifyEmail,
    required TResult orElse(),
  }) {
    if (getVerificationCode != null) {
      return getVerificationCode(email);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RegisterUser value) register,
    required TResult Function(GetVerificationCode value) getVerificationCode,
    required TResult Function(VerifyEmail value) verifyEmail,
  }) {
    return getVerificationCode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegisterUser value)? register,
    TResult? Function(GetVerificationCode value)? getVerificationCode,
    TResult? Function(VerifyEmail value)? verifyEmail,
  }) {
    return getVerificationCode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegisterUser value)? register,
    TResult Function(GetVerificationCode value)? getVerificationCode,
    TResult Function(VerifyEmail value)? verifyEmail,
    required TResult orElse(),
  }) {
    if (getVerificationCode != null) {
      return getVerificationCode(this);
    }
    return orElse();
  }
}

abstract class GetVerificationCode implements RegistrationEvent {
  const factory GetVerificationCode({required final String email}) =
      _$GetVerificationCodeImpl;

  @override
  String get email;

  /// Create a copy of RegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetVerificationCodeImplCopyWith<_$GetVerificationCodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$VerifyEmailImplCopyWith<$Res>
    implements $RegistrationEventCopyWith<$Res> {
  factory _$$VerifyEmailImplCopyWith(
          _$VerifyEmailImpl value, $Res Function(_$VerifyEmailImpl) then) =
      __$$VerifyEmailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String code, String email, String fingerprint});
}

/// @nodoc
class __$$VerifyEmailImplCopyWithImpl<$Res>
    extends _$RegistrationEventCopyWithImpl<$Res, _$VerifyEmailImpl>
    implements _$$VerifyEmailImplCopyWith<$Res> {
  __$$VerifyEmailImplCopyWithImpl(
      _$VerifyEmailImpl _value, $Res Function(_$VerifyEmailImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? email = null,
    Object? fingerprint = null,
  }) {
    return _then(_$VerifyEmailImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      fingerprint: null == fingerprint
          ? _value.fingerprint
          : fingerprint // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$VerifyEmailImpl implements VerifyEmail {
  const _$VerifyEmailImpl(
      {required this.code, required this.email, required this.fingerprint});

  @override
  final String code;
  @override
  final String email;
  @override
  final String fingerprint;

  @override
  String toString() {
    return 'RegistrationEvent.verifyEmail(code: $code, email: $email, fingerprint: $fingerprint)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerifyEmailImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.fingerprint, fingerprint) ||
                other.fingerprint == fingerprint));
  }

  @override
  int get hashCode => Object.hash(runtimeType, code, email, fingerprint);

  /// Create a copy of RegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VerifyEmailImplCopyWith<_$VerifyEmailImpl> get copyWith =>
      __$$VerifyEmailImplCopyWithImpl<_$VerifyEmailImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email, String name, String password)
        register,
    required TResult Function(String email) getVerificationCode,
    required TResult Function(String code, String email, String fingerprint)
        verifyEmail,
  }) {
    return verifyEmail(code, email, fingerprint);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email, String name, String password)? register,
    TResult? Function(String email)? getVerificationCode,
    TResult? Function(String code, String email, String fingerprint)?
        verifyEmail,
  }) {
    return verifyEmail?.call(code, email, fingerprint);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email, String name, String password)? register,
    TResult Function(String email)? getVerificationCode,
    TResult Function(String code, String email, String fingerprint)?
        verifyEmail,
    required TResult orElse(),
  }) {
    if (verifyEmail != null) {
      return verifyEmail(code, email, fingerprint);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RegisterUser value) register,
    required TResult Function(GetVerificationCode value) getVerificationCode,
    required TResult Function(VerifyEmail value) verifyEmail,
  }) {
    return verifyEmail(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegisterUser value)? register,
    TResult? Function(GetVerificationCode value)? getVerificationCode,
    TResult? Function(VerifyEmail value)? verifyEmail,
  }) {
    return verifyEmail?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegisterUser value)? register,
    TResult Function(GetVerificationCode value)? getVerificationCode,
    TResult Function(VerifyEmail value)? verifyEmail,
    required TResult orElse(),
  }) {
    if (verifyEmail != null) {
      return verifyEmail(this);
    }
    return orElse();
  }
}

abstract class VerifyEmail implements RegistrationEvent {
  const factory VerifyEmail(
      {required final String code,
      required final String email,
      required final String fingerprint}) = _$VerifyEmailImpl;

  String get code;
  @override
  String get email;
  String get fingerprint;

  /// Create a copy of RegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VerifyEmailImplCopyWith<_$VerifyEmailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
