import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:jibli_admin_food/app/theme.dart';
import 'package:jibli_admin_food/core/filter.dart';
import 'package:jibli_admin_food/presentation/food/cubit/available_cubit/available_food_cubit.dart';
import 'package:jibli_admin_food/presentation/food/cubit/food_cubit.dart';
import 'package:jibli_admin_food/presentation/food/cubit/food_filter_cubit.dart';
import 'package:jibli_admin_food/presentation/food/screens/add_product_screen.dart';
import 'package:jibli_admin_food/presentation/food/widgets/food_item.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class FoodScreen extends HookWidget {
  const FoodScreen({super.key});

  Widget build(BuildContext context) {
    // Unused controllers removed

    return MultiBlocListener(
      listeners: [
        BlocListener<FoodCubit, FoodState>(
          listener: (context, state) {
            state.whenOrNull(
              // loaded: (data, pageKey) => cubit.pagingController.appendPage(
              //       data,
              //       pageKey,
              //     ),
              lastPageLoaded: (data) => context
                  .read<FoodFilterCubit<Item>>()
                  .changeItem(Item(index: 0, item: data.first.categoryId!)),
              // error: (error) => cubit.pagingController.error = error
            );
          },
        ),
        BlocListener<AvailableFoodCubit, AvailableFoodState>(
          listener: (context, state) {
            state.whenOrNull();
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("قائمة المأكولات"),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddProductScreen(),
                  ),
                ).then((result) {
                  if (result == true) {
                    // تأخير صغير للانتظار من السرفر
                    Future.delayed(Duration(milliseconds: 500), () {
                      context.read<FoodCubit>().load(filter: Filter());
                    });
                  }
                });
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<FoodCubit, FoodState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => SizedBox(),
                loading: () => Center(
                  child: LoadingAnimationWidget.threeRotatingDots(
                      color: AppTheme.secondaryColor, size: 30.dp),
                ),
                lastPageLoaded: (Foods) => Center(
                  child: RefreshIndicator(
                    color: AppTheme.secondaryColor,
                    onRefresh: () async {
                      context.read<FoodCubit>().load(filter: Filter());
                    },
                    child: Column(
                      children: [
                        BlocBuilder<FoodCubit, FoodState>(
                          builder: (context, state) {
                            return state.maybeWhen(
                              orElse: () => SizedBox(),
                              lastPageLoaded: (foods) =>
                                  BlocBuilder<FoodFilterCubit<Item>, Item?>(
                                builder: (context, state) {
                                  return SizedBox(
                                    height: 7.h,
                                    child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) =>
                                            FilterChip(
                                              label: Text(
                                                foods[index].categoryName ?? "",
                                                style: TextStyle(
                                                    fontSize: 14.dp,
                                                    fontWeight: FontWeight.w500,
                                                    color: state?.item ==
                                                            foods[index]
                                                                .categoryId
                                                        ? AppTheme
                                                            .secondaryColor
                                                        : Colors.black),
                                              ),
                                              backgroundColor:
                                                  Colors.transparent,
                                              selected: state?.item ==
                                                  foods[index].categoryId,
                                              selectedColor: AppTheme.lightRed,
                                              showCheckmark: false,
                                              shape: StadiumBorder(
                                                  side: BorderSide(
                                                width: 1,
                                                color: state?.item ==
                                                        foods[index].categoryId
                                                    ? Colors.transparent
                                                    : Colors.grey.shade400,
                                              )),
                                              onSelected: (bool value) {
                                                context
                                                    .read<
                                                        FoodFilterCubit<Item>>()
                                                    .changeItem(Item(
                                                        index: index,
                                                        item: foods[index]
                                                            .categoryId!));
                                              },
                                            ),
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                              width: 1.h,
                                            ),
                                        itemCount: foods.length),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Expanded(
                          child: BlocBuilder<FoodCubit, FoodState>(
                            builder: (context, state) {
                              return state.maybeWhen(
                                orElse: () => SizedBox(),
                                lastPageLoaded: (foods) =>
                                    BlocBuilder<FoodFilterCubit<Item>, Item?>(
                                  builder: (context, state) {
                                    return ListView.separated(
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (context, index) =>
                                            FoodItem(
                                                indexCategory:
                                                    state?.index ?? 0,
                                                food: foods[state?.index ?? 0]
                                                    .products![index],
                                                index: index),
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                              width: 1.h,
                                            ),
                                        itemCount: foods[state?.index ?? 0]
                                                .products
                                                ?.length ??
                                            0);
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          color: Colors.transparent,
                          height: 9.h,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
