// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exceptions.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Exceptions {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) network,
    required TResult Function(dynamic data) empty,
    required TResult Function(dynamic data) other,
    required TResult Function(dynamic data) emailInvalude,
    required TResult Function(dynamic data) passwordInvalude,
    required TResult Function(dynamic data) locationServiceNotEnabled,
    required TResult Function(String data) invalidConfirmationCode,
    required TResult Function(dynamic data) wrongCredentials,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? network,
    TResult? Function(dynamic data)? empty,
    TResult? Function(dynamic data)? other,
    TResult? Function(dynamic data)? emailInvalude,
    TResult? Function(dynamic data)? passwordInvalude,
    TResult? Function(dynamic data)? locationServiceNotEnabled,
    TResult? Function(String data)? invalidConfirmationCode,
    TResult? Function(dynamic data)? wrongCredentials,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? network,
    TResult Function(dynamic data)? empty,
    TResult Function(dynamic data)? other,
    TResult Function(dynamic data)? emailInvalude,
    TResult Function(dynamic data)? passwordInvalude,
    TResult Function(dynamic data)? locationServiceNotEnabled,
    TResult Function(String data)? invalidConfirmationCode,
    TResult Function(dynamic data)? wrongCredentials,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkException value) network,
    required TResult Function(EmptyException value) empty,
    required TResult Function(OtherException value) other,
    required TResult Function(EmailInvalude value) emailInvalude,
    required TResult Function(PasswordInvalude value) passwordInvalude,
    required TResult Function(LocationServiceNotEnabled value)
        locationServiceNotEnabled,
    required TResult Function(InvalidConfirmationCode value)
        invalidConfirmationCode,
    required TResult Function(WrongCredentialsException value) wrongCredentials,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkException value)? network,
    TResult? Function(EmptyException value)? empty,
    TResult? Function(OtherException value)? other,
    TResult? Function(EmailInvalude value)? emailInvalude,
    TResult? Function(PasswordInvalude value)? passwordInvalude,
    TResult? Function(LocationServiceNotEnabled value)?
        locationServiceNotEnabled,
    TResult? Function(InvalidConfirmationCode value)? invalidConfirmationCode,
    TResult? Function(WrongCredentialsException value)? wrongCredentials,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkException value)? network,
    TResult Function(EmptyException value)? empty,
    TResult Function(OtherException value)? other,
    TResult Function(EmailInvalude value)? emailInvalude,
    TResult Function(PasswordInvalude value)? passwordInvalude,
    TResult Function(LocationServiceNotEnabled value)?
        locationServiceNotEnabled,
    TResult Function(InvalidConfirmationCode value)? invalidConfirmationCode,
    TResult Function(WrongCredentialsException value)? wrongCredentials,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExceptionsCopyWith<$Res> {
  factory $ExceptionsCopyWith(
          Exceptions value, $Res Function(Exceptions) then) =
      _$ExceptionsCopyWithImpl<$Res, Exceptions>;
}

/// @nodoc
class _$ExceptionsCopyWithImpl<$Res, $Val extends Exceptions>
    implements $ExceptionsCopyWith<$Res> {
  _$ExceptionsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Exceptions
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$NetworkExceptionImplCopyWith<$Res> {
  factory _$$NetworkExceptionImplCopyWith(_$NetworkExceptionImpl value,
          $Res Function(_$NetworkExceptionImpl) then) =
      __$$NetworkExceptionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$NetworkExceptionImplCopyWithImpl<$Res>
    extends _$ExceptionsCopyWithImpl<$Res, _$NetworkExceptionImpl>
    implements _$$NetworkExceptionImplCopyWith<$Res> {
  __$$NetworkExceptionImplCopyWithImpl(_$NetworkExceptionImpl _value,
      $Res Function(_$NetworkExceptionImpl) _then)
      : super(_value, _then);

  /// Create a copy of Exceptions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$NetworkExceptionImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$NetworkExceptionImpl extends NetworkException {
  const _$NetworkExceptionImpl(this.message) : super._();

  @override
  final String message;

  @override
  String toString() {
    return 'Exceptions.network(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NetworkExceptionImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of Exceptions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NetworkExceptionImplCopyWith<_$NetworkExceptionImpl> get copyWith =>
      __$$NetworkExceptionImplCopyWithImpl<_$NetworkExceptionImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) network,
    required TResult Function(dynamic data) empty,
    required TResult Function(dynamic data) other,
    required TResult Function(dynamic data) emailInvalude,
    required TResult Function(dynamic data) passwordInvalude,
    required TResult Function(dynamic data) locationServiceNotEnabled,
    required TResult Function(String data) invalidConfirmationCode,
    required TResult Function(dynamic data) wrongCredentials,
  }) {
    return network(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? network,
    TResult? Function(dynamic data)? empty,
    TResult? Function(dynamic data)? other,
    TResult? Function(dynamic data)? emailInvalude,
    TResult? Function(dynamic data)? passwordInvalude,
    TResult? Function(dynamic data)? locationServiceNotEnabled,
    TResult? Function(String data)? invalidConfirmationCode,
    TResult? Function(dynamic data)? wrongCredentials,
  }) {
    return network?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? network,
    TResult Function(dynamic data)? empty,
    TResult Function(dynamic data)? other,
    TResult Function(dynamic data)? emailInvalude,
    TResult Function(dynamic data)? passwordInvalude,
    TResult Function(dynamic data)? locationServiceNotEnabled,
    TResult Function(String data)? invalidConfirmationCode,
    TResult Function(dynamic data)? wrongCredentials,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkException value) network,
    required TResult Function(EmptyException value) empty,
    required TResult Function(OtherException value) other,
    required TResult Function(EmailInvalude value) emailInvalude,
    required TResult Function(PasswordInvalude value) passwordInvalude,
    required TResult Function(LocationServiceNotEnabled value)
        locationServiceNotEnabled,
    required TResult Function(InvalidConfirmationCode value)
        invalidConfirmationCode,
    required TResult Function(WrongCredentialsException value) wrongCredentials,
  }) {
    return network(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkException value)? network,
    TResult? Function(EmptyException value)? empty,
    TResult? Function(OtherException value)? other,
    TResult? Function(EmailInvalude value)? emailInvalude,
    TResult? Function(PasswordInvalude value)? passwordInvalude,
    TResult? Function(LocationServiceNotEnabled value)?
        locationServiceNotEnabled,
    TResult? Function(InvalidConfirmationCode value)? invalidConfirmationCode,
    TResult? Function(WrongCredentialsException value)? wrongCredentials,
  }) {
    return network?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkException value)? network,
    TResult Function(EmptyException value)? empty,
    TResult Function(OtherException value)? other,
    TResult Function(EmailInvalude value)? emailInvalude,
    TResult Function(PasswordInvalude value)? passwordInvalude,
    TResult Function(LocationServiceNotEnabled value)?
        locationServiceNotEnabled,
    TResult Function(InvalidConfirmationCode value)? invalidConfirmationCode,
    TResult Function(WrongCredentialsException value)? wrongCredentials,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(this);
    }
    return orElse();
  }
}

