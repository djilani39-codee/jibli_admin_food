import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:jibli_admin_food/core/paginated/food_paginated.dart';
import 'package:retrofit/retrofit.dart';
import 'package:http_parser/http_parser.dart';

part 'food_remote_data_source.g.dart';

/// Simple logger interface used by generated Retrofit code when parsing fails.
/// The generated code expects a `ParseErrorLogger` type to be available
/// so we declare a minimal interface here to avoid analyzer errors.
abstract class ParseErrorLogger {
  void logError(Object error, StackTrace stackTrace, RequestOptions request);
}

@RestApi(
  baseUrl: "https://foodwood.site/jibli/api",
  parser: Parser.FlutterCompute,
)
abstract class FoodRemoteDataSource {
  factory FoodRemoteDataSource(Dio dio, {String baseUrl}) =
      _FoodRemoteDataSource;

  @GET("/market/products.php?")
  Future<HttpResponse<FoodPaginated>> getproduct({
    @Queries() required Map<String, dynamic> queries,
  });

  @POST("/market/products.php?")
  Future<HttpResponse<FoodPaginated>> changeState({
    @Queries() required Map<String, dynamic> queries,
  });

  @POST("/market/products.php?")
  Future<HttpResponse<FoodPaginated>> changePrice({
    @Queries() required Map<String, dynamic> queries,
  });

  @POST("/market/products.php?")
  Future<HttpResponse<FoodPaginated>> changeName({
    @Queries() required Map<String, dynamic> queries,
  });

  @POST("/market/products.php?")
  Future<HttpResponse<FoodPaginated>> changeDescription({
    @Queries() required Map<String, dynamic> queries,
  });

  @POST("/market/products.php?")
  Future<HttpResponse<FoodPaginated>> changeScheduling({
    @Queries() required Map<String, dynamic> queries,
  });

  @POST("/market/products.php")
  Future<HttpResponse<FoodPaginated>> addProduct({
    @Body() required FormData formData,
  });
}

FutureOr<FoodPaginated> deserializeFoodPaginated(Map<String, dynamic> json) =>
    FoodPaginated.fromJson(json);
