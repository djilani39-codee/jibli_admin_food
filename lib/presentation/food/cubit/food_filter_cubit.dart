import 'package:flutter_bloc/flutter_bloc.dart';

class FoodFilterCubit<T> extends Cubit<T?> {
  FoodFilterCubit({required T? init}) : super(init);

  changeItem(T? item) {
    emit(item);
  }
}

class Item {
  Item({required this.index, required this.item});
  int item, index;
}