abstract class NetworkException extends Exceptions {
  const factory NetworkException(final String message) = _$NetworkExceptionImpl;
  const NetworkException._() : super._();

  String get message;

  /// Create a copy of Exceptions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NetworkExceptionImplCopyWith<_$NetworkExceptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EmptyExceptionImplCopyWith<$Res> {
  factory _$$EmptyExceptionImplCopyWith(_$EmptyExceptionImpl value,
          $Res Function(_$EmptyExceptionImpl) then) =
      __$$EmptyExceptionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({dynamic data});
}

/// @nodoc
class __$$EmptyExceptionImplCopyWithImpl<$Res>
    extends _$ExceptionsCopyWithImpl<$Res, _$EmptyExceptionImpl>
    implements _$$EmptyExceptionImplCopyWith<$Res> {
  __$$EmptyExceptionImplCopyWithImpl(
      _$EmptyExceptionImpl _value, $Res Function(_$EmptyExceptionImpl) _then)
      : super(_value, _then);

  /// Create a copy of Exceptions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$EmptyExceptionImpl(
      freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$EmptyExceptionImpl extends EmptyException {
  const _$EmptyExceptionImpl(this.data) : super._();

  @override
  final dynamic data;

  @override
  String toString() {
    return 'Exceptions.empty(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmptyExceptionImpl &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  /// Create a copy of Exceptions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmptyExceptionImplCopyWith<_$EmptyExceptionImpl> get copyWith =>
      __$$EmptyExceptionImplCopyWithImpl<_$EmptyExceptionImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) network,
    required TResult Function(dynamic data) empty,
    required TResult Function(dynamic data) other,
    required TResult Function(dynamic data) emailInvalude,
    required TResult Function(dynamic data) passwordInvalude,
    required TResult Function(dynamic data) locationServiceNotEnabled,
    required TResult Function(String data) invalidConfirmationCode,
    required TResult Function(dynamic data) wrongCredentials,
  }) {
    return empty(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? network,
    TResult? Function(dynamic data)? empty,
    TResult? Function(dynamic data)? other,
    TResult? Function(dynamic data)? emailInvalude,
    TResult? Function(dynamic data)? passwordInvalude,
    TResult? Function(dynamic data)? locationServiceNotEnabled,
    TResult? Function(String data)? invalidConfirmationCode,
    TResult? Function(dynamic data)? wrongCredentials,
  }) {
    return empty?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? network,
    TResult Function(dynamic data)? empty,
    TResult Function(dynamic data)? other,
    TResult Function(dynamic data)? emailInvalude,
    TResult Function(dynamic data)? passwordInvalude,
    TResult Function(dynamic data)? locationServiceNotEnabled,
    TResult Function(String data)? invalidConfirmationCode,
    TResult Function(dynamic data)? wrongCredentials,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkException value) network,
    required TResult Function(EmptyException value) empty,
    required TResult Function(OtherException value) other,
    required TResult Function(EmailInvalude value) emailInvalude,
    required TResult Function(PasswordInvalude value) passwordInvalude,
    required TResult Function(LocationServiceNotEnabled value)
        locationServiceNotEnabled,
    required TResult Function(InvalidConfirmationCode value)
        invalidConfirmationCode,
    required TResult Function(WrongCredentialsException value) wrongCredentials,
  }) {
    return empty(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkException value)? network,
    TResult? Function(EmptyException value)? empty,
    TResult? Function(OtherException value)? other,
    TResult? Function(EmailInvalude value)? emailInvalude,
    TResult? Function(PasswordInvalude value)? passwordInvalude,
    TResult? Function(LocationServiceNotEnabled value)?
        locationServiceNotEnabled,
    TResult? Function(InvalidConfirmationCode value)? invalidConfirmationCode,
    TResult? Function(WrongCredentialsException value)? wrongCredentials,
  }) {
    return empty?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkException value)? network,
    TResult Function(EmptyException value)? empty,
    TResult Function(OtherException value)? other,
    TResult Function(EmailInvalude value)? emailInvalude,
    TResult Function(PasswordInvalude value)? passwordInvalude,
    TResult Function(LocationServiceNotEnabled value)?
        locationServiceNotEnabled,
    TResult Function(InvalidConfirmationCode value)? invalidConfirmationCode,
    TResult Function(WrongCredentialsException value)? wrongCredentials,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(this);
    }
    return orElse();
  }
}

