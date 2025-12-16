part of 'food_cubit.dart';

@freezed
class FoodState with _$FoodState {
  const factory FoodState.initial() = _initial;
  const factory FoodState.loading() = _Loading;
  const factory FoodState.error(ErrorState error) = _Error;
  const factory FoodState.empty() = _Empty;
  const factory FoodState.lastPageLoaded(
      {required List<FoodEntity> Foods}) = _LastPageLoaded;
  const factory FoodState.loaded(
      {required List<FoodEntity> Foods, pageKey}) = _Loaded;
}
