import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jibli_admin_food/domain/entity/order_entity/order_entity.dart';

part 'order_paginated.freezed.dart';
part 'order_paginated.g.dart';

@freezed
class OrderPaginated with _$OrderPaginated {
  factory OrderPaginated(
      {required List<OrderEntity>? data,
      required bool more,
      required bool success}) = _OrderPaginated;

  factory OrderPaginated.fromJson(Map<String, dynamic> json) =>
      _$OrderPaginatedFromJson(json);
}
