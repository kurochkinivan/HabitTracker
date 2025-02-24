// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'habits_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HabitsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(HabitActionType action) loading,
    required TResult Function(
            HabitActionType action,
            String? message,
            List<GetDaysResponse>? days,
            List<GetCategoriesResponse>? categories,
            List<GetHabitsResponse>? habits)
        success,
    required TResult Function(HabitActionType action, String errorMessage)
        failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(HabitActionType action)? loading,
    TResult? Function(
            HabitActionType action,
            String? message,
            List<GetDaysResponse>? days,
            List<GetCategoriesResponse>? categories,
            List<GetHabitsResponse>? habits)?
        success,
    TResult? Function(HabitActionType action, String errorMessage)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(HabitActionType action)? loading,
    TResult Function(
            HabitActionType action,
            String? message,
            List<GetDaysResponse>? days,
            List<GetCategoriesResponse>? categories,
            List<GetHabitsResponse>? habits)?
        success,
    TResult Function(HabitActionType action, String errorMessage)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HabitsInitial value) initial,
    required TResult Function(HabitsLoading value) loading,
    required TResult Function(HabitsSuccess value) success,
    required TResult Function(HabitsFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HabitsInitial value)? initial,
    TResult? Function(HabitsLoading value)? loading,
    TResult? Function(HabitsSuccess value)? success,
    TResult? Function(HabitsFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HabitsInitial value)? initial,
    TResult Function(HabitsLoading value)? loading,
    TResult Function(HabitsSuccess value)? success,
    TResult Function(HabitsFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HabitsStateCopyWith<$Res> {
  factory $HabitsStateCopyWith(
          HabitsState value, $Res Function(HabitsState) then) =
      _$HabitsStateCopyWithImpl<$Res, HabitsState>;
}

/// @nodoc
class _$HabitsStateCopyWithImpl<$Res, $Val extends HabitsState>
    implements $HabitsStateCopyWith<$Res> {
  _$HabitsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HabitsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$HabitsInitialImplCopyWith<$Res> {
  factory _$$HabitsInitialImplCopyWith(
          _$HabitsInitialImpl value, $Res Function(_$HabitsInitialImpl) then) =
      __$$HabitsInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$HabitsInitialImplCopyWithImpl<$Res>
    extends _$HabitsStateCopyWithImpl<$Res, _$HabitsInitialImpl>
    implements _$$HabitsInitialImplCopyWith<$Res> {
  __$$HabitsInitialImplCopyWithImpl(
      _$HabitsInitialImpl _value, $Res Function(_$HabitsInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of HabitsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$HabitsInitialImpl implements HabitsInitial {
  const _$HabitsInitialImpl();

  @override
  String toString() {
    return 'HabitsState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$HabitsInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(HabitActionType action) loading,
    required TResult Function(
            HabitActionType action,
            String? message,
            List<GetDaysResponse>? days,
            List<GetCategoriesResponse>? categories,
            List<GetHabitsResponse>? habits)
        success,
    required TResult Function(HabitActionType action, String errorMessage)
        failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(HabitActionType action)? loading,
    TResult? Function(
            HabitActionType action,
            String? message,
            List<GetDaysResponse>? days,
            List<GetCategoriesResponse>? categories,
            List<GetHabitsResponse>? habits)?
        success,
    TResult? Function(HabitActionType action, String errorMessage)? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(HabitActionType action)? loading,
    TResult Function(
            HabitActionType action,
            String? message,
            List<GetDaysResponse>? days,
            List<GetCategoriesResponse>? categories,
            List<GetHabitsResponse>? habits)?
        success,
    TResult Function(HabitActionType action, String errorMessage)? failure,
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
    required TResult Function(HabitsInitial value) initial,
    required TResult Function(HabitsLoading value) loading,
    required TResult Function(HabitsSuccess value) success,
    required TResult Function(HabitsFailure value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HabitsInitial value)? initial,
    TResult? Function(HabitsLoading value)? loading,
    TResult? Function(HabitsSuccess value)? success,
    TResult? Function(HabitsFailure value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HabitsInitial value)? initial,
    TResult Function(HabitsLoading value)? loading,
    TResult Function(HabitsSuccess value)? success,
    TResult Function(HabitsFailure value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class HabitsInitial implements HabitsState {
  const factory HabitsInitial() = _$HabitsInitialImpl;
}

/// @nodoc
abstract class _$$HabitsLoadingImplCopyWith<$Res> {
  factory _$$HabitsLoadingImplCopyWith(
          _$HabitsLoadingImpl value, $Res Function(_$HabitsLoadingImpl) then) =
      __$$HabitsLoadingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({HabitActionType action});
}

/// @nodoc
class __$$HabitsLoadingImplCopyWithImpl<$Res>
    extends _$HabitsStateCopyWithImpl<$Res, _$HabitsLoadingImpl>
    implements _$$HabitsLoadingImplCopyWith<$Res> {
  __$$HabitsLoadingImplCopyWithImpl(
      _$HabitsLoadingImpl _value, $Res Function(_$HabitsLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of HabitsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? action = null,
  }) {
    return _then(_$HabitsLoadingImpl(
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as HabitActionType,
    ));
  }
}

/// @nodoc

class _$HabitsLoadingImpl implements HabitsLoading {
  const _$HabitsLoadingImpl({required this.action});

  @override
  final HabitActionType action;

  @override
  String toString() {
    return 'HabitsState.loading(action: $action)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HabitsLoadingImpl &&
            (identical(other.action, action) || other.action == action));
  }

  @override
  int get hashCode => Object.hash(runtimeType, action);

  /// Create a copy of HabitsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HabitsLoadingImplCopyWith<_$HabitsLoadingImpl> get copyWith =>
      __$$HabitsLoadingImplCopyWithImpl<_$HabitsLoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(HabitActionType action) loading,
    required TResult Function(
            HabitActionType action,
            String? message,
            List<GetDaysResponse>? days,
            List<GetCategoriesResponse>? categories,
            List<GetHabitsResponse>? habits)
        success,
    required TResult Function(HabitActionType action, String errorMessage)
        failure,
  }) {
    return loading(action);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(HabitActionType action)? loading,
    TResult? Function(
            HabitActionType action,
            String? message,
            List<GetDaysResponse>? days,
            List<GetCategoriesResponse>? categories,
            List<GetHabitsResponse>? habits)?
        success,
    TResult? Function(HabitActionType action, String errorMessage)? failure,
  }) {
    return loading?.call(action);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(HabitActionType action)? loading,
    TResult Function(
            HabitActionType action,
            String? message,
            List<GetDaysResponse>? days,
            List<GetCategoriesResponse>? categories,
            List<GetHabitsResponse>? habits)?
        success,
    TResult Function(HabitActionType action, String errorMessage)? failure,
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
    required TResult Function(HabitsInitial value) initial,
    required TResult Function(HabitsLoading value) loading,
    required TResult Function(HabitsSuccess value) success,
    required TResult Function(HabitsFailure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HabitsInitial value)? initial,
    TResult? Function(HabitsLoading value)? loading,
    TResult? Function(HabitsSuccess value)? success,
    TResult? Function(HabitsFailure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HabitsInitial value)? initial,
    TResult Function(HabitsLoading value)? loading,
    TResult Function(HabitsSuccess value)? success,
    TResult Function(HabitsFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class HabitsLoading implements HabitsState {
  const factory HabitsLoading({required final HabitActionType action}) =
      _$HabitsLoadingImpl;

  HabitActionType get action;

  /// Create a copy of HabitsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HabitsLoadingImplCopyWith<_$HabitsLoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$HabitsSuccessImplCopyWith<$Res> {
  factory _$$HabitsSuccessImplCopyWith(
          _$HabitsSuccessImpl value, $Res Function(_$HabitsSuccessImpl) then) =
      __$$HabitsSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {HabitActionType action,
      String? message,
      List<GetDaysResponse>? days,
      List<GetCategoriesResponse>? categories,
      List<GetHabitsResponse>? habits});
}

/// @nodoc
class __$$HabitsSuccessImplCopyWithImpl<$Res>
    extends _$HabitsStateCopyWithImpl<$Res, _$HabitsSuccessImpl>
    implements _$$HabitsSuccessImplCopyWith<$Res> {
  __$$HabitsSuccessImplCopyWithImpl(
      _$HabitsSuccessImpl _value, $Res Function(_$HabitsSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of HabitsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? action = null,
    Object? message = freezed,
    Object? days = freezed,
    Object? categories = freezed,
    Object? habits = freezed,
  }) {
    return _then(_$HabitsSuccessImpl(
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as HabitActionType,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      days: freezed == days
          ? _value._days
          : days // ignore: cast_nullable_to_non_nullable
              as List<GetDaysResponse>?,
      categories: freezed == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<GetCategoriesResponse>?,
      habits: freezed == habits
          ? _value._habits
          : habits // ignore: cast_nullable_to_non_nullable
              as List<GetHabitsResponse>?,
    ));
  }
}

/// @nodoc

class _$HabitsSuccessImpl implements HabitsSuccess {
  const _$HabitsSuccessImpl(
      {required this.action,
      this.message,
      final List<GetDaysResponse>? days,
      final List<GetCategoriesResponse>? categories,
      final List<GetHabitsResponse>? habits})
      : _days = days,
        _categories = categories,
        _habits = habits;

  @override
  final HabitActionType action;
  @override
  final String? message;
  final List<GetDaysResponse>? _days;
  @override
  List<GetDaysResponse>? get days {
    final value = _days;
    if (value == null) return null;
    if (_days is EqualUnmodifiableListView) return _days;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<GetCategoriesResponse>? _categories;
  @override
  List<GetCategoriesResponse>? get categories {
    final value = _categories;
    if (value == null) return null;
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<GetHabitsResponse>? _habits;
  @override
  List<GetHabitsResponse>? get habits {
    final value = _habits;
    if (value == null) return null;
    if (_habits is EqualUnmodifiableListView) return _habits;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'HabitsState.success(action: $action, message: $message, days: $days, categories: $categories, habits: $habits)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HabitsSuccessImpl &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._days, _days) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            const DeepCollectionEquality().equals(other._habits, _habits));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      action,
      message,
      const DeepCollectionEquality().hash(_days),
      const DeepCollectionEquality().hash(_categories),
      const DeepCollectionEquality().hash(_habits));

  /// Create a copy of HabitsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HabitsSuccessImplCopyWith<_$HabitsSuccessImpl> get copyWith =>
      __$$HabitsSuccessImplCopyWithImpl<_$HabitsSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(HabitActionType action) loading,
    required TResult Function(
            HabitActionType action,
            String? message,
            List<GetDaysResponse>? days,
            List<GetCategoriesResponse>? categories,
            List<GetHabitsResponse>? habits)
        success,
    required TResult Function(HabitActionType action, String errorMessage)
        failure,
  }) {
    return success(action, message, days, categories, habits);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(HabitActionType action)? loading,
    TResult? Function(
            HabitActionType action,
            String? message,
            List<GetDaysResponse>? days,
            List<GetCategoriesResponse>? categories,
            List<GetHabitsResponse>? habits)?
        success,
    TResult? Function(HabitActionType action, String errorMessage)? failure,
  }) {
    return success?.call(action, message, days, categories, habits);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(HabitActionType action)? loading,
    TResult Function(
            HabitActionType action,
            String? message,
            List<GetDaysResponse>? days,
            List<GetCategoriesResponse>? categories,
            List<GetHabitsResponse>? habits)?
        success,
    TResult Function(HabitActionType action, String errorMessage)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(action, message, days, categories, habits);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HabitsInitial value) initial,
    required TResult Function(HabitsLoading value) loading,
    required TResult Function(HabitsSuccess value) success,
    required TResult Function(HabitsFailure value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HabitsInitial value)? initial,
    TResult? Function(HabitsLoading value)? loading,
    TResult? Function(HabitsSuccess value)? success,
    TResult? Function(HabitsFailure value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HabitsInitial value)? initial,
    TResult Function(HabitsLoading value)? loading,
    TResult Function(HabitsSuccess value)? success,
    TResult Function(HabitsFailure value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class HabitsSuccess implements HabitsState {
  const factory HabitsSuccess(
      {required final HabitActionType action,
      final String? message,
      final List<GetDaysResponse>? days,
      final List<GetCategoriesResponse>? categories,
      final List<GetHabitsResponse>? habits}) = _$HabitsSuccessImpl;

  HabitActionType get action;
  String? get message;
  List<GetDaysResponse>? get days;
  List<GetCategoriesResponse>? get categories;
  List<GetHabitsResponse>? get habits;

  /// Create a copy of HabitsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HabitsSuccessImplCopyWith<_$HabitsSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$HabitsFailureImplCopyWith<$Res> {
  factory _$$HabitsFailureImplCopyWith(
          _$HabitsFailureImpl value, $Res Function(_$HabitsFailureImpl) then) =
      __$$HabitsFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({HabitActionType action, String errorMessage});
}

/// @nodoc
class __$$HabitsFailureImplCopyWithImpl<$Res>
    extends _$HabitsStateCopyWithImpl<$Res, _$HabitsFailureImpl>
    implements _$$HabitsFailureImplCopyWith<$Res> {
  __$$HabitsFailureImplCopyWithImpl(
      _$HabitsFailureImpl _value, $Res Function(_$HabitsFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of HabitsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? action = null,
    Object? errorMessage = null,
  }) {
    return _then(_$HabitsFailureImpl(
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as HabitActionType,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$HabitsFailureImpl implements HabitsFailure {
  const _$HabitsFailureImpl({required this.action, required this.errorMessage});

  @override
  final HabitActionType action;
  @override
  final String errorMessage;

  @override
  String toString() {
    return 'HabitsState.failure(action: $action, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HabitsFailureImpl &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, action, errorMessage);

  /// Create a copy of HabitsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HabitsFailureImplCopyWith<_$HabitsFailureImpl> get copyWith =>
      __$$HabitsFailureImplCopyWithImpl<_$HabitsFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(HabitActionType action) loading,
    required TResult Function(
            HabitActionType action,
            String? message,
            List<GetDaysResponse>? days,
            List<GetCategoriesResponse>? categories,
            List<GetHabitsResponse>? habits)
        success,
    required TResult Function(HabitActionType action, String errorMessage)
        failure,
  }) {
    return failure(action, errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(HabitActionType action)? loading,
    TResult? Function(
            HabitActionType action,
            String? message,
            List<GetDaysResponse>? days,
            List<GetCategoriesResponse>? categories,
            List<GetHabitsResponse>? habits)?
        success,
    TResult? Function(HabitActionType action, String errorMessage)? failure,
  }) {
    return failure?.call(action, errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(HabitActionType action)? loading,
    TResult Function(
            HabitActionType action,
            String? message,
            List<GetDaysResponse>? days,
            List<GetCategoriesResponse>? categories,
            List<GetHabitsResponse>? habits)?
        success,
    TResult Function(HabitActionType action, String errorMessage)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(action, errorMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HabitsInitial value) initial,
    required TResult Function(HabitsLoading value) loading,
    required TResult Function(HabitsSuccess value) success,
    required TResult Function(HabitsFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HabitsInitial value)? initial,
    TResult? Function(HabitsLoading value)? loading,
    TResult? Function(HabitsSuccess value)? success,
    TResult? Function(HabitsFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HabitsInitial value)? initial,
    TResult Function(HabitsLoading value)? loading,
    TResult Function(HabitsSuccess value)? success,
    TResult Function(HabitsFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class HabitsFailure implements HabitsState {
  const factory HabitsFailure(
      {required final HabitActionType action,
      required final String errorMessage}) = _$HabitsFailureImpl;

  HabitActionType get action;
  String get errorMessage;

  /// Create a copy of HabitsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HabitsFailureImplCopyWith<_$HabitsFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
