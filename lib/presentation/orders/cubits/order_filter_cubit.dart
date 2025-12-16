import 'package:flutter_bloc/flutter_bloc.dart';




class OrderFilterCubit<T> extends Cubit<T?> {
  OrderFilterCubit({required T? init}) : super(init);

  changeItem(T? item) {
    emit(item);
  }
}