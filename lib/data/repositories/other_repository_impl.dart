import 'package:dio/dio.dart';
import 'package:jibli_admin_food/core/excptions/exceptions.dart';
import 'package:jibli_admin_food/core/filter.dart';
import 'package:jibli_admin_food/core/result/result.dart';
import 'package:jibli_admin_food/data/local_data_source/local_data_keys.dart';
import 'package:jibli_admin_food/data/local_data_source/local_data_source.dart';
import 'package:jibli_admin_food/data/remote_data_source/other/other_remote_data_source.dart';
import 'package:jibli_admin_food/domain/entity/fast_food_entity/fast_food_response.dart';
import 'package:jibli_admin_food/domain/repository/other_repository.dart';

class OtherRepositoryImpl implements OtherRepository {
  OtherRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});

  final OtherRemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  @override
  Future<Result<dynamic, Exceptions>> login(Filter params) async {
    try {
      var response = await remoteDataSource.login(queries: params.toJson());
      if (response.data.success) {
        await localDataSource.setValue(LocalDataKeys.user, response.data.data);

        return Result.success(data: "");
      }
      if (!response.data.success) {
        return Result.failure(error: Exceptions.other(""));
      }

      return Result.failure(error: Exceptions.other(""));
    } on DioException catch (e) {
      return Result.failure(error: e.handelException());
    } catch (e) {
      return Result.failure(
          error: Exceptions.other(e.getException.localizedErrorMessage));
    }
  }

  @override
  Future<Result<dynamic, Exceptions>> onVacation(Filter params) async {
    try {
      var response =
          await remoteDataSource.onVacation(queries: params.toJson());
      if (response.data['success']) {
        FastFoodEntity user = localDataSource.getValue(LocalDataKeys.user);
        user.markets?.first.onVacation = params.onVaction;
        await localDataSource.setValue(LocalDataKeys.user, user);
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
  Future<Result<dynamic, Exceptions>> updateWorkDays(Filter params) async {
    try {
      var response =
          await remoteDataSource.updateWorkdays(queries: params.toJson());
      if (response.data['success']) {
        FastFoodEntity user = localDataSource.getValue(LocalDataKeys.user);
        user.markets?.first.workHours = params.workHour;
        await localDataSource.setValue(LocalDataKeys.user, user);
        return Result.success(data: response.data);
      }
      if (response.data["message"] ==
          "closingHour must be greater than openingHour") {
        return Result.failure(
            error: Exceptions.other("توقيت الإغلاق غير متناسق مع توقيت الفتح"));
      }
      if (response.data["message"] ==
          "invalid openingHour ( must from 00 to 23 )") {
        return Result.failure(
            error: Exceptions.other("ساعة الافتتاح غير صالحة"));
      }
      return Result.failure(error: Exceptions.other(""));
    } on DioException catch (e) {
      return Result.failure(error: e.handelException());
    } catch (e) {
      return Result.failure(
          error: Exceptions.other(e.getException.localizedErrorMessage));
    }
  }
}