abstract class EmptyException extends Exceptions {
  const factory EmptyException(final dynamic data) = _$EmptyExceptionImpl;
  const EmptyException._() : super._();

  dynamic get data;

  /// Create a copy of Exceptions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmptyExceptionImplCopyWith<_$EmptyExceptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OtherExceptionImplCopyWith<$Res> {
  factory _$$OtherExceptionImplCopyWith(_$OtherExceptionImpl value,
          $Res Function(_$OtherExceptionImpl) then) =
      __$$OtherExceptionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({dynamic data});
}

/// @nodoc
class __$$OtherExceptionImplCopyWithImpl<$Res>
    extends _$ExceptionsCopyWithImpl<$Res, _$OtherExceptionImpl>
    implements _$$OtherExceptionImplCopyWith<$Res> {
  __$$OtherExceptionImplCopyWithImpl(
      _$OtherExceptionImpl _value, $Res Function(_$OtherExceptionImpl) _then)
      : super(_value, _then);

  /// Create a copy of Exceptions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$OtherExceptionImpl(
      freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$OtherExceptionImpl extends OtherException {
  const _$OtherExceptionImpl(this.data) : super._();

  @override
  final dynamic data;

  @override
  String toString() {
    return 'Exceptions.other(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtherExceptionImpl &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  /// Create a copy of Exceptions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OtherExceptionImplCopyWith<_$OtherExceptionImpl> get copyWith =>
      __$$OtherExceptionImplCopyWithImpl<_$OtherExceptionImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) network,
    required TResult Function(dynamic data) empty,
    required TResult Function(dynamic data) other,
    required TResult Function(dynamic data) emailInvalude,
    required TResult Function(dynamic data) passwordInvalude,
    required TResult Function(dynamic data) locationServiceNotEnabled,
    required TResult Function(String data) invalidConfirmationCode,
    required TResult Function(dynamic data) wrongCredentials,
  }) {
    return other(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? network,
    TResult? Function(dynamic data)? empty,
    TResult? Function(dynamic data)? other,
    TResult? Function(dynamic data)? emailInvalude,
    TResult? Function(dynamic data)? passwordInvalude,
    TResult? Function(dynamic data)? locationServiceNotEnabled,
    TResult? Function(String data)? invalidConfirmationCode,
    TResult? Function(dynamic data)? wrongCredentials,
  }) {
    return other?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? network,
    TResult Function(dynamic data)? empty,
    TResult Function(dynamic data)? other,
    TResult Function(dynamic data)? emailInvalude,
    TResult Function(dynamic data)? passwordInvalude,
    TResult Function(dynamic data)? locationServiceNotEnabled,
    TResult Function(String data)? invalidConfirmationCode,
    TResult Function(dynamic data)? wrongCredentials,
    required TResult orElse(),
  }) {
    if (other != null) {
      return other(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkException value) network,
    required TResult Function(EmptyException value) empty,
    required TResult Function(OtherException value) other,
    required TResult Function(EmailInvalude value) emailInvalude,
    required TResult Function(PasswordInvalude value) passwordInvalude,
    required TResult Function(LocationServiceNotEnabled value)
        locationServiceNotEnabled,
    required TResult Function(InvalidConfirmationCode value)
        invalidConfirmationCode,
    required TResult Function(WrongCredentialsException value) wrongCredentials,
  }) {
    return other(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkException value)? network,
    TResult? Function(EmptyException value)? empty,
    TResult? Function(OtherException value)? other,
    TResult? Function(EmailInvalude value)? emailInvalude,
    TResult? Function(PasswordInvalude value)? passwordInvalude,
    TResult? Function(LocationServiceNotEnabled value)?
        locationServiceNotEnabled,
    TResult? Function(InvalidConfirmationCode value)? invalidConfirmationCode,
    TResult? Function(WrongCredentialsException value)? wrongCredentials,
  }) {
    return other?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkException value)? network,
    TResult Function(EmptyException value)? empty,
    TResult Function(OtherException value)? other,
    TResult Function(EmailInvalude value)? emailInvalude,
    TResult Function(PasswordInvalude value)? passwordInvalude,
    TResult Function(LocationServiceNotEnabled value)?
        locationServiceNotEnabled,
    TResult Function(InvalidConfirmationCode value)? invalidConfirmationCode,
    TResult Function(WrongCredentialsException value)? wrongCredentials,
    required TResult orElse(),
  }) {
    if (other != null) {
      return other(this);
    }
    return orElse();
  }
}

