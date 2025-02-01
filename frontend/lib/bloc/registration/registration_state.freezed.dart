// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'registration_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RegistrationState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(RegistrationActionType action) loading,
    required TResult Function(String message, RegistrationActionType action)
        success,
    required TResult Function(
            String errorMessage, RegistrationActionType action)
        failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(RegistrationActionType action)? loading,
    TResult? Function(String message, RegistrationActionType action)? success,
    TResult? Function(String errorMessage, RegistrationActionType action)?
        failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(RegistrationActionType action)? loading,
    TResult Function(String message, RegistrationActionType action)? success,
    TResult Function(String errorMessage, RegistrationActionType action)?
        failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RegistrationInitial value) initial,
    required TResult Function(RegistrationLoading value) loading,
    required TResult Function(RegistrationSuccess value) success,
    required TResult Function(RegistrationFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegistrationInitial value)? initial,
    TResult? Function(RegistrationLoading value)? loading,
    TResult? Function(RegistrationSuccess value)? success,
    TResult? Function(RegistrationFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegistrationInitial value)? initial,
    TResult Function(RegistrationLoading value)? loading,
    TResult Function(RegistrationSuccess value)? success,
    TResult Function(RegistrationFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegistrationStateCopyWith<$Res> {
  factory $RegistrationStateCopyWith(
          RegistrationState value, $Res Function(RegistrationState) then) =
      _$RegistrationStateCopyWithImpl<$Res, RegistrationState>;
}

/// @nodoc
class _$RegistrationStateCopyWithImpl<$Res, $Val extends RegistrationState>
    implements $RegistrationStateCopyWith<$Res> {
  _$RegistrationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RegistrationState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$RegistrationInitialImplCopyWith<$Res> {
  factory _$$RegistrationInitialImplCopyWith(_$RegistrationInitialImpl value,
          $Res Function(_$RegistrationInitialImpl) then) =
      __$$RegistrationInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RegistrationInitialImplCopyWithImpl<$Res>
    extends _$RegistrationStateCopyWithImpl<$Res, _$RegistrationInitialImpl>
    implements _$$RegistrationInitialImplCopyWith<$Res> {
  __$$RegistrationInitialImplCopyWithImpl(_$RegistrationInitialImpl _value,
      $Res Function(_$RegistrationInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegistrationState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RegistrationInitialImpl implements RegistrationInitial {
  const _$RegistrationInitialImpl();

  @override
  String toString() {
    return 'RegistrationState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegistrationInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(RegistrationActionType action) loading,
    required TResult Function(String message, RegistrationActionType action)
        success,
    required TResult Function(
            String errorMessage, RegistrationActionType action)
        failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(RegistrationActionType action)? loading,
    TResult? Function(String message, RegistrationActionType action)? success,
    TResult? Function(String errorMessage, RegistrationActionType action)?
        failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(RegistrationActionType action)? loading,
    TResult Function(String message, RegistrationActionType action)? success,
    TResult Function(String errorMessage, RegistrationActionType action)?
        failure,
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
    required TResult Function(RegistrationInitial value) initial,
    required TResult Function(RegistrationLoading value) loading,
    required TResult Function(RegistrationSuccess value) success,
    required TResult Function(RegistrationFailure value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegistrationInitial value)? initial,
    TResult? Function(RegistrationLoading value)? loading,
    TResult? Function(RegistrationSuccess value)? success,
    TResult? Function(RegistrationFailure value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegistrationInitial value)? initial,
    TResult Function(RegistrationLoading value)? loading,
    TResult Function(RegistrationSuccess value)? success,
    TResult Function(RegistrationFailure value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class RegistrationInitial implements RegistrationState {
  const factory RegistrationInitial() = _$RegistrationInitialImpl;
}

/// @nodoc
abstract class _$$RegistrationLoadingImplCopyWith<$Res> {
  factory _$$RegistrationLoadingImplCopyWith(_$RegistrationLoadingImpl value,
          $Res Function(_$RegistrationLoadingImpl) then) =
      __$$RegistrationLoadingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({RegistrationActionType action});
}

/// @nodoc
class __$$RegistrationLoadingImplCopyWithImpl<$Res>
    extends _$RegistrationStateCopyWithImpl<$Res, _$RegistrationLoadingImpl>
    implements _$$RegistrationLoadingImplCopyWith<$Res> {
  __$$RegistrationLoadingImplCopyWithImpl(_$RegistrationLoadingImpl _value,
      $Res Function(_$RegistrationLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegistrationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? action = null,
  }) {
    return _then(_$RegistrationLoadingImpl(
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as RegistrationActionType,
    ));
  }
}

/// @nodoc

class _$RegistrationLoadingImpl implements RegistrationLoading {
  const _$RegistrationLoadingImpl({required this.action});

  @override
  final RegistrationActionType action;

  @override
  String toString() {
    return 'RegistrationState.loading(action: $action)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegistrationLoadingImpl &&
            (identical(other.action, action) || other.action == action));
  }

  @override
  int get hashCode => Object.hash(runtimeType, action);

  /// Create a copy of RegistrationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegistrationLoadingImplCopyWith<_$RegistrationLoadingImpl> get copyWith =>
      __$$RegistrationLoadingImplCopyWithImpl<_$RegistrationLoadingImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(RegistrationActionType action) loading,
    required TResult Function(String message, RegistrationActionType action)
        success,
    required TResult Function(
            String errorMessage, RegistrationActionType action)
        failure,
  }) {
    return loading(action);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(RegistrationActionType action)? loading,
    TResult? Function(String message, RegistrationActionType action)? success,
    TResult? Function(String errorMessage, RegistrationActionType action)?
        failure,
  }) {
    return loading?.call(action);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(RegistrationActionType action)? loading,
    TResult Function(String message, RegistrationActionType action)? success,
    TResult Function(String errorMessage, RegistrationActionType action)?
        failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(action);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RegistrationInitial value) initial,
    required TResult Function(RegistrationLoading value) loading,
    required TResult Function(RegistrationSuccess value) success,
    required TResult Function(RegistrationFailure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegistrationInitial value)? initial,
    TResult? Function(RegistrationLoading value)? loading,
    TResult? Function(RegistrationSuccess value)? success,
    TResult? Function(RegistrationFailure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegistrationInitial value)? initial,
    TResult Function(RegistrationLoading value)? loading,
    TResult Function(RegistrationSuccess value)? success,
    TResult Function(RegistrationFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class RegistrationLoading implements RegistrationState {
  const factory RegistrationLoading(
          {required final RegistrationActionType action}) =
      _$RegistrationLoadingImpl;

  RegistrationActionType get action;

  /// Create a copy of RegistrationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegistrationLoadingImplCopyWith<_$RegistrationLoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RegistrationSuccessImplCopyWith<$Res> {
  factory _$$RegistrationSuccessImplCopyWith(_$RegistrationSuccessImpl value,
          $Res Function(_$RegistrationSuccessImpl) then) =
      __$$RegistrationSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message, RegistrationActionType action});
}

/// @nodoc
class __$$RegistrationSuccessImplCopyWithImpl<$Res>
    extends _$RegistrationStateCopyWithImpl<$Res, _$RegistrationSuccessImpl>
    implements _$$RegistrationSuccessImplCopyWith<$Res> {
  __$$RegistrationSuccessImplCopyWithImpl(_$RegistrationSuccessImpl _value,
      $Res Function(_$RegistrationSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegistrationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? action = null,
  }) {
    return _then(_$RegistrationSuccessImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as RegistrationActionType,
    ));
  }
}

/// @nodoc

class _$RegistrationSuccessImpl implements RegistrationSuccess {
  const _$RegistrationSuccessImpl(
      {required this.message, required this.action});

  @override
  final String message;
  @override
  final RegistrationActionType action;

  @override
  String toString() {
    return 'RegistrationState.success(message: $message, action: $action)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegistrationSuccessImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.action, action) || other.action == action));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, action);

  /// Create a copy of RegistrationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegistrationSuccessImplCopyWith<_$RegistrationSuccessImpl> get copyWith =>
      __$$RegistrationSuccessImplCopyWithImpl<_$RegistrationSuccessImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(RegistrationActionType action) loading,
    required TResult Function(String message, RegistrationActionType action)
        success,
    required TResult Function(
            String errorMessage, RegistrationActionType action)
        failure,
  }) {
    return success(message, action);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(RegistrationActionType action)? loading,
    TResult? Function(String message, RegistrationActionType action)? success,
    TResult? Function(String errorMessage, RegistrationActionType action)?
        failure,
  }) {
    return success?.call(message, action);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(RegistrationActionType action)? loading,
    TResult Function(String message, RegistrationActionType action)? success,
    TResult Function(String errorMessage, RegistrationActionType action)?
        failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(message, action);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RegistrationInitial value) initial,
    required TResult Function(RegistrationLoading value) loading,
    required TResult Function(RegistrationSuccess value) success,
    required TResult Function(RegistrationFailure value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegistrationInitial value)? initial,
    TResult? Function(RegistrationLoading value)? loading,
    TResult? Function(RegistrationSuccess value)? success,
    TResult? Function(RegistrationFailure value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegistrationInitial value)? initial,
    TResult Function(RegistrationLoading value)? loading,
    TResult Function(RegistrationSuccess value)? success,
    TResult Function(RegistrationFailure value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class RegistrationSuccess implements RegistrationState {
  const factory RegistrationSuccess(
          {required final String message,
          required final RegistrationActionType action}) =
      _$RegistrationSuccessImpl;

  String get message;
  RegistrationActionType get action;

  /// Create a copy of RegistrationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegistrationSuccessImplCopyWith<_$RegistrationSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RegistrationFailureImplCopyWith<$Res> {
  factory _$$RegistrationFailureImplCopyWith(_$RegistrationFailureImpl value,
          $Res Function(_$RegistrationFailureImpl) then) =
      __$$RegistrationFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String errorMessage, RegistrationActionType action});
}

/// @nodoc
class __$$RegistrationFailureImplCopyWithImpl<$Res>
    extends _$RegistrationStateCopyWithImpl<$Res, _$RegistrationFailureImpl>
    implements _$$RegistrationFailureImplCopyWith<$Res> {
  __$$RegistrationFailureImplCopyWithImpl(_$RegistrationFailureImpl _value,
      $Res Function(_$RegistrationFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegistrationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorMessage = null,
    Object? action = null,
  }) {
    return _then(_$RegistrationFailureImpl(
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as RegistrationActionType,
    ));
  }
}

/// @nodoc

class _$RegistrationFailureImpl implements RegistrationFailure {
  const _$RegistrationFailureImpl(
      {required this.errorMessage, required this.action});

  @override
  final String errorMessage;
  @override
  final RegistrationActionType action;

  @override
  String toString() {
    return 'RegistrationState.failure(errorMessage: $errorMessage, action: $action)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegistrationFailureImpl &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.action, action) || other.action == action));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorMessage, action);

  /// Create a copy of RegistrationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegistrationFailureImplCopyWith<_$RegistrationFailureImpl> get copyWith =>
      __$$RegistrationFailureImplCopyWithImpl<_$RegistrationFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(RegistrationActionType action) loading,
    required TResult Function(String message, RegistrationActionType action)
        success,
    required TResult Function(
            String errorMessage, RegistrationActionType action)
        failure,
  }) {
    return failure(errorMessage, action);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(RegistrationActionType action)? loading,
    TResult? Function(String message, RegistrationActionType action)? success,
    TResult? Function(String errorMessage, RegistrationActionType action)?
        failure,
  }) {
    return failure?.call(errorMessage, action);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(RegistrationActionType action)? loading,
    TResult Function(String message, RegistrationActionType action)? success,
    TResult Function(String errorMessage, RegistrationActionType action)?
        failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(errorMessage, action);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RegistrationInitial value) initial,
    required TResult Function(RegistrationLoading value) loading,
    required TResult Function(RegistrationSuccess value) success,
    required TResult Function(RegistrationFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegistrationInitial value)? initial,
    TResult? Function(RegistrationLoading value)? loading,
    TResult? Function(RegistrationSuccess value)? success,
    TResult? Function(RegistrationFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegistrationInitial value)? initial,
    TResult Function(RegistrationLoading value)? loading,
    TResult Function(RegistrationSuccess value)? success,
    TResult Function(RegistrationFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class RegistrationFailure implements RegistrationState {
  const factory RegistrationFailure(
          {required final String errorMessage,
          required final RegistrationActionType action}) =
      _$RegistrationFailureImpl;

  String get errorMessage;
  RegistrationActionType get action;

  /// Create a copy of RegistrationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegistrationFailureImplCopyWith<_$RegistrationFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
