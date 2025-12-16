import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:jibli_admin_food/domain/entity/fast_food_entity/fast_food_response.dart';
import 'package:retrofit/retrofit.dart';

part 'other_remote_data_source.g.dart';

/// Minimal ParseErrorLogger used by generated Retrofit code.
abstract class ParseErrorLogger {
  void logError(Object error, StackTrace stackTrace, RequestOptions request);
}

@RestApi(
  baseUrl: "https://foodwood.site/jibli/api",
  parser: Parser.FlutterCompute,
)
abstract class OtherRemoteDataSource {
  factory OtherRemoteDataSource(Dio dio, {String baseUrl}) =
      _OtherRemoteDataSource;

  @GET("/market/settings.php?")
  Future<HttpResponse> updateWorkdays({
    @Queries() required Map<String, dynamic> queries,
  });
  @POST("/market/settings.php?")
  Future<HttpResponse> onVacation({
    @Queries() required Map<String, dynamic> queries,
  });
  @POST("/market/login.php?")
  Future<HttpResponse<FastFoodResponse>> login({
    @Queries() required Map<String, dynamic> queries,
  });
}

FutureOr<FastFoodResponse> deserializeFastFoodResponse(
        Map<String, dynamic> json) =>
    FastFoodResponse.fromJson(json);