abstract class OtherException extends Exceptions {
  const factory OtherException(final dynamic data) = _$OtherExceptionImpl;
  const OtherException._() : super._();

  dynamic get data;

  /// Create a copy of Exceptions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OtherExceptionImplCopyWith<_$OtherExceptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EmailInvaludeImplCopyWith<$Res> {
  factory _$$EmailInvaludeImplCopyWith(
          _$EmailInvaludeImpl value, $Res Function(_$EmailInvaludeImpl) then) =
      __$$EmailInvaludeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({dynamic data});
}

/// @nodoc
class __$$EmailInvaludeImplCopyWithImpl<$Res>
    extends _$ExceptionsCopyWithImpl<$Res, _$EmailInvaludeImpl>
    implements _$$EmailInvaludeImplCopyWith<$Res> {
  __$$EmailInvaludeImplCopyWithImpl(
      _$EmailInvaludeImpl _value, $Res Function(_$EmailInvaludeImpl) _then)
      : super(_value, _then);

  /// Create a copy of Exceptions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$EmailInvaludeImpl(
      freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$EmailInvaludeImpl extends EmailInvalude {
  const _$EmailInvaludeImpl(this.data) : super._();

  @override
  final dynamic data;

  @override
  String toString() {
    return 'Exceptions.emailInvalude(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmailInvaludeImpl &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  /// Create a copy of Exceptions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmailInvaludeImplCopyWith<_$EmailInvaludeImpl> get copyWith =>
      __$$EmailInvaludeImplCopyWithImpl<_$EmailInvaludeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) network,
    required TResult Function(dynamic data) empty,
    required TResult Function(dynamic data) other,
    required TResult Function(dynamic data) emailInvalude,
    required TResult Function(dynamic data) passwordInvalude,
    required TResult Function(dynamic data) locationServiceNotEnabled,
    required TResult Function(String data) invalidConfirmationCode,
    required TResult Function(dynamic data) wrongCredentials,
  }) {
    return emailInvalude(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? network,
    TResult? Function(dynamic data)? empty,
    TResult? Function(dynamic data)? other,
    TResult? Function(dynamic data)? emailInvalude,
    TResult? Function(dynamic data)? passwordInvalude,
    TResult? Function(dynamic data)? locationServiceNotEnabled,
    TResult? Function(String data)? invalidConfirmationCode,
    TResult? Function(dynamic data)? wrongCredentials,
  }) {
    return emailInvalude?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? network,
    TResult Function(dynamic data)? empty,
    TResult Function(dynamic data)? other,
    TResult Function(dynamic data)? emailInvalude,
    TResult Function(dynamic data)? passwordInvalude,
    TResult Function(dynamic data)? locationServiceNotEnabled,
    TResult Function(String data)? invalidConfirmationCode,
    TResult Function(dynamic data)? wrongCredentials,
    required TResult orElse(),
  }) {
    if (emailInvalude != null) {
      return emailInvalude(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkException value) network,
    required TResult Function(EmptyException value) empty,
    required TResult Function(OtherException value) other,
    required TResult Function(EmailInvalude value) emailInvalude,
    required TResult Function(PasswordInvalude value) passwordInvalude,
    required TResult Function(LocationServiceNotEnabled value)
        locationServiceNotEnabled,
    required TResult Function(InvalidConfirmationCode value)
        invalidConfirmationCode,
    required TResult Function(WrongCredentialsException value) wrongCredentials,
  }) {
    return emailInvalude(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkException value)? network,
    TResult? Function(EmptyException value)? empty,
    TResult? Function(OtherException value)? other,
    TResult? Function(EmailInvalude value)? emailInvalude,
    TResult? Function(PasswordInvalude value)? passwordInvalude,
    TResult? Function(LocationServiceNotEnabled value)?
        locationServiceNotEnabled,
    TResult? Function(InvalidConfirmationCode value)? invalidConfirmationCode,
    TResult? Function(WrongCredentialsException value)? wrongCredentials,
  }) {
    return emailInvalude?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkException value)? network,
    TResult Function(EmptyException value)? empty,
    TResult Function(OtherException value)? other,
    TResult Function(EmailInvalude value)? emailInvalude,
    TResult Function(PasswordInvalude value)? passwordInvalude,
    TResult Function(LocationServiceNotEnabled value)?
        locationServiceNotEnabled,
    TResult Function(InvalidConfirmationCode value)? invalidConfirmationCode,
    TResult Function(WrongCredentialsException value)? wrongCredentials,
    required TResult orElse(),
  }) {
    if (emailInvalude != null) {
      return emailInvalude(this);
    }
    return orElse();
  }
}

