part of 'available_food_cubit.dart';

@freezed
class AvailableFoodState with _$AvailableFoodState {
  const factory AvailableFoodState.initial() = _Initial;

  const factory AvailableFoodState.loading() = _loading;
  const factory AvailableFoodState.loadingScheduling() = _loadingScheduling;
  const factory AvailableFoodState.error(ErrorState error) = _error;

  const factory AvailableFoodState.loadingSetPrice() = _LoadingSetPrice;

  // const factory AvailableFoodState.SuccesSetPrice(
  //     {required int index,
  //     required int indexFood,
  //     required int price,
  //     required String productId}) = _SuccesSetPrice;
  const factory AvailableFoodState.loadingSetDescription() =
      _loadingSetDescription;

  const factory AvailableFoodState.loadingSetName() =
      _loadingSetName;

  // const factory AvailableFoodState.SuccesSetDescription(
  //     {required int index,
  //     required String description,
  //     required int indexFood,
  //     required String productId}) = _SuccesSetDescription;

  const factory AvailableFoodState.succes(
      {required int index,
      required int indexCategory,
      bool? state,
      int? price,
      String? description,
      String? scheduling,
      String? name
      }) = _succes;

}
