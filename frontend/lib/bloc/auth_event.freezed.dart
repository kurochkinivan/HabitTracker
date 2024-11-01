// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthEvent {
  String get email => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email, String name, String password)
        register,
    required TResult Function(String email, String password) login,
    required TResult Function(String email) sendVerificationCode,
    required TResult Function(String email, String code) verifyEmail,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email, String name, String password)? register,
    TResult? Function(String email, String password)? login,
    TResult? Function(String email)? sendVerificationCode,
    TResult? Function(String email, String code)? verifyEmail,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email, String name, String password)? register,
    TResult Function(String email, String password)? login,
    TResult Function(String email)? sendVerificationCode,
    TResult Function(String email, String code)? verifyEmail,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RegisterUser value) register,
    required TResult Function(LoginUser value) login,
    required TResult Function(SendVerificationCode value) sendVerificationCode,
    required TResult Function(VerifyEmail value) verifyEmail,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegisterUser value)? register,
    TResult? Function(LoginUser value)? login,
    TResult? Function(SendVerificationCode value)? sendVerificationCode,
    TResult? Function(VerifyEmail value)? verifyEmail,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegisterUser value)? register,
    TResult Function(LoginUser value)? login,
    TResult Function(SendVerificationCode value)? sendVerificationCode,
    TResult Function(VerifyEmail value)? verifyEmail,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthEventCopyWith<AuthEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthEventCopyWith<$Res> {
  factory $AuthEventCopyWith(AuthEvent value, $Res Function(AuthEvent) then) =
      _$AuthEventCopyWithImpl<$Res, AuthEvent>;
  @useResult
  $Res call({String email});
}

/// @nodoc
class _$AuthEventCopyWithImpl<$Res, $Val extends AuthEvent>
    implements $AuthEventCopyWith<$Res> {
  _$AuthEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthEvent
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
    implements $AuthEventCopyWith<$Res> {
  factory _$$RegisterUserImplCopyWith(
          _$RegisterUserImpl value, $Res Function(_$RegisterUserImpl) then) =
      __$$RegisterUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, String name, String password});
}

/// @nodoc
class __$$RegisterUserImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$RegisterUserImpl>
    implements _$$RegisterUserImplCopyWith<$Res> {
  __$$RegisterUserImplCopyWithImpl(
      _$RegisterUserImpl _value, $Res Function(_$RegisterUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? name = null,
    Object? password = null,
  }) {
    return _then(_$RegisterUserImpl(
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RegisterUserImpl implements RegisterUser {
  const _$RegisterUserImpl(this.email, this.name, this.password);

  @override
  final String email;
  @override
  final String name;
  @override
  final String password;

  @override
  String toString() {
    return 'AuthEvent.register(email: $email, name: $name, password: $password)';
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

  /// Create a copy of AuthEvent
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
    required TResult Function(String email, String password) login,
    required TResult Function(String email) sendVerificationCode,
    required TResult Function(String email, String code) verifyEmail,
  }) {
    return register(email, name, password);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email, String name, String password)? register,
    TResult? Function(String email, String password)? login,
    TResult? Function(String email)? sendVerificationCode,
    TResult? Function(String email, String code)? verifyEmail,
  }) {
    return register?.call(email, name, password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email, String name, String password)? register,
    TResult Function(String email, String password)? login,
    TResult Function(String email)? sendVerificationCode,
    TResult Function(String email, String code)? verifyEmail,
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
    required TResult Function(LoginUser value) login,
    required TResult Function(SendVerificationCode value) sendVerificationCode,
    required TResult Function(VerifyEmail value) verifyEmail,
  }) {
    return register(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegisterUser value)? register,
    TResult? Function(LoginUser value)? login,
    TResult? Function(SendVerificationCode value)? sendVerificationCode,
    TResult? Function(VerifyEmail value)? verifyEmail,
  }) {
    return register?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegisterUser value)? register,
    TResult Function(LoginUser value)? login,
    TResult Function(SendVerificationCode value)? sendVerificationCode,
    TResult Function(VerifyEmail value)? verifyEmail,
    required TResult orElse(),
  }) {
    if (register != null) {
      return register(this);
    }
    return orElse();
  }
}

abstract class RegisterUser implements AuthEvent {
  const factory RegisterUser(
          final String email, final String name, final String password) =
      _$RegisterUserImpl;

