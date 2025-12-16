import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../app/locator.dart';
import '../../../app/theme.dart';
import '../../../domain/entity/food_entity/food_entity.dart';
import '../../../utils.dart';
import '../cubit/available_cubit/available_food_cubit.dart';

class BottomSheetEdit extends HookWidget {
  const BottomSheetEdit({
    required this.food,
    required this.index,
    required this.onSucces,
    required this.indexCategory,
    super.key,
  });

  final Products food;
  final int index;
  final int indexCategory;
  final Function({
    required int index,
    required int indexCategory,
    required bool? state,
    required int? price,
    required String? description,
    required String? name,
  }) onSucces;

  @override
  Widget build(BuildContext context) {
    final controller = usePageController(keepPage: true);
    final description = useTextEditingController(text: food.description);
    final price = useTextEditingController(text: food.price.toString());
    final name = useTextEditingController(text: food.name);
    return BlocProvider(
      create: (context) => AvailableFoodCubit(sl()),
      child: BlocListener<AvailableFoodCubit, AvailableFoodState>(
        listener: (context, state) {
          state.whenOrNull(
            succes: (index, indexCategory, state, price, description,
                scheduling, name) {
              context.pop();
              onSucces(
                index: index,
                indexCategory: indexCategory,
                state: state,
                price: price,
                name: name,
                description: description,
              );
            },
          );
        },
        child: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              // key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SmoothPageIndicator(
                    controller: controller,
                    count: 3,
                    effect: SlideEffect(
                        dotHeight: 1.h,
                        dotWidth: 1.h,
                        activeDotColor: AppTheme.secondaryColor,
                        dotColor: AppTheme.lightRed),
                  ),
                  SizedBox(
                    height: 25.h,
                    child: PageView(
                      controller: controller,
                      children: [
                        Column(mainAxisSize: MainAxisSize.min, children: [
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            "تعديل الأسم",
                            style: TextStyle(fontSize: 17.dp),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          TextFormField(
                            controller: name,
                            decoration: InputDecoration(
                              label: Text("الأسم"),
                            ),
                            validator: fieldValidator,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          BlocBuilder<AvailableFoodCubit, AvailableFoodState>(
                            builder: (context, state) {
                              return SizedBox(
                                width: double.infinity,
                                child: TextButton(
                                    onPressed: () {
                                      if (State ==
                                          AvailableFoodState.loadingSetName()) {
                                        return;
                                      }
                                      context
                                          .read<AvailableFoodCubit>()
                                          .changeName(
                                              index: index,
                                              indexCategory: indexCategory,
                                              productId: food.id ?? "",
                                              name: name.text);
                                    },
                                    child: state.maybeWhen(
                                      orElse: () => Text(
                                        "تعديل",
                                        style: TextStyle(
                                          fontSize: 14.dp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      loadingSetName: () =>
                                          LoadingAnimationWidget
                                              .threeRotatingDots(
                                                  color:
                                                      AppTheme.secondaryColor,
                                                  size: 20.dp),
                                    ),
                                    style: TextButton.styleFrom(
                                      foregroundColor: AppTheme.secondaryColor,
                                      backgroundColor: AppTheme.lightRed,
                                    )),
                              );
                            },
                          ),
                        ]),
                        Column(mainAxisSize: MainAxisSize.min, children: [
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            "تعديل الوصف",
                            style: TextStyle(fontSize: 17.dp),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          TextFormField(
                            maxLines: 2,
                            controller: description,
                            decoration: InputDecoration(
                              label: Text("الوصف"),
                            ),
                            validator: fieldValidator,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          BlocBuilder<AvailableFoodCubit, AvailableFoodState>(
                            builder: (context, state) {
                              return SizedBox(
                                width: double.infinity,
                                child: TextButton(
                                    onPressed: () {
                                      if (State ==
                                          AvailableFoodState
                                              .loadingSetDescription()) {
                                        return;
                                      }
                                      context
                                          .read<AvailableFoodCubit>()
                                          .changeDescription(
                                              index: index,
                                              indexCategory: indexCategory,
                                              productId: food.id ?? "",
                                              description: description.text);
                                    },
                                    child: state.maybeWhen(
                                      orElse: () => Text(
                                        "تعديل",
                                        style: TextStyle(
                                          fontSize: 14.dp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      loadingSetDescription: () =>
                                          LoadingAnimationWidget
                                              .threeRotatingDots(
                                                  color:
                                                      AppTheme.secondaryColor,
                                                  size: 20.dp),
                                    ),
                                    style: TextButton.styleFrom(
                                      foregroundColor: AppTheme.secondaryColor,
                                      backgroundColor: AppTheme.lightRed,
                                    )),
                              );
                            },
                          ),
                        ]),
                        Column(mainAxisSize: MainAxisSize.min, children: [
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            "تعديل السعر",
                            style: TextStyle(fontSize: 17.dp),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          TextFormField(
                            controller: price,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              suffix: Text("دج"),
                              label: Text("السعر"),
                            ),
                            validator: fieldValidator,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          BlocBuilder<AvailableFoodCubit, AvailableFoodState>(
                            builder: (context, State) {
                              return SizedBox(
                                width: double.infinity,
                                child: TextButton(
                                  onPressed: () {
                                    if (State ==
                                        AvailableFoodState.loadingSetPrice()) {
                                      return;
                                    }
                                    context
                                        .read<AvailableFoodCubit>()
                                        .changePrice(
                                          index: index,
                                          indexCategory: indexCategory,
                                          productId: food.id ?? "",
                                          price: int.parse(price.text),
                                        );
                                  },
                                  style: TextButton.styleFrom(
                                      backgroundColor: AppTheme.lightRed,
                                      foregroundColor: AppTheme.secondaryColor),
                                  child: State.maybeWhen(
                                      orElse: () => Text(
                                            "تعديل",
                                            style: TextStyle(
                                              color: Color(0xffef2f55),
                                              fontSize: 14.dp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                      loadingSetPrice: () =>
                                          LoadingAnimationWidget
                                              .threeRotatingDots(
                                                  color:
                                                      AppTheme.secondaryColor,
                                                  size: 20.dp)),
                                ),
                              );
                            },
                          ),
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