abstract class EmailInvalude extends Exceptions {
  const factory EmailInvalude(final dynamic data) = _$EmailInvaludeImpl;
  const EmailInvalude._() : super._();

  dynamic get data;

  /// Create a copy of Exceptions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmailInvaludeImplCopyWith<_$EmailInvaludeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PasswordInvaludeImplCopyWith<$Res> {
  factory _$$PasswordInvaludeImplCopyWith(_$PasswordInvaludeImpl value,
          $Res Function(_$PasswordInvaludeImpl) then) =
      __$$PasswordInvaludeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({dynamic data});
}

/// @nodoc
class __$$PasswordInvaludeImplCopyWithImpl<$Res>
    extends _$ExceptionsCopyWithImpl<$Res, _$PasswordInvaludeImpl>
    implements _$$PasswordInvaludeImplCopyWith<$Res> {
  __$$PasswordInvaludeImplCopyWithImpl(_$PasswordInvaludeImpl _value,
      $Res Function(_$PasswordInvaludeImpl) _then)
      : super(_value, _then);

  /// Create a copy of Exceptions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$PasswordInvaludeImpl(
      freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$PasswordInvaludeImpl extends PasswordInvalude {
  const _$PasswordInvaludeImpl(this.data) : super._();

  @override
  final dynamic data;

  @override
  String toString() {
    return 'Exceptions.passwordInvalude(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PasswordInvaludeImpl &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  /// Create a copy of Exceptions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PasswordInvaludeImplCopyWith<_$PasswordInvaludeImpl> get copyWith =>
      __$$PasswordInvaludeImplCopyWithImpl<_$PasswordInvaludeImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) network,
    required TResult Function(dynamic data) empty,
    required TResult Function(dynamic data) other,
    required TResult Function(dynamic data) emailInvalude,
    required TResult Function(dynamic data) passwordInvalude,
    required TResult Function(dynamic data) locationServiceNotEnabled,
    required TResult Function(String data) invalidConfirmationCode,
    required TResult Function(dynamic data) wrongCredentials,
  }) {
    return passwordInvalude(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? network,
    TResult? Function(dynamic data)? empty,
    TResult? Function(dynamic data)? other,
    TResult? Function(dynamic data)? emailInvalude,
    TResult? Function(dynamic data)? passwordInvalude,
    TResult? Function(dynamic data)? locationServiceNotEnabled,
    TResult? Function(String data)? invalidConfirmationCode,
    TResult? Function(dynamic data)? wrongCredentials,
  }) {
    return passwordInvalude?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? network,
    TResult Function(dynamic data)? empty,
    TResult Function(dynamic data)? other,
    TResult Function(dynamic data)? emailInvalude,
    TResult Function(dynamic data)? passwordInvalude,
    TResult Function(dynamic data)? locationServiceNotEnabled,
    TResult Function(String data)? invalidConfirmationCode,
    TResult Function(dynamic data)? wrongCredentials,
    required TResult orElse(),
  }) {
    if (passwordInvalude != null) {
      return passwordInvalude(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkException value) network,
    required TResult Function(EmptyException value) empty,
    required TResult Function(OtherException value) other,
    required TResult Function(EmailInvalude value) emailInvalude,
    required TResult Function(PasswordInvalude value) passwordInvalude,
    required TResult Function(LocationServiceNotEnabled value)
        locationServiceNotEnabled,
    required TResult Function(InvalidConfirmationCode value)
        invalidConfirmationCode,
    required TResult Function(WrongCredentialsException value) wrongCredentials,
  }) {
    return passwordInvalude(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkException value)? network,
    TResult? Function(EmptyException value)? empty,
    TResult? Function(OtherException value)? other,
    TResult? Function(EmailInvalude value)? emailInvalude,
    TResult? Function(PasswordInvalude value)? passwordInvalude,
    TResult? Function(LocationServiceNotEnabled value)?
        locationServiceNotEnabled,
    TResult? Function(InvalidConfirmationCode value)? invalidConfirmationCode,
    TResult? Function(WrongCredentialsException value)? wrongCredentials,
  }) {
    return passwordInvalude?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkException value)? network,
    TResult Function(EmptyException value)? empty,
    TResult Function(OtherException value)? other,
    TResult Function(EmailInvalude value)? emailInvalude,
    TResult Function(PasswordInvalude value)? passwordInvalude,
    TResult Function(LocationServiceNotEnabled value)?
        locationServiceNotEnabled,
    TResult Function(InvalidConfirmationCode value)? invalidConfirmationCode,
    TResult Function(WrongCredentialsException value)? wrongCredentials,
    required TResult orElse(),
  }) {
    if (passwordInvalude != null) {
      return passwordInvalude(this);
    }
    return orElse();
  }
}

abstract class PasswordInvalude extends Exceptions {
  const factory PasswordInvalude(final dynamic data) = _$PasswordInvaludeImpl;
  const PasswordInvalude._() : super._();

