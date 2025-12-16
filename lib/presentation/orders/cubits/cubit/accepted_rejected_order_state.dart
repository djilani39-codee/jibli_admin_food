part of 'accepted_rejected_order_cubit.dart';

@freezed
class AcceptedRejectedOrderState with _$AcceptedRejectedOrderState {
  const factory AcceptedRejectedOrderState.initial() = _Initial;
  const factory AcceptedRejectedOrderState.loading() = _loading;
  const factory AcceptedRejectedOrderState.error(String? msg,
      {required int i}) = _error;
  const factory AcceptedRejectedOrderState.loadingrejected() = _loadingrejected;

  const factory AcceptedRejectedOrderState.SuccessRejected(String? msg) = _SuccessRejected;

  const factory AcceptedRejectedOrderState.Sucess(String? msg) = _Sucess;
}
