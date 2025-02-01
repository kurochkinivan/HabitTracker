// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'authentication_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthenticationState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) authenticated,
    required TResult Function(String errorMessage) failure,
    required TResult Function(bool isValid) authChecked,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String message)? authenticated,
    TResult? Function(String errorMessage)? failure,
    TResult? Function(bool isValid)? authChecked,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? authenticated,
    TResult Function(String errorMessage)? failure,
    TResult Function(bool isValid)? authChecked,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthenticationInitial value) initial,
    required TResult Function(AuthenticationLoading value) loading,
    required TResult Function(AuthenticationAuthenticated value) authenticated,
    required TResult Function(AuthenticationFailure value) failure,
    required TResult Function(AuthenticationAuthChecked value) authChecked,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthenticationInitial value)? initial,
    TResult? Function(AuthenticationLoading value)? loading,
    TResult? Function(AuthenticationAuthenticated value)? authenticated,
    TResult? Function(AuthenticationFailure value)? failure,
    TResult? Function(AuthenticationAuthChecked value)? authChecked,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthenticationInitial value)? initial,
    TResult Function(AuthenticationLoading value)? loading,
    TResult Function(AuthenticationAuthenticated value)? authenticated,
    TResult Function(AuthenticationFailure value)? failure,
    TResult Function(AuthenticationAuthChecked value)? authChecked,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthenticationStateCopyWith<$Res> {
  factory $AuthenticationStateCopyWith(
          AuthenticationState value, $Res Function(AuthenticationState) then) =
      _$AuthenticationStateCopyWithImpl<$Res, AuthenticationState>;
}

