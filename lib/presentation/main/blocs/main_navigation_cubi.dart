import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavigationCubit extends Cubit<int> {
  BottomNavigationCubit() : super(0);
  final controller = PageController(initialPage: 0);
  changeTap(int index) {
    emit(index);
  }

  @override
  Future<void> close() {
    controller.dispose();
    return super.close();
  }
}
