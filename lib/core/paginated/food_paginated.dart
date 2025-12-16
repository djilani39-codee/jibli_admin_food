import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jibli_admin_food/domain/entity/food_entity/food_entity.dart';

part 'food_paginated.freezed.dart';
part 'food_paginated.g.dart';

@freezed
class FoodPaginated with _$FoodPaginated {
  factory FoodPaginated(
      {required List<FoodEntity>? data, required bool success}) = _FoodPaginated;

  factory FoodPaginated.fromJson(Map<String, dynamic> json) =>
      _$FoodPaginatedFromJson(json);
}