/// @nodoc
class _$AuthenticationStateCopyWithImpl<$Res, $Val extends AuthenticationState>
    implements $AuthenticationStateCopyWith<$Res> {
  _$AuthenticationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AuthenticationInitialImplCopyWith<$Res> {
  factory _$$AuthenticationInitialImplCopyWith(
          _$AuthenticationInitialImpl value,
          $Res Function(_$AuthenticationInitialImpl) then) =
      __$$AuthenticationInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthenticationInitialImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res, _$AuthenticationInitialImpl>
    implements _$$AuthenticationInitialImplCopyWith<$Res> {
  __$$AuthenticationInitialImplCopyWithImpl(_$AuthenticationInitialImpl _value,
      $Res Function(_$AuthenticationInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AuthenticationInitialImpl implements AuthenticationInitial {
  const _$AuthenticationInitialImpl();

  @override
  String toString() {
    return 'AuthenticationState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) authenticated,
    required TResult Function(String errorMessage) failure,
    required TResult Function(bool isValid) authChecked,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String message)? authenticated,
    TResult? Function(String errorMessage)? failure,
    TResult? Function(bool isValid)? authChecked,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? authenticated,
    TResult Function(String errorMessage)? failure,
    TResult Function(bool isValid)? authChecked,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthenticationInitial value) initial,
    required TResult Function(AuthenticationLoading value) loading,
    required TResult Function(AuthenticationAuthenticated value) authenticated,
    required TResult Function(AuthenticationFailure value) failure,
    required TResult Function(AuthenticationAuthChecked value) authChecked,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthenticationInitial value)? initial,
    TResult? Function(AuthenticationLoading value)? loading,
    TResult? Function(AuthenticationAuthenticated value)? authenticated,
    TResult? Function(AuthenticationFailure value)? failure,
    TResult? Function(AuthenticationAuthChecked value)? authChecked,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthenticationInitial value)? initial,
    TResult Function(AuthenticationLoading value)? loading,
    TResult Function(AuthenticationAuthenticated value)? authenticated,
    TResult Function(AuthenticationFailure value)? failure,
    TResult Function(AuthenticationAuthChecked value)? authChecked,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class AuthenticationInitial implements AuthenticationState {
  const factory AuthenticationInitial() = _$AuthenticationInitialImpl;
}

/// @nodoc
abstract class _$$AuthenticationLoadingImplCopyWith<$Res> {
  factory _$$AuthenticationLoadingImplCopyWith(
          _$AuthenticationLoadingImpl value,
          $Res Function(_$AuthenticationLoadingImpl) then) =
      __$$AuthenticationLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthenticationLoadingImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res, _$AuthenticationLoadingImpl>
    implements _$$AuthenticationLoadingImplCopyWith<$Res> {
  __$$AuthenticationLoadingImplCopyWithImpl(_$AuthenticationLoadingImpl _value,
      $Res Function(_$AuthenticationLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AuthenticationLoadingImpl implements AuthenticationLoading {
  const _$AuthenticationLoadingImpl();

  @override
  String toString() {
    return 'AuthenticationState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) authenticated,
    required TResult Function(String errorMessage) failure,
    required TResult Function(bool isValid) authChecked,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String message)? authenticated,
    TResult? Function(String errorMessage)? failure,
    TResult? Function(bool isValid)? authChecked,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? authenticated,
    TResult Function(String errorMessage)? failure,
    TResult Function(bool isValid)? authChecked,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthenticationInitial value) initial,
    required TResult Function(AuthenticationLoading value) loading,
    required TResult Function(AuthenticationAuthenticated value) authenticated,
    required TResult Function(AuthenticationFailure value) failure,
    required TResult Function(AuthenticationAuthChecked value) authChecked,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthenticationInitial value)? initial,
    TResult? Function(AuthenticationLoading value)? loading,
    TResult? Function(AuthenticationAuthenticated value)? authenticated,
    TResult? Function(AuthenticationFailure value)? failure,
    TResult? Function(AuthenticationAuthChecked value)? authChecked,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthenticationInitial value)? initial,
    TResult Function(AuthenticationLoading value)? loading,
    TResult Function(AuthenticationAuthenticated value)? authenticated,
    TResult Function(AuthenticationFailure value)? failure,
    TResult Function(AuthenticationAuthChecked value)? authChecked,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class AuthenticationLoading implements AuthenticationState {
  const factory AuthenticationLoading() = _$AuthenticationLoadingImpl;
}

/// @nodoc
abstract class _$$AuthenticationAuthenticatedImplCopyWith<$Res> {
  factory _$$AuthenticationAuthenticatedImplCopyWith(
          _$AuthenticationAuthenticatedImpl value,
          $Res Function(_$AuthenticationAuthenticatedImpl) then) =
      __$$AuthenticationAuthenticatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$AuthenticationAuthenticatedImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res,
        _$AuthenticationAuthenticatedImpl>
    implements _$$AuthenticationAuthenticatedImplCopyWith<$Res> {
  __$$AuthenticationAuthenticatedImplCopyWithImpl(
      _$AuthenticationAuthenticatedImpl _value,
      $Res Function(_$AuthenticationAuthenticatedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$AuthenticationAuthenticatedImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AuthenticationAuthenticatedImpl implements AuthenticationAuthenticated {
  const _$AuthenticationAuthenticatedImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'AuthenticationState.authenticated(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationAuthenticatedImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticationAuthenticatedImplCopyWith<_$AuthenticationAuthenticatedImpl>
      get copyWith => __$$AuthenticationAuthenticatedImplCopyWithImpl<
          _$AuthenticationAuthenticatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) authenticated,
    required TResult Function(String errorMessage) failure,
    required TResult Function(bool isValid) authChecked,
  }) {
    return authenticated(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String message)? authenticated,
    TResult? Function(String errorMessage)? failure,
    TResult? Function(bool isValid)? authChecked,
  }) {
    return authenticated?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? authenticated,
    TResult Function(String errorMessage)? failure,
    TResult Function(bool isValid)? authChecked,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthenticationInitial value) initial,
    required TResult Function(AuthenticationLoading value) loading,
    required TResult Function(AuthenticationAuthenticated value) authenticated,
    required TResult Function(AuthenticationFailure value) failure,
    required TResult Function(AuthenticationAuthChecked value) authChecked,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthenticationInitial value)? initial,
    TResult? Function(AuthenticationLoading value)? loading,
    TResult? Function(AuthenticationAuthenticated value)? authenticated,
    TResult? Function(AuthenticationFailure value)? failure,
    TResult? Function(AuthenticationAuthChecked value)? authChecked,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthenticationInitial value)? initial,
    TResult Function(AuthenticationLoading value)? loading,
    TResult Function(AuthenticationAuthenticated value)? authenticated,
    TResult Function(AuthenticationFailure value)? failure,
    TResult Function(AuthenticationAuthChecked value)? authChecked,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class AuthenticationAuthenticated implements AuthenticationState {
  const factory AuthenticationAuthenticated(final String message) =
      _$AuthenticationAuthenticatedImpl;

  String get message;

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthenticationAuthenticatedImplCopyWith<_$AuthenticationAuthenticatedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthenticationFailureImplCopyWith<$Res> {
  factory _$$AuthenticationFailureImplCopyWith(
          _$AuthenticationFailureImpl value,
          $Res Function(_$AuthenticationFailureImpl) then) =
      __$$AuthenticationFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String errorMessage});
}

/// @nodoc
class __$$AuthenticationFailureImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res, _$AuthenticationFailureImpl>
    implements _$$AuthenticationFailureImplCopyWith<$Res> {
  __$$AuthenticationFailureImplCopyWithImpl(_$AuthenticationFailureImpl _value,
      $Res Function(_$AuthenticationFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorMessage = null,
  }) {
    return _then(_$AuthenticationFailureImpl(
      null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AuthenticationFailureImpl implements AuthenticationFailure {
  const _$AuthenticationFailureImpl(this.errorMessage);

  @override
  final String errorMessage;

  @override
  String toString() {
    return 'AuthenticationState.failure(errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationFailureImpl &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorMessage);

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticationFailureImplCopyWith<_$AuthenticationFailureImpl>
      get copyWith => __$$AuthenticationFailureImplCopyWithImpl<
          _$AuthenticationFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) authenticated,
    required TResult Function(String errorMessage) failure,
    required TResult Function(bool isValid) authChecked,
  }) {
    return failure(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String message)? authenticated,
    TResult? Function(String errorMessage)? failure,
    TResult? Function(bool isValid)? authChecked,
  }) {
    return failure?.call(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? authenticated,
    TResult Function(String errorMessage)? failure,
    TResult Function(bool isValid)? authChecked,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(errorMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthenticationInitial value) initial,
    required TResult Function(AuthenticationLoading value) loading,
    required TResult Function(AuthenticationAuthenticated value) authenticated,
    required TResult Function(AuthenticationFailure value) failure,
    required TResult Function(AuthenticationAuthChecked value) authChecked,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthenticationInitial value)? initial,
    TResult? Function(AuthenticationLoading value)? loading,
    TResult? Function(AuthenticationAuthenticated value)? authenticated,
    TResult? Function(AuthenticationFailure value)? failure,
    TResult? Function(AuthenticationAuthChecked value)? authChecked,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthenticationInitial value)? initial,
    TResult Function(AuthenticationLoading value)? loading,
    TResult Function(AuthenticationAuthenticated value)? authenticated,
    TResult Function(AuthenticationFailure value)? failure,
    TResult Function(AuthenticationAuthChecked value)? authChecked,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class AuthenticationFailure implements AuthenticationState {
  const factory AuthenticationFailure(final String errorMessage) =
      _$AuthenticationFailureImpl;

  String get errorMessage;

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthenticationFailureImplCopyWith<_$AuthenticationFailureImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthenticationAuthCheckedImplCopyWith<$Res> {
  factory _$$AuthenticationAuthCheckedImplCopyWith(
          _$AuthenticationAuthCheckedImpl value,
          $Res Function(_$AuthenticationAuthCheckedImpl) then) =
      __$$AuthenticationAuthCheckedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool isValid});
}

/// @nodoc
class __$$AuthenticationAuthCheckedImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res,
        _$AuthenticationAuthCheckedImpl>
    implements _$$AuthenticationAuthCheckedImplCopyWith<$Res> {
  __$$AuthenticationAuthCheckedImplCopyWithImpl(
      _$AuthenticationAuthCheckedImpl _value,
      $Res Function(_$AuthenticationAuthCheckedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isValid = null,
  }) {
    return _then(_$AuthenticationAuthCheckedImpl(
      null == isValid
          ? _value.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AuthenticationAuthCheckedImpl implements AuthenticationAuthChecked {
  const _$AuthenticationAuthCheckedImpl(this.isValid);

  @override
  final bool isValid;

  @override
  String toString() {
    return 'AuthenticationState.authChecked(isValid: $isValid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationAuthCheckedImpl &&
            (identical(other.isValid, isValid) || other.isValid == isValid));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isValid);

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticationAuthCheckedImplCopyWith<_$AuthenticationAuthCheckedImpl>
      get copyWith => __$$AuthenticationAuthCheckedImplCopyWithImpl<
          _$AuthenticationAuthCheckedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) authenticated,
    required TResult Function(String errorMessage) failure,
    required TResult Function(bool isValid) authChecked,
  }) {
    return authChecked(isValid);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String message)? authenticated,
    TResult? Function(String errorMessage)? failure,
    TResult? Function(bool isValid)? authChecked,
  }) {
    return authChecked?.call(isValid);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? authenticated,
    TResult Function(String errorMessage)? failure,
    TResult Function(bool isValid)? authChecked,
    required TResult orElse(),
  }) {
    if (authChecked != null) {
      return authChecked(isValid);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthenticationInitial value) initial,
    required TResult Function(AuthenticationLoading value) loading,
    required TResult Function(AuthenticationAuthenticated value) authenticated,
    required TResult Function(AuthenticationFailure value) failure,
    required TResult Function(AuthenticationAuthChecked value) authChecked,
  }) {
    return authChecked(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthenticationInitial value)? initial,
    TResult? Function(AuthenticationLoading value)? loading,
    TResult? Function(AuthenticationAuthenticated value)? authenticated,
    TResult? Function(AuthenticationFailure value)? failure,
    TResult? Function(AuthenticationAuthChecked value)? authChecked,
  }) {
    return authChecked?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthenticationInitial value)? initial,
    TResult Function(AuthenticationLoading value)? loading,
    TResult Function(AuthenticationAuthenticated value)? authenticated,
    TResult Function(AuthenticationFailure value)? failure,
    TResult Function(AuthenticationAuthChecked value)? authChecked,
    required TResult orElse(),
  }) {
    if (authChecked != null) {
      return authChecked(this);
    }
    return orElse();
  }
}

abstract class AuthenticationAuthChecked implements AuthenticationState {
  const factory AuthenticationAuthChecked(final bool isValid) =
      _$AuthenticationAuthCheckedImpl;

  bool get isValid;

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthenticationAuthCheckedImplCopyWith<_$AuthenticationAuthCheckedImpl>
      get copyWith => throw _privateConstructorUsedError;
}
