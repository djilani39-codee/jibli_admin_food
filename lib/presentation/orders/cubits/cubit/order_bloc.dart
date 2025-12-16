import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../core/bloc/error.dart';
import '../../../../core/filter.dart';
import '../../../../domain/entity/order_entity/order_entity.dart';
import '../../../../domain/repository/order_repository.dart';

part 'order_event.dart';

part 'order_state.dart';

part 'order_bloc.freezed.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc(this.orderRepository) : super(const OrderState.initial()) {
    on<OrderEvent>(_mapEventToState, transformer: droppable());
  }

  final PagingController<int, OrderEntity> pagingController =
  PagingController(firstPageKey: 1);
  int nextPage = 1;
  final OrderRepository orderRepository;

  FutureOr<dynamic> _mapEventToState(OrderEvent event,
      Emitter<OrderState> emit) {
    return event.map(
      load: (load) async {
        emit(const OrderState.loading());
        final result = await orderRepository.load(load.filter);
        return emit(result.when(failure: (failure) {
          return failure!.maybeWhen(
            wrongCredentials: (data) =>
            const OrderState.error(
              ErrorState.unAuthrized(),
            ),
            orElse: () =>
            const OrderState.error(
              ErrorState.other(message: ""),
            ),
            network: (message) =>
            const OrderState.error(
                ErrorState.networkError(message: '')),
          );
        }, success: (success) {
          if (success?.data?.isEmpty ?? true) {
            return const OrderState.loaded(orders: []);
          }
          print(success?.data?.length);
          if (!(success?.more ?? true)) {
            return OrderState.lastPageLoaded(
                orders: success?.data ?? []);
          }

          return OrderState.loaded(
              orders: success?.data ?? [], pageKey: ++nextPage);
        },),);
      },
    );
  }
}