  @override
  String get email;
  String get name;
  String get password;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegisterUserImplCopyWith<_$RegisterUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoginUserImplCopyWith<$Res>
    implements $AuthEventCopyWith<$Res> {
  factory _$$LoginUserImplCopyWith(
          _$LoginUserImpl value, $Res Function(_$LoginUserImpl) then) =
      __$$LoginUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class __$$LoginUserImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$LoginUserImpl>
    implements _$$LoginUserImplCopyWith<$Res> {
  __$$LoginUserImplCopyWithImpl(
      _$LoginUserImpl _value, $Res Function(_$LoginUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_$LoginUserImpl(
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoginUserImpl implements LoginUser {
  const _$LoginUserImpl(this.email, this.password);

  @override
  final String email;
  @override
  final String password;

  @override
  String toString() {
    return 'AuthEvent.login(email: $email, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginUserImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, password);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginUserImplCopyWith<_$LoginUserImpl> get copyWith =>
      __$$LoginUserImplCopyWithImpl<_$LoginUserImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email, String name, String password)
        register,
    required TResult Function(String email, String password) login,
    required TResult Function(String email) sendVerificationCode,
    required TResult Function(String email, String code) verifyEmail,
  }) {
    return login(email, password);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email, String name, String password)? register,
    TResult? Function(String email, String password)? login,
    TResult? Function(String email)? sendVerificationCode,
    TResult? Function(String email, String code)? verifyEmail,
  }) {
    return login?.call(email, password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email, String name, String password)? register,
    TResult Function(String email, String password)? login,
    TResult Function(String email)? sendVerificationCode,
    TResult Function(String email, String code)? verifyEmail,
    required TResult orElse(),
  }) {
    if (login != null) {
      return login(email, password);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RegisterUser value) register,
    required TResult Function(LoginUser value) login,
    required TResult Function(SendVerificationCode value) sendVerificationCode,
    required TResult Function(VerifyEmail value) verifyEmail,
  }) {
    return login(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegisterUser value)? register,
    TResult? Function(LoginUser value)? login,
    TResult? Function(SendVerificationCode value)? sendVerificationCode,
    TResult? Function(VerifyEmail value)? verifyEmail,
  }) {
    return login?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegisterUser value)? register,
    TResult Function(LoginUser value)? login,
    TResult Function(SendVerificationCode value)? sendVerificationCode,
    TResult Function(VerifyEmail value)? verifyEmail,
    required TResult orElse(),
  }) {
    if (login != null) {
      return login(this);
    }
    return orElse();
  }
}

abstract class LoginUser implements AuthEvent {
  const factory LoginUser(final String email, final String password) =
      _$LoginUserImpl;

  @override
  String get email;
  String get password;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginUserImplCopyWith<_$LoginUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SendVerificationCodeImplCopyWith<$Res>
    implements $AuthEventCopyWith<$Res> {
  factory _$$SendVerificationCodeImplCopyWith(_$SendVerificationCodeImpl value,
          $Res Function(_$SendVerificationCodeImpl) then) =
      __$$SendVerificationCodeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email});
}

/// @nodoc
class __$$SendVerificationCodeImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$SendVerificationCodeImpl>
    implements _$$SendVerificationCodeImplCopyWith<$Res> {
  __$$SendVerificationCodeImplCopyWithImpl(_$SendVerificationCodeImpl _value,
      $Res Function(_$SendVerificationCodeImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
  }) {
    return _then(_$SendVerificationCodeImpl(
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SendVerificationCodeImpl implements SendVerificationCode {
  const _$SendVerificationCodeImpl(this.email);

  @override
  final String email;

  @override
  String toString() {
    return 'AuthEvent.sendVerificationCode(email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendVerificationCodeImpl &&
            (identical(other.email, email) || other.email == email));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SendVerificationCodeImplCopyWith<_$SendVerificationCodeImpl>
      get copyWith =>
          __$$SendVerificationCodeImplCopyWithImpl<_$SendVerificationCodeImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email, String name, String password)
        register,
    required TResult Function(String email, String password) login,
    required TResult Function(String email) sendVerificationCode,
    required TResult Function(String email, String code) verifyEmail,
  }) {
    return sendVerificationCode(email);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email, String name, String password)? register,
    TResult? Function(String email, String password)? login,
    TResult? Function(String email)? sendVerificationCode,
    TResult? Function(String email, String code)? verifyEmail,
  }) {
    return sendVerificationCode?.call(email);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email, String name, String password)? register,
    TResult Function(String email, String password)? login,
    TResult Function(String email)? sendVerificationCode,
    TResult Function(String email, String code)? verifyEmail,
    required TResult orElse(),
  }) {
    if (sendVerificationCode != null) {
      return sendVerificationCode(email);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RegisterUser value) register,
    required TResult Function(LoginUser value) login,
    required TResult Function(SendVerificationCode value) sendVerificationCode,
    required TResult Function(VerifyEmail value) verifyEmail,
  }) {
    return sendVerificationCode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegisterUser value)? register,
    TResult? Function(LoginUser value)? login,
    TResult? Function(SendVerificationCode value)? sendVerificationCode,
    TResult? Function(VerifyEmail value)? verifyEmail,
  }) {
    return sendVerificationCode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegisterUser value)? register,
    TResult Function(LoginUser value)? login,
    TResult Function(SendVerificationCode value)? sendVerificationCode,
    TResult Function(VerifyEmail value)? verifyEmail,
    required TResult orElse(),
  }) {
    if (sendVerificationCode != null) {
      return sendVerificationCode(this);
    }
    return orElse();
  }
}

