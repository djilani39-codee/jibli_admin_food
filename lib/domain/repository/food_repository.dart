import 'package:jibli_admin_food/core/filter.dart';
import 'package:jibli_admin_food/core/paginated/food_paginated.dart';

import '../../core/excptions/exceptions.dart';
import '../../core/result/result.dart';

abstract class FoodRepository {
  Future<Result<FoodPaginated, Exceptions>> load(Filter params);
  Future<Result<FoodPaginated, Exceptions>> changeStateAvailable(Filter params);
  Future<Result<FoodPaginated, Exceptions>> changeScheduling(Filter params);
  Future<Result<FoodPaginated, Exceptions>> changePrice(Filter params);
  Future<Result<FoodPaginated, Exceptions>> changeDescription(Filter params);
  Future<Result<FoodPaginated, Exceptions>> changeName(Filter params);
}
