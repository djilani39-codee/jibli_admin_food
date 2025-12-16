// service locator
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:jibli_admin_food/core/enums.dart';
import 'package:jibli_admin_food/data/local_data_source/local_data_source.dart';
import 'package:jibli_admin_food/data/remote_data_source/custom_interceptor.dart';
import 'package:jibli_admin_food/data/remote_data_source/food/food_remote_data_source.dart';
import 'package:jibli_admin_food/data/remote_data_source/order/order_remote_data_source.dart';
import 'package:jibli_admin_food/data/remote_data_source/other/other_remote_data_source.dart';
import 'package:jibli_admin_food/data/repositories/food_repository_impl.dart';
import 'package:jibli_admin_food/data/repositories/order_repository_impl.dart';
import 'package:jibli_admin_food/data/repositories/other_repository_impl.dart';
import 'package:jibli_admin_food/domain/repository/food_repository.dart';
import 'package:jibli_admin_food/domain/repository/order_repository.dart';
import 'package:jibli_admin_food/domain/repository/other_repository.dart';
import 'package:jibli_admin_food/presentation/main/blocs/main_navigation_cubi.dart';
import 'package:jibli_admin_food/presentation/orders/cubits/cubit/order_bloc.dart';
import 'package:jibli_admin_food/presentation/orders/cubits/order_filter_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // hive local db init

  final box = await LocalDataSourceImpl.init();

  // locators
  sl
    // external
    ..registerLazySingleton<Box<dynamic>>(
      () => box,
    )
    ..registerLazySingleton<Dio>(
      () => Dio(BaseOptions(
        contentType: 'application/json',
      ))
        ..interceptors.add(CustomInterceptor()),
    )

    // data sources
    ..registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(sl()),
    )
    ..registerLazySingleton<OtherRemoteDataSource>(
      () => OtherRemoteDataSource(
        sl(),
      ),
    )
    ..registerLazySingleton<OrderRemoteDataSource>(
      () => OrderRemoteDataSource(
        sl(),
      ),
    )
    ..registerLazySingleton<FoodRemoteDataSource>(
      () => FoodRemoteDataSource(
        sl(),
      ),
    )
    ..registerLazySingleton<FoodRepository>(
      () => FoodRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
      ),
    )
    ..registerLazySingleton<OtherRepository>(
      () => OtherRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
      ),
    )

    // ..registerLazySingleton(() => AuthBloc(sl()), instanceName: "signup")
    // ..registerLazySingleton(() => AuthBloc(sl()), instanceName: "confirmemail")

    // repositories
    ..registerLazySingleton<OrderRepository>(() =>
        OrderRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()))
    ..registerLazySingleton<OrderBloc>(() => OrderBloc(sl()))
    ..registerLazySingleton<BottomNavigationCubit>(
        () => BottomNavigationCubit())
    ..registerLazySingleton<OrderFilterCubit<StateOrder>>(
        () => OrderFilterCubit<StateOrder>(init: null));
}
