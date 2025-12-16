import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jibli_admin_food/core/bloc/error.dart';
import 'package:jibli_admin_food/core/filter.dart';
import 'package:jibli_admin_food/domain/entity/food_entity/food_entity.dart';
import 'package:jibli_admin_food/domain/repository/food_repository.dart';

part 'food_state.dart';

part 'food_cubit.freezed.dart';

class FoodCubit extends Cubit<FoodState> {
  FoodCubit(this.foodRepository) : super(FoodState.initial());
  final PagingController<int, FoodEntity> pagingController =
      PagingController(firstPageKey: 1);
  final FoodRepository foodRepository;
  List<FoodEntity> foods = [];

  load({required Filter filter}) async {
    foods.clear();
    emit(const FoodState.loading());
    final result = await foodRepository.load(filter);
    return emit(
      result.when(
        failure: (failure) {
          return failure!.maybeWhen(
            wrongCredentials: (data) => const FoodState.error(
              ErrorState.unAuthrized(),
            ),
            orElse: () => const FoodState.error(
              ErrorState.other(message: ""),
            ),
            network: (message) =>
                const FoodState.error(ErrorState.networkError(message: '')),
          );
        },
        success: (success) {
          foods.addAll(success!.data ?? []);
          if (success.data!.isEmpty) {
            return const FoodState.loaded(Foods: []);
          }

          // if (!success.more) {
          return FoodState.lastPageLoaded(Foods: success.data!);
          //}
          // return FoodState.loaded(
          //     transaction: success.data, pageKey: pagingController.nextPageKey);
        },
      ),
    );
  }

  update(
      {required int index,
      required int indexCategory,
      required bool? state,
      required int? price,
      required String? description,
      required String? scheduling,
      required String? name}) {
    if (state != null) {
      foods[indexCategory].products![index].available = state;
      emit(const FoodState.loading());
      return emit(FoodState.lastPageLoaded(Foods: List.from(foods)));
    }
    if (price != null) {
      foods[indexCategory].products![index].price = price;
      emit(const FoodState.loading());
      return emit(FoodState.lastPageLoaded(Foods: List.from(foods)));
    }
    if (description != null) {
      foods[indexCategory].products![index].description = description;
      emit(const FoodState.loading());
      return emit(FoodState.lastPageLoaded(Foods: List.from(foods)));
    }
    if (name != null) {
      foods[indexCategory].products![index].name = name;
      emit(const FoodState.loading());
      return emit(FoodState.lastPageLoaded(Foods: List.from(foods)));
    }
    foods[indexCategory].products![index].availableTime = scheduling;
    emit(const FoodState.loading());
    return emit(FoodState.lastPageLoaded(Foods: List.from(foods)));
  }
}
