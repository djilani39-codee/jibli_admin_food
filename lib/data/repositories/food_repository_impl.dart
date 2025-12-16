import 'package:dio/dio.dart';
import 'package:jibli_admin_food/core/excptions/exceptions.dart';
import 'package:jibli_admin_food/core/filter.dart';
import 'package:jibli_admin_food/core/paginated/food_paginated.dart';
import 'package:jibli_admin_food/core/result/result.dart';
import 'package:jibli_admin_food/data/local_data_source/local_data_source.dart';
import 'package:jibli_admin_food/data/remote_data_source/food/food_remote_data_source.dart';
import 'package:jibli_admin_food/domain/repository/food_repository.dart';

class FoodRepositoryImpl implements FoodRepository {
  FoodRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});

  final FoodRemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  @override
  Future<Result<FoodPaginated, Exceptions>> load(Filter params) async {
    try {
      var response =
          await remoteDataSource.getproduct(queries: params.toJson());
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
  Future<Result<FoodPaginated, Exceptions>> changeStateAvailable(
      Filter params) async {
    try {
      var response =
          await remoteDataSource.changeState(queries: params.toJson());
      if (response.data.success) {
        return Result.success(data: response.data);
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
  Future<Result<FoodPaginated, Exceptions>> changeDescription(
      Filter params) async {
    try {
      var response =
          await remoteDataSource.changeDescription(queries: params.toJson());
      if (response.data.success) {
        return Result.success(data: response.data);
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
  Future<Result<FoodPaginated, Exceptions>> changePrice(Filter params) async {
    try {
      var response =
          await remoteDataSource.changePrice(queries: params.toJson());
      if (response.data.success) {
        return Result.success(data: response.data);
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
  Future<Result<FoodPaginated, Exceptions>> changeName(Filter params) async {
    try {
      var response =
          await remoteDataSource.changeName(queries: params.toJson());
      if (response.data.success) {
        return Result.success(data: response.data);
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
  Future<Result<FoodPaginated, Exceptions>> changeScheduling(
      Filter params) async {
    try {
      var response =
          await remoteDataSource.changeScheduling(queries: params.toJson());
      if (response.data.success) {
        return Result.success(data: response.data);
      }
      return Result.failure(error: Exceptions.other('dfbgfd'));
    } on DioException catch (e) {
      return Result.failure(error: e.handelException());
    } catch (e) {
      return Result.failure(
          error: Exceptions.other(e.getException.localizedErrorMessage));
    }
  }
}
