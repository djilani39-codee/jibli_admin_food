import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jibli_admin_food/core/filter.dart';
import 'package:jibli_admin_food/domain/repository/order_repository.dart';

part 'accepted_rejected_order_state.dart';
part 'accepted_rejected_order_cubit.freezed.dart';

class AcceptedRejectedOrderCubit extends Cubit<AcceptedRejectedOrderState> {
  AcceptedRejectedOrderCubit(this.orderRepository)
      : super(AcceptedRejectedOrderState.initial());
  final OrderRepository orderRepository;
  accepted(Filter filter, int index) async {
    emit(AcceptedRejectedOrderState.loading());
    final result = await orderRepository.accepted(filter);
    return emit(result.when(failure: (failure) {
      return AcceptedRejectedOrderState.error(failure?.localizedErrorMessage,
          i: index);
    }, success: (success) {
      return AcceptedRejectedOrderState.Sucess(success);
    }));
  }

  rejected(Filter filter, int index) async {
    emit(AcceptedRejectedOrderState.loadingrejected());
    final result = await orderRepository.rejected(filter);
    return emit(result.when(failure: (failure) {
      return AcceptedRejectedOrderState.error(failure?.localizedErrorMessage,
          i: index);
    }, success: (success) {
      return AcceptedRejectedOrderState.SuccessRejected(success);
    }));
  }
}