  dynamic get data;

  /// Create a copy of Exceptions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PasswordInvaludeImplCopyWith<_$PasswordInvaludeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LocationServiceNotEnabledImplCopyWith<$Res> {
  factory _$$LocationServiceNotEnabledImplCopyWith(
          _$LocationServiceNotEnabledImpl value,
          $Res Function(_$LocationServiceNotEnabledImpl) then) =
      __$$LocationServiceNotEnabledImplCopyWithImpl<$Res>;
  @useResult
  $Res call({dynamic data});
}

/// @nodoc
class __$$LocationServiceNotEnabledImplCopyWithImpl<$Res>
    extends _$ExceptionsCopyWithImpl<$Res, _$LocationServiceNotEnabledImpl>
    implements _$$LocationServiceNotEnabledImplCopyWith<$Res> {
  __$$LocationServiceNotEnabledImplCopyWithImpl(
      _$LocationServiceNotEnabledImpl _value,
      $Res Function(_$LocationServiceNotEnabledImpl) _then)
      : super(_value, _then);

  /// Create a copy of Exceptions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$LocationServiceNotEnabledImpl(
      freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$LocationServiceNotEnabledImpl extends LocationServiceNotEnabled {
  const _$LocationServiceNotEnabledImpl(this.data) : super._();

  @override
  final dynamic data;

  @override
  String toString() {
    return 'Exceptions.locationServiceNotEnabled(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationServiceNotEnabledImpl &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  /// Create a copy of Exceptions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationServiceNotEnabledImplCopyWith<_$LocationServiceNotEnabledImpl>
      get copyWith => __$$LocationServiceNotEnabledImplCopyWithImpl<
          _$LocationServiceNotEnabledImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) network,
    required TResult Function(dynamic data) empty,
    required TResult Function(dynamic data) other,
    required TResult Function(dynamic data) emailInvalude,
    required TResult Function(dynamic data) passwordInvalude,
    required TResult Function(dynamic data) locationServiceNotEnabled,
    required TResult Function(String data) invalidConfirmationCode,
    required TResult Function(dynamic data) wrongCredentials,
  }) {
    return locationServiceNotEnabled(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? network,
    TResult? Function(dynamic data)? empty,
    TResult? Function(dynamic data)? other,
    TResult? Function(dynamic data)? emailInvalude,
    TResult? Function(dynamic data)? passwordInvalude,
    TResult? Function(dynamic data)? locationServiceNotEnabled,
    TResult? Function(String data)? invalidConfirmationCode,
    TResult? Function(dynamic data)? wrongCredentials,
  }) {
    return locationServiceNotEnabled?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? network,
    TResult Function(dynamic data)? empty,
    TResult Function(dynamic data)? other,
    TResult Function(dynamic data)? emailInvalude,
    TResult Function(dynamic data)? passwordInvalude,
    TResult Function(dynamic data)? locationServiceNotEnabled,
    TResult Function(String data)? invalidConfirmationCode,
    TResult Function(dynamic data)? wrongCredentials,
    required TResult orElse(),
  }) {
    if (locationServiceNotEnabled != null) {
      return locationServiceNotEnabled(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkException value) network,
    required TResult Function(EmptyException value) empty,
    required TResult Function(OtherException value) other,
    required TResult Function(EmailInvalude value) emailInvalude,
    required TResult Function(PasswordInvalude value) passwordInvalude,
    required TResult Function(LocationServiceNotEnabled value)
        locationServiceNotEnabled,
    required TResult Function(InvalidConfirmationCode value)
        invalidConfirmationCode,
    required TResult Function(WrongCredentialsException value) wrongCredentials,
  }) {
    return locationServiceNotEnabled(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkException value)? network,
    TResult? Function(EmptyException value)? empty,
    TResult? Function(OtherException value)? other,
    TResult? Function(EmailInvalude value)? emailInvalude,
    TResult? Function(PasswordInvalude value)? passwordInvalude,
    TResult? Function(LocationServiceNotEnabled value)?
        locationServiceNotEnabled,
    TResult? Function(InvalidConfirmationCode value)? invalidConfirmationCode,
    TResult? Function(WrongCredentialsException value)? wrongCredentials,
  }) {
    return locationServiceNotEnabled?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkException value)? network,
    TResult Function(EmptyException value)? empty,
    TResult Function(OtherException value)? other,
    TResult Function(EmailInvalude value)? emailInvalude,
    TResult Function(PasswordInvalude value)? passwordInvalude,
    TResult Function(LocationServiceNotEnabled value)?
        locationServiceNotEnabled,
    TResult Function(InvalidConfirmationCode value)? invalidConfirmationCode,
    TResult Function(WrongCredentialsException value)? wrongCredentials,
    required TResult orElse(),
  }) {
    if (locationServiceNotEnabled != null) {
      return locationServiceNotEnabled(this);
    }
    return orElse();
  }
}

abstract class LocationServiceNotEnabled extends Exceptions {
  const factory LocationServiceNotEnabled(final dynamic data) =
      _$LocationServiceNotEnabledImpl;
  const LocationServiceNotEnabled._() : super._();

