import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:jibli_admin_food/core/paginated/order_paginated.dart';
import 'package:retrofit/retrofit.dart';

part 'order_remote_data_source.g.dart';

/// Minimal ParseErrorLogger used by generated Retrofit code.
abstract class ParseErrorLogger {
  void logError(Object error, StackTrace stackTrace, RequestOptions request);
}

@RestApi(
  baseUrl: "https://foodwood.site/jibli/api",
  parser: Parser.FlutterCompute,
)
abstract class OrderRemoteDataSource {
  factory OrderRemoteDataSource(Dio dio, {String baseUrl}) =
      _OrderRemoteDataSource;

  @GET("/market/orders.php?")
  Future<HttpResponse<OrderPaginated>> getOrders({
    @Queries() required Map<String, dynamic> queries,
  });
  @GET("/market/orders.php?")
  Future<HttpResponse> acceptedOrders({
    @Queries() required Map<String, dynamic> queries,
  });
  @GET("/market/orders.php?")
  Future<HttpResponse> rejectedOrders({
    @Queries() required Map<String, dynamic> queries,
  });
}

FutureOr<OrderPaginated> deserializeOrderPaginated(Map<String, dynamic> json) =>
    OrderPaginated.fromJson(json);
