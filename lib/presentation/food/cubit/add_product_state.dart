part of 'add_product_cubit.dart';

@freezed
class AddProductState with _$AddProductState {
  const factory AddProductState.initial() = _Initial;
  const factory AddProductState.loading() = _Loading;
  const factory AddProductState.success({
    required String message,
    int? productId,
  }) = _Success;
  const factory AddProductState.error(ErrorState error) = _Error;
}