  dynamic get data;

  /// Create a copy of Exceptions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocationServiceNotEnabledImplCopyWith<_$LocationServiceNotEnabledImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InvalidConfirmationCodeImplCopyWith<$Res> {
  factory _$$InvalidConfirmationCodeImplCopyWith(
          _$InvalidConfirmationCodeImpl value,
          $Res Function(_$InvalidConfirmationCodeImpl) then) =
      __$$InvalidConfirmationCodeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String data});
}

/// @nodoc
class __$$InvalidConfirmationCodeImplCopyWithImpl<$Res>
    extends _$ExceptionsCopyWithImpl<$Res, _$InvalidConfirmationCodeImpl>
    implements _$$InvalidConfirmationCodeImplCopyWith<$Res> {
  __$$InvalidConfirmationCodeImplCopyWithImpl(
      _$InvalidConfirmationCodeImpl _value,
      $Res Function(_$InvalidConfirmationCodeImpl) _then)
      : super(_value, _then);

  /// Create a copy of Exceptions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$InvalidConfirmationCodeImpl(
      null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$InvalidConfirmationCodeImpl extends InvalidConfirmationCode {
  const _$InvalidConfirmationCodeImpl(this.data) : super._();

  @override
  final String data;

  @override
  String toString() {
    return 'Exceptions.invalidConfirmationCode(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvalidConfirmationCodeImpl &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data);

  /// Create a copy of Exceptions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InvalidConfirmationCodeImplCopyWith<_$InvalidConfirmationCodeImpl>
      get copyWith => __$$InvalidConfirmationCodeImplCopyWithImpl<
          _$InvalidConfirmationCodeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) network,
    required TResult Function(dynamic data) empty,
    required TResult Function(dynamic data) other,
    required TResult Function(dynamic data) emailInvalude,
    required TResult Function(dynamic data) passwordInvalude,
    required TResult Function(dynamic data) locationServiceNotEnabled,
    required TResult Function(String data) invalidConfirmationCode,
    required TResult Function(dynamic data) wrongCredentials,
  }) {
    return invalidConfirmationCode(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? network,
    TResult? Function(dynamic data)? empty,
    TResult? Function(dynamic data)? other,
    TResult? Function(dynamic data)? emailInvalude,
    TResult? Function(dynamic data)? passwordInvalude,
    TResult? Function(dynamic data)? locationServiceNotEnabled,
    TResult? Function(String data)? invalidConfirmationCode,
    TResult? Function(dynamic data)? wrongCredentials,
  }) {
    return invalidConfirmationCode?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? network,
    TResult Function(dynamic data)? empty,
    TResult Function(dynamic data)? other,
    TResult Function(dynamic data)? emailInvalude,
    TResult Function(dynamic data)? passwordInvalude,
    TResult Function(dynamic data)? locationServiceNotEnabled,
    TResult Function(String data)? invalidConfirmationCode,
    TResult Function(dynamic data)? wrongCredentials,
    required TResult orElse(),
  }) {
    if (invalidConfirmationCode != null) {
      return invalidConfirmationCode(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkException value) network,
    required TResult Function(EmptyException value) empty,
    required TResult Function(OtherException value) other,
    required TResult Function(EmailInvalude value) emailInvalude,
    required TResult Function(PasswordInvalude value) passwordInvalude,
    required TResult Function(LocationServiceNotEnabled value)
        locationServiceNotEnabled,
    required TResult Function(InvalidConfirmationCode value)
        invalidConfirmationCode,
    required TResult Function(WrongCredentialsException value) wrongCredentials,
  }) {
    return invalidConfirmationCode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkException value)? network,
    TResult? Function(EmptyException value)? empty,
    TResult? Function(OtherException value)? other,
    TResult? Function(EmailInvalude value)? emailInvalude,
    TResult? Function(PasswordInvalude value)? passwordInvalude,
    TResult? Function(LocationServiceNotEnabled value)?
        locationServiceNotEnabled,
    TResult? Function(InvalidConfirmationCode value)? invalidConfirmationCode,
    TResult? Function(WrongCredentialsException value)? wrongCredentials,
  }) {
    return invalidConfirmationCode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkException value)? network,
    TResult Function(EmptyException value)? empty,
    TResult Function(OtherException value)? other,
    TResult Function(EmailInvalude value)? emailInvalude,
    TResult Function(PasswordInvalude value)? passwordInvalude,
    TResult Function(LocationServiceNotEnabled value)?
        locationServiceNotEnabled,
    TResult Function(InvalidConfirmationCode value)? invalidConfirmationCode,
    TResult Function(WrongCredentialsException value)? wrongCredentials,
    required TResult orElse(),
  }) {
    if (invalidConfirmationCode != null) {
      return invalidConfirmationCode(this);
    }
    return orElse();
  }
}

abstract class InvalidConfirmationCode extends Exceptions {
  const factory InvalidConfirmationCode(final String data) =
      _$InvalidConfirmationCodeImpl;
  const InvalidConfirmationCode._() : super._();

  String get data;

