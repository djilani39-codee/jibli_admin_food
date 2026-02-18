import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jibli_admin_food/domain/entity/fast_food_entity/fast_food_response.dart';
import 'package:jibli_admin_food/domain/entity/food_entity/food_entity.dart';

import 'local_data_keys.dart';

abstract class LocalDataSource {
  T? getValue<T>(LocalDataKeys key, {dynamic defaultValue});
  Future<void> setValue<T>(LocalDataKeys key, T value);
  Future<void> clear();
}

class LocalDataSourceImpl implements LocalDataSource {
  LocalDataSourceImpl(Box<dynamic> box) : _box = box;

  final Box<dynamic> _box;

  static Future<Box<dynamic>> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(FastFoodEntityAdapter());
    Hive.registerAdapter(MarketsAdapter());
    Hive.registerAdapter(FastFoodResponseAdapter());
    Hive.registerAdapter(ImageAdapter());

    return Hive.openBox<dynamic>('defaultBox');
  }

  @override
  T? getValue<T>(LocalDataKeys key, {dynamic defaultValue}) {
    return _box.get(key.name, defaultValue: defaultValue) as T?;
  }

  @override
  Future<void> setValue<T>(LocalDataKeys key, T value) async {
    await _box.put(key.name, value);
  }

  @override
  Future<void> clear() async {
    await _box.clear();
  }
}
