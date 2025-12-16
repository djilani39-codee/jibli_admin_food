import 'package:jibli_admin_food/core/filter.dart';
import 'package:jibli_admin_food/core/paginated/order_paginated.dart';

import '../../core/excptions/exceptions.dart';
import '../../core/result/result.dart';

abstract class OrderRepository {
  Future<Result<OrderPaginated, Exceptions>> load(Filter params);
  Future<Result<dynamic, Exceptions>> accepted(Filter params);
  Future<Result<dynamic, Exceptions>> rejected(Filter params);
}