  /// Create a copy of Exceptions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InvalidConfirmationCodeImplCopyWith<_$InvalidConfirmationCodeImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WrongCredentialsExceptionImplCopyWith<$Res> {
  factory _$$WrongCredentialsExceptionImplCopyWith(
          _$WrongCredentialsExceptionImpl value,
          $Res Function(_$WrongCredentialsExceptionImpl) then) =
      __$$WrongCredentialsExceptionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({dynamic data});
}

/// @nodoc
class __$$WrongCredentialsExceptionImplCopyWithImpl<$Res>
    extends _$ExceptionsCopyWithImpl<$Res, _$WrongCredentialsExceptionImpl>
    implements _$$WrongCredentialsExceptionImplCopyWith<$Res> {
  __$$WrongCredentialsExceptionImplCopyWithImpl(
      _$WrongCredentialsExceptionImpl _value,
      $Res Function(_$WrongCredentialsExceptionImpl) _then)
      : super(_value, _then);

  /// Create a copy of Exceptions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$WrongCredentialsExceptionImpl(
      freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$WrongCredentialsExceptionImpl extends WrongCredentialsException {
  const _$WrongCredentialsExceptionImpl(this.data) : super._();

  @override
  final dynamic data;

  @override
  String toString() {
    return 'Exceptions.wrongCredentials(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WrongCredentialsExceptionImpl &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  /// Create a copy of Exceptions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WrongCredentialsExceptionImplCopyWith<_$WrongCredentialsExceptionImpl>
      get copyWith => __$$WrongCredentialsExceptionImplCopyWithImpl<
          _$WrongCredentialsExceptionImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) network,
    required TResult Function(dynamic data) empty,
    required TResult Function(dynamic data) other,
    required TResult Function(dynamic data) emailInvalude,
    required TResult Function(dynamic data) passwordInvalude,
    required TResult Function(dynamic data) locationServiceNotEnabled,
    required TResult Function(String data) invalidConfirmationCode,
    required TResult Function(dynamic data) wrongCredentials,
  }) {
    return wrongCredentials(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? network,
    TResult? Function(dynamic data)? empty,
    TResult? Function(dynamic data)? other,
    TResult? Function(dynamic data)? emailInvalude,
    TResult? Function(dynamic data)? passwordInvalude,
    TResult? Function(dynamic data)? locationServiceNotEnabled,
    TResult? Function(String data)? invalidConfirmationCode,
    TResult? Function(dynamic data)? wrongCredentials,
  }) {
    return wrongCredentials?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? network,
    TResult Function(dynamic data)? empty,
    TResult Function(dynamic data)? other,
    TResult Function(dynamic data)? emailInvalude,
    TResult Function(dynamic data)? passwordInvalude,
    TResult Function(dynamic data)? locationServiceNotEnabled,
    TResult Function(String data)? invalidConfirmationCode,
    TResult Function(dynamic data)? wrongCredentials,
    required TResult orElse(),
  }) {
    if (wrongCredentials != null) {
      return wrongCredentials(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkException value) network,
    required TResult Function(EmptyException value) empty,
    required TResult Function(OtherException value) other,
    required TResult Function(EmailInvalude value) emailInvalude,
    required TResult Function(PasswordInvalude value) passwordInvalude,
    required TResult Function(LocationServiceNotEnabled value)
        locationServiceNotEnabled,
    required TResult Function(InvalidConfirmationCode value)
        invalidConfirmationCode,
    required TResult Function(WrongCredentialsException value) wrongCredentials,
  }) {
    return wrongCredentials(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkException value)? network,
    TResult? Function(EmptyException value)? empty,
    TResult? Function(OtherException value)? other,
    TResult? Function(EmailInvalude value)? emailInvalude,
    TResult? Function(PasswordInvalude value)? passwordInvalude,
    TResult? Function(LocationServiceNotEnabled value)?
        locationServiceNotEnabled,
    TResult? Function(InvalidConfirmationCode value)? invalidConfirmationCode,
    TResult? Function(WrongCredentialsException value)? wrongCredentials,
  }) {
    return wrongCredentials?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkException value)? network,
    TResult Function(EmptyException value)? empty,
    TResult Function(OtherException value)? other,
    TResult Function(EmailInvalude value)? emailInvalude,
    TResult Function(PasswordInvalude value)? passwordInvalude,
    TResult Function(LocationServiceNotEnabled value)?
        locationServiceNotEnabled,
    TResult Function(InvalidConfirmationCode value)? invalidConfirmationCode,
    TResult Function(WrongCredentialsException value)? wrongCredentials,
    required TResult orElse(),
  }) {
    if (wrongCredentials != null) {
      return wrongCredentials(this);
    }
    return orElse();
  }
}

abstract class WrongCredentialsException extends Exceptions {
  const factory WrongCredentialsException(final dynamic data) =
      _$WrongCredentialsExceptionImpl;
  const WrongCredentialsException._() : super._();

  dynamic get data;

  /// Create a copy of Exceptions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WrongCredentialsExceptionImplCopyWith<_$WrongCredentialsExceptionImpl>
      get copyWith => throw _privateConstructorUsedError;
}
