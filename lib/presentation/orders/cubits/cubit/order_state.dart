part of 'order_bloc.dart';

@freezed
class OrderState with _$OrderState {
  const factory OrderState.initial() = _initial;
  const factory OrderState.loading() = _Loading;
  const factory OrderState.error(ErrorState error) = _Error;
  const factory OrderState.empty() = _Empty;
  const factory OrderState.lastPageLoaded(
      {required List<OrderEntity> orders}) = _LastPageLoaded;
  const factory OrderState.loaded(
      {required List<OrderEntity> orders, pageKey}) = _Loaded;}
