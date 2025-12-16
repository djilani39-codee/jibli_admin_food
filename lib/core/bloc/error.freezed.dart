// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ErrorState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) networkError,
    required TResult Function() unAuthrized,
    required TResult Function(String message) other,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? networkError,
    TResult? Function()? unAuthrized,
    TResult? Function(String message)? other,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? networkError,
    TResult Function()? unAuthrized,
    TResult Function(String message)? other,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_networkError value) networkError,
    required TResult Function(_unAuthrized value) unAuthrized,
    required TResult Function(_other value) other,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_networkError value)? networkError,
    TResult? Function(_unAuthrized value)? unAuthrized,
    TResult? Function(_other value)? other,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_networkError value)? networkError,
    TResult Function(_unAuthrized value)? unAuthrized,
    TResult Function(_other value)? other,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ErrorStateCopyWith<$Res> {
  factory $ErrorStateCopyWith(
          ErrorState value, $Res Function(ErrorState) then) =
      _$ErrorStateCopyWithImpl<$Res, ErrorState>;
}

/// @nodoc
class _$ErrorStateCopyWithImpl<$Res, $Val extends ErrorState>
    implements $ErrorStateCopyWith<$Res> {
  _$ErrorStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ErrorState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$networkErrorImplCopyWith<$Res> {
  factory _$$networkErrorImplCopyWith(
          _$networkErrorImpl value, $Res Function(_$networkErrorImpl) then) =
      __$$networkErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$networkErrorImplCopyWithImpl<$Res>
    extends _$ErrorStateCopyWithImpl<$Res, _$networkErrorImpl>
    implements _$$networkErrorImplCopyWith<$Res> {
  __$$networkErrorImplCopyWithImpl(
      _$networkErrorImpl _value, $Res Function(_$networkErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of ErrorState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$networkErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$networkErrorImpl implements _networkError {
  const _$networkErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'ErrorState.networkError(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$networkErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of ErrorState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$networkErrorImplCopyWith<_$networkErrorImpl> get copyWith =>
      __$$networkErrorImplCopyWithImpl<_$networkErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) networkError,
    required TResult Function() unAuthrized,
    required TResult Function(String message) other,
  }) {
    return networkError(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? networkError,
    TResult? Function()? unAuthrized,
    TResult? Function(String message)? other,
  }) {
    return networkError?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? networkError,
    TResult Function()? unAuthrized,
    TResult Function(String message)? other,
    required TResult orElse(),
  }) {
    if (networkError != null) {
      return networkError(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_networkError value) networkError,
    required TResult Function(_unAuthrized value) unAuthrized,
    required TResult Function(_other value) other,
  }) {
    return networkError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_networkError value)? networkError,
    TResult? Function(_unAuthrized value)? unAuthrized,
    TResult? Function(_other value)? other,
  }) {
    return networkError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_networkError value)? networkError,
    TResult Function(_unAuthrized value)? unAuthrized,
    TResult Function(_other value)? other,
    required TResult orElse(),
  }) {
    if (networkError != null) {
      return networkError(this);
    }
    return orElse();
  }
}

abstract class _networkError implements ErrorState {
  const factory _networkError({required final String message}) =
      _$networkErrorImpl;

  String get message;

  /// Create a copy of ErrorState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$networkErrorImplCopyWith<_$networkErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$unAuthrizedImplCopyWith<$Res> {
  factory _$$unAuthrizedImplCopyWith(
          _$unAuthrizedImpl value, $Res Function(_$unAuthrizedImpl) then) =
      __$$unAuthrizedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$unAuthrizedImplCopyWithImpl<$Res>
    extends _$ErrorStateCopyWithImpl<$Res, _$unAuthrizedImpl>
    implements _$$unAuthrizedImplCopyWith<$Res> {
  __$$unAuthrizedImplCopyWithImpl(
      _$unAuthrizedImpl _value, $Res Function(_$unAuthrizedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ErrorState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$unAuthrizedImpl implements _unAuthrized {
  const _$unAuthrizedImpl();

  @override
  String toString() {
    return 'ErrorState.unAuthrized()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$unAuthrizedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) networkError,
    required TResult Function() unAuthrized,
    required TResult Function(String message) other,
  }) {
    return unAuthrized();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? networkError,
    TResult? Function()? unAuthrized,
    TResult? Function(String message)? other,
  }) {
    return unAuthrized?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? networkError,
    TResult Function()? unAuthrized,
    TResult Function(String message)? other,
    required TResult orElse(),
  }) {
    if (unAuthrized != null) {
      return unAuthrized();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_networkError value) networkError,
    required TResult Function(_unAuthrized value) unAuthrized,
    required TResult Function(_other value) other,
  }) {
    return unAuthrized(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_networkError value)? networkError,
    TResult? Function(_unAuthrized value)? unAuthrized,
    TResult? Function(_other value)? other,
  }) {
    return unAuthrized?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_networkError value)? networkError,
    TResult Function(_unAuthrized value)? unAuthrized,
    TResult Function(_other value)? other,
    required TResult orElse(),
  }) {
    if (unAuthrized != null) {
      return unAuthrized(this);
    }
    return orElse();
  }
}

abstract class _unAuthrized implements ErrorState {
  const factory _unAuthrized() = _$unAuthrizedImpl;
}

/// @nodoc
abstract class _$$otherImplCopyWith<$Res> {
  factory _$$otherImplCopyWith(
          _$otherImpl value, $Res Function(_$otherImpl) then) =
      __$$otherImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$otherImplCopyWithImpl<$Res>
    extends _$ErrorStateCopyWithImpl<$Res, _$otherImpl>
    implements _$$otherImplCopyWith<$Res> {
  __$$otherImplCopyWithImpl(
      _$otherImpl _value, $Res Function(_$otherImpl) _then)
      : super(_value, _then);

  /// Create a copy of ErrorState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$otherImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$otherImpl implements _other {
  const _$otherImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'ErrorState.other(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$otherImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of ErrorState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$otherImplCopyWith<_$otherImpl> get copyWith =>
      __$$otherImplCopyWithImpl<_$otherImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) networkError,
    required TResult Function() unAuthrized,
    required TResult Function(String message) other,
  }) {
    return other(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? networkError,
    TResult? Function()? unAuthrized,
    TResult? Function(String message)? other,
  }) {
    return other?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? networkError,
    TResult Function()? unAuthrized,
    TResult Function(String message)? other,
    required TResult orElse(),
  }) {
    if (other != null) {
      return other(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_networkError value) networkError,
    required TResult Function(_unAuthrized value) unAuthrized,
    required TResult Function(_other value) other,
  }) {
    return other(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_networkError value)? networkError,
    TResult? Function(_unAuthrized value)? unAuthrized,
    TResult? Function(_other value)? other,
  }) {
    return other?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_networkError value)? networkError,
    TResult Function(_unAuthrized value)? unAuthrized,
    TResult Function(_other value)? other,
    required TResult orElse(),
  }) {
    if (other != null) {
      return other(this);
    }
    return orElse();
  }
}

abstract class _other implements ErrorState {
  const factory _other({required final String message}) = _$otherImpl;

  String get message;

  /// Create a copy of ErrorState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$otherImplCopyWith<_$otherImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
