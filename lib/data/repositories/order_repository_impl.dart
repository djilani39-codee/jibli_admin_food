import 'package:dio/dio.dart';
import 'package:jibli_admin_food/core/excptions/exceptions.dart';
import 'package:jibli_admin_food/core/filter.dart';
import 'package:jibli_admin_food/core/paginated/order_paginated.dart';
import 'package:jibli_admin_food/core/result/result.dart';
import 'package:jibli_admin_food/data/local_data_source/local_data_source.dart';
import 'package:jibli_admin_food/data/remote_data_source/order/order_remote_data_source.dart';
import 'package:jibli_admin_food/domain/repository/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  OrderRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});

  final OrderRemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  @override
  Future<Result<OrderPaginated, Exceptions>> load(Filter params) async {
    try {
      var response = await remoteDataSource.getOrders(queries: params.toJson());
      if (response.data.success) {
        return Result.success(data: response.data);
      }
      if (!response.data.success) {
        return Result.failure(error: Exceptions.other(''));
      }
      return Result.failure(error: Exceptions.other('dfbgfd'));
    } on DioException catch (e) {
      return Result.failure(error: e.handelException());
    } catch (e) {
      return Result.failure(
          error: Exceptions.other(e.getException.localizedErrorMessage));
    }
  }

  @override
  Future<Result<dynamic, Exceptions>> accepted(Filter params) async {
    try {
      var response =
          await remoteDataSource.acceptedOrders(queries: params.toJson());
      if (response.data["success"]) {
        return Result.success(data: "تم قبول الطلب ");
      }
      return Result.failure(
          error: Exceptions.other('حدث خطأ أتناء قبول الطلب'));
    } on DioException catch (e) {
      return Result.failure(error: e.handelException());
    } catch (e) {
      return Result.failure(
          error: Exceptions.other(e.getException.localizedErrorMessage));
    }
  }

  @override
  Future<Result<dynamic, Exceptions>> rejected(Filter params) async {
    try {
      var response =
          await remoteDataSource.rejectedOrders(queries: params.toJson());
      if (response.data["success"]) {
        return Result.success(data: "تم رفض الطلب");
      }
      return Result.failure(error: Exceptions.other('حدث خطأ أتناء رفض الطلب'));
    } on DioException catch (e) {
      return Result.failure(error: e.handelException());
    } catch (e) {
      return Result.failure(
          error: Exceptions.other(e.getException.localizedErrorMessage));
    }
  }
}
