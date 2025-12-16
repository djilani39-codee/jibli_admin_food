// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'food_paginated.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FoodPaginated _$FoodPaginatedFromJson(Map<String, dynamic> json) {
  return _FoodPaginated.fromJson(json);
}

/// @nodoc
mixin _$FoodPaginated {
  List<FoodEntity>? get data => throw _privateConstructorUsedError;
  bool get success => throw _privateConstructorUsedError;

  /// Serializes this FoodPaginated to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FoodPaginated
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FoodPaginatedCopyWith<FoodPaginated> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FoodPaginatedCopyWith<$Res> {
  factory $FoodPaginatedCopyWith(
          FoodPaginated value, $Res Function(FoodPaginated) then) =
      _$FoodPaginatedCopyWithImpl<$Res, FoodPaginated>;
  @useResult
  $Res call({List<FoodEntity>? data, bool success});
}

/// @nodoc
class _$FoodPaginatedCopyWithImpl<$Res, $Val extends FoodPaginated>
    implements $FoodPaginatedCopyWith<$Res> {
  _$FoodPaginatedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FoodPaginated
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? success = null,
  }) {
    return _then(_value.copyWith(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<FoodEntity>?,
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FoodPaginatedImplCopyWith<$Res>
    implements $FoodPaginatedCopyWith<$Res> {
  factory _$$FoodPaginatedImplCopyWith(
          _$FoodPaginatedImpl value, $Res Function(_$FoodPaginatedImpl) then) =
      __$$FoodPaginatedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<FoodEntity>? data, bool success});
}

/// @nodoc
class __$$FoodPaginatedImplCopyWithImpl<$Res>
    extends _$FoodPaginatedCopyWithImpl<$Res, _$FoodPaginatedImpl>
    implements _$$FoodPaginatedImplCopyWith<$Res> {
  __$$FoodPaginatedImplCopyWithImpl(
      _$FoodPaginatedImpl _value, $Res Function(_$FoodPaginatedImpl) _then)
      : super(_value, _then);

  /// Create a copy of FoodPaginated
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? success = null,
  }) {
    return _then(_$FoodPaginatedImpl(
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<FoodEntity>?,
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FoodPaginatedImpl implements _FoodPaginated {
  _$FoodPaginatedImpl(
      {required final List<FoodEntity>? data, required this.success})
      : _data = data;

  factory _$FoodPaginatedImpl.fromJson(Map<String, dynamic> json) =>
      _$$FoodPaginatedImplFromJson(json);

  final List<FoodEntity>? _data;
  @override
  List<FoodEntity>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool success;

  @override
  String toString() {
    return 'FoodPaginated(data: $data, success: $success)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FoodPaginatedImpl &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.success, success) || other.success == success));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_data), success);

  /// Create a copy of FoodPaginated
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FoodPaginatedImplCopyWith<_$FoodPaginatedImpl> get copyWith =>
      __$$FoodPaginatedImplCopyWithImpl<_$FoodPaginatedImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FoodPaginatedImplToJson(
      this,
    );
  }
}

abstract class _FoodPaginated implements FoodPaginated {
  factory _FoodPaginated(
      {required final List<FoodEntity>? data,
      required final bool success}) = _$FoodPaginatedImpl;

  factory _FoodPaginated.fromJson(Map<String, dynamic> json) =
      _$FoodPaginatedImpl.fromJson;

  @override
  List<FoodEntity>? get data;
  @override
  bool get success;

  /// Create a copy of FoodPaginated
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FoodPaginatedImplCopyWith<_$FoodPaginatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