abstract class SendVerificationCode implements AuthEvent {
  const factory SendVerificationCode(final String email) =
      _$SendVerificationCodeImpl;

  @override
  String get email;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SendVerificationCodeImplCopyWith<_$SendVerificationCodeImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$VerifyEmailImplCopyWith<$Res>
    implements $AuthEventCopyWith<$Res> {
  factory _$$VerifyEmailImplCopyWith(
          _$VerifyEmailImpl value, $Res Function(_$VerifyEmailImpl) then) =
      __$$VerifyEmailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, String code});
}

/// @nodoc
class __$$VerifyEmailImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$VerifyEmailImpl>
    implements _$$VerifyEmailImplCopyWith<$Res> {
  __$$VerifyEmailImplCopyWithImpl(
      _$VerifyEmailImpl _value, $Res Function(_$VerifyEmailImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? code = null,
  }) {
    return _then(_$VerifyEmailImpl(
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$VerifyEmailImpl implements VerifyEmail {
  const _$VerifyEmailImpl(this.email, this.code);

  @override
  final String email;
  @override
  final String code;

  @override
  String toString() {
    return 'AuthEvent.verifyEmail(email: $email, code: $code)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerifyEmailImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.code, code) || other.code == code));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, code);

  /// Create a copy of AuthEvent
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
    required TResult Function(String email, String password) login,
    required TResult Function(String email) sendVerificationCode,
    required TResult Function(String email, String code) verifyEmail,
  }) {
    return verifyEmail(email, code);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email, String name, String password)? register,
    TResult? Function(String email, String password)? login,
    TResult? Function(String email)? sendVerificationCode,
    TResult? Function(String email, String code)? verifyEmail,
  }) {
    return verifyEmail?.call(email, code);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email, String name, String password)? register,
    TResult Function(String email, String password)? login,
    TResult Function(String email)? sendVerificationCode,
    TResult Function(String email, String code)? verifyEmail,
    required TResult orElse(),
  }) {
    if (verifyEmail != null) {
      return verifyEmail(email, code);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RegisterUser value) register,
    required TResult Function(LoginUser value) login,
    required TResult Function(SendVerificationCode value) sendVerificationCode,
    required TResult Function(VerifyEmail value) verifyEmail,
  }) {
    return verifyEmail(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegisterUser value)? register,
    TResult? Function(LoginUser value)? login,
    TResult? Function(SendVerificationCode value)? sendVerificationCode,
    TResult? Function(VerifyEmail value)? verifyEmail,
  }) {
    return verifyEmail?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegisterUser value)? register,
    TResult Function(LoginUser value)? login,
    TResult Function(SendVerificationCode value)? sendVerificationCode,
    TResult Function(VerifyEmail value)? verifyEmail,
    required TResult orElse(),
  }) {
    if (verifyEmail != null) {
      return verifyEmail(this);
    }
    return orElse();
  }
}

abstract class VerifyEmail implements AuthEvent {
  const factory VerifyEmail(final String email, final String code) =
      _$VerifyEmailImpl;

  @override
  String get email;
  String get code;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VerifyEmailImplCopyWith<_$VerifyEmailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
