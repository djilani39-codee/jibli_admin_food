// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_paginated.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OrderPaginated _$OrderPaginatedFromJson(Map<String, dynamic> json) {
  return _OrderPaginated.fromJson(json);
}

/// @nodoc
mixin _$OrderPaginated {
  List<OrderEntity>? get data => throw _privateConstructorUsedError;
  bool get more => throw _privateConstructorUsedError;
  bool get success => throw _privateConstructorUsedError;

  /// Serializes this OrderPaginated to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderPaginated
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderPaginatedCopyWith<OrderPaginated> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderPaginatedCopyWith<$Res> {
  factory $OrderPaginatedCopyWith(
          OrderPaginated value, $Res Function(OrderPaginated) then) =
      _$OrderPaginatedCopyWithImpl<$Res, OrderPaginated>;
  @useResult
  $Res call({List<OrderEntity>? data, bool more, bool success});
}

/// @nodoc
class _$OrderPaginatedCopyWithImpl<$Res, $Val extends OrderPaginated>
    implements $OrderPaginatedCopyWith<$Res> {
  _$OrderPaginatedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderPaginated
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? more = null,
    Object? success = null,
  }) {
    return _then(_value.copyWith(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<OrderEntity>?,
      more: null == more
          ? _value.more
          : more // ignore: cast_nullable_to_non_nullable
              as bool,
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderPaginatedImplCopyWith<$Res>
    implements $OrderPaginatedCopyWith<$Res> {
  factory _$$OrderPaginatedImplCopyWith(_$OrderPaginatedImpl value,
          $Res Function(_$OrderPaginatedImpl) then) =
      __$$OrderPaginatedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<OrderEntity>? data, bool more, bool success});
}

/// @nodoc
class __$$OrderPaginatedImplCopyWithImpl<$Res>
    extends _$OrderPaginatedCopyWithImpl<$Res, _$OrderPaginatedImpl>
    implements _$$OrderPaginatedImplCopyWith<$Res> {
  __$$OrderPaginatedImplCopyWithImpl(
      _$OrderPaginatedImpl _value, $Res Function(_$OrderPaginatedImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderPaginated
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? more = null,
    Object? success = null,
  }) {
    return _then(_$OrderPaginatedImpl(
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<OrderEntity>?,
      more: null == more
          ? _value.more
          : more // ignore: cast_nullable_to_non_nullable
              as bool,
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderPaginatedImpl implements _OrderPaginated {
  _$OrderPaginatedImpl(
      {required final List<OrderEntity>? data,
      required this.more,
      required this.success})
      : _data = data;

  factory _$OrderPaginatedImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderPaginatedImplFromJson(json);

  final List<OrderEntity>? _data;
  @override
  List<OrderEntity>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool more;
  @override
  final bool success;

  @override
  String toString() {
    return 'OrderPaginated(data: $data, more: $more, success: $success)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderPaginatedImpl &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.more, more) || other.more == more) &&
            (identical(other.success, success) || other.success == success));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_data), more, success);

  /// Create a copy of OrderPaginated
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderPaginatedImplCopyWith<_$OrderPaginatedImpl> get copyWith =>
      __$$OrderPaginatedImplCopyWithImpl<_$OrderPaginatedImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderPaginatedImplToJson(
      this,
    );
  }
}

abstract class _OrderPaginated implements OrderPaginated {
  factory _OrderPaginated(
      {required final List<OrderEntity>? data,
      required final bool more,
      required final bool success}) = _$OrderPaginatedImpl;

  factory _OrderPaginated.fromJson(Map<String, dynamic> json) =
      _$OrderPaginatedImpl.fromJson;

  @override
  List<OrderEntity>? get data;
  @override
  bool get more;
  @override
  bool get success;

  /// Create a copy of OrderPaginated
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderPaginatedImplCopyWith<_$OrderPaginatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
