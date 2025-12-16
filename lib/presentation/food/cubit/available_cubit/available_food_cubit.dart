import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jibli_admin_food/core/bloc/error.dart';
import 'package:jibli_admin_food/core/filter.dart';
import 'package:jibli_admin_food/domain/repository/food_repository.dart';

part 'available_food_state.dart';

part 'available_food_cubit.freezed.dart';

class AvailableFoodCubit extends Cubit<AvailableFoodState> {
  AvailableFoodCubit(this.foodRepository) : super(AvailableFoodState.initial());
  final FoodRepository foodRepository;

  changeStatus(
      {required int index,
      required int indexCategory,
      required String productId,
      required bool state}) async {
    emit(AvailableFoodState.loading());
    final result = await foodRepository.changeStateAvailable(
        Filter(setAvailable: state, productId: productId));
    return emit(
      result.when(
          failure: (failure) {
            return failure!.maybeWhen(
              wrongCredentials: (data) => const AvailableFoodState.error(
                ErrorState.unAuthrized(),
              ),
              orElse: () => const AvailableFoodState.error(
                ErrorState.other(message: ""),
              ),
              network: (message) => const AvailableFoodState.error(
                  ErrorState.networkError(message: '')),
            );
          },
          success: (success) => AvailableFoodState.succes(
              index: index, indexCategory: indexCategory, state: state)),
    );
  }

  changeScheduling(
      {required int index,
      required int indexCategory,
      required String productId,
      required String? scheduling}) async {
    emit(AvailableFoodState.loadingScheduling());
    final result = await foodRepository.changeScheduling(Filter(
        setAvailableTime: scheduling,
        productId: productId,
        setAvailableTimeBool: true));
    return emit(
      result.when(
          failure: (failure) {
            return failure!.maybeWhen(
              wrongCredentials: (data) => const AvailableFoodState.error(
                ErrorState.unAuthrized(),
              ),
              orElse: () => const AvailableFoodState.error(
                ErrorState.other(message: ""),
              ),
              network: (message) => const AvailableFoodState.error(
                  ErrorState.networkError(message: '')),
            );
          },
          success: (success) => AvailableFoodState.succes(
              index: index,
              indexCategory: indexCategory,
              scheduling: scheduling)),
    );
  }

  changePrice(
      {required int index,
      required int indexCategory,
      required String productId,
      required int price}) async {
    emit(AvailableFoodState.loadingSetPrice());
    final result = await foodRepository
        .changePrice(Filter(setPrice: price, productId: productId));
    return emit(result.when(
        failure: (failure) {
          return failure!.maybeWhen(
            wrongCredentials: (data) => const AvailableFoodState.error(
              ErrorState.unAuthrized(),
            ),
            orElse: () => const AvailableFoodState.error(
              ErrorState.other(message: ""),
            ),
            network: (message) => const AvailableFoodState.error(
                ErrorState.networkError(message: '')),
          );
        },
        success: (success) => AvailableFoodState.succes(
            index: index, indexCategory: indexCategory, price: price)));
  }

  changeDescription(
      {required int index,
      required int indexCategory,
      required String productId,
      required String description}) async {
    emit(AvailableFoodState.loadingSetDescription());
    final result = await foodRepository.changeDescription(
        Filter(setDescription: description, productId: productId));
    return emit(
      result.when(
          failure: (failure) {
            return failure!.maybeWhen(
                wrongCredentials: (data) =>
                    const AvailableFoodState.error(ErrorState.unAuthrized()),
                orElse: () => const AvailableFoodState.error(
                    ErrorState.other(message: "")),
                network: (message) => const AvailableFoodState.error(
                    ErrorState.networkError(message: '')));
          },
          success: (success) => AvailableFoodState.succes(
              index: index,
              indexCategory: indexCategory,
              description: description)),
    );
  }

  changeName(
      {required int index,
      required int indexCategory,
      required String productId,
      required String name}) async {
    emit(AvailableFoodState.loadingSetName());
    final result = await foodRepository
        .changeName(Filter(setName: name, productId: productId));
    return emit(
      result.when(
          failure: (failure) {
            return failure!.maybeWhen(
                wrongCredentials: (data) =>
                    const AvailableFoodState.error(ErrorState.unAuthrized()),
                orElse: () => const AvailableFoodState.error(
                    ErrorState.other(message: "")),
                network: (message) => const AvailableFoodState.error(
                    ErrorState.networkError(message: '')));
          },
          success: (success) => AvailableFoodState.succes(
              index: index, indexCategory: indexCategory, name: name)),
    );
  }
}
