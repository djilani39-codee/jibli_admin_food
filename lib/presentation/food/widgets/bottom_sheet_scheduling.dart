import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../app/locator.dart';
import '../../../app/theme.dart';
import '../../../domain/entity/food_entity/food_entity.dart';
import '../../../utils.dart';
import '../cubit/available_cubit/available_food_cubit.dart';

class BottomSheetScheduling extends HookWidget {
  const BottomSheetScheduling({
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
    required String? scheduling,
    required String? name,
  }) onSucces;

  @override
  Widget build(BuildContext context) {
    final afterHour = useTextEditingController(
        text: food.availableTime != null
            ? food.availableTime!.startsWith("<")
                ? ""
                : food.availableTime?.split(">").last
            : "");
    final beforeHour = useTextEditingController(
        text: food.availableTime != null
            ? food.availableTime!.startsWith("<")
                ? food.availableTime?.split(">").last
                : ""
            : "");

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
                  scheduling: scheduling,
                  description: description);
            },
          );
        },
        child: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              // key: _formKey,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  "جدولة الأكلة",
                  style: TextStyle(fontSize: 17.dp),
                ),
                SizedBox(
                  height: 2.h,
                ),
                TextFormField(
                  controller: afterHour,
                  decoration: InputDecoration(
                      label: Text("قبل الساعة"), hintText: "مثال : 12 :20"),
                  // keyboardType: TextInputType.datetime,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(5),
                  ],
                  validator: fieldValidator,
                ),
                SizedBox(
                  height: 1.h,
                ),
                TextFormField(
                  controller: beforeHour,
                  decoration: InputDecoration(
                      label: Text("بعد الساعة"), hintText: "مثال : 30 :20"),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(5),
                  ],
                  validator: fieldValidator,
                ),
                SizedBox(
                  height: 1.h,
                ),
                BlocBuilder<AvailableFoodCubit, AvailableFoodState>(
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      child: TextButton(
                          onPressed: () {
                            if (State ==
                                AvailableFoodState.loadingScheduling()) {
                              return;
                            }
                            if (afterHour.text.isEmpty &&
                                beforeHour.text.isEmpty) {
                              smartToast(msg: "الرجاء ملءاحدى الحقول");
                              return;
                            }
                            if (afterHour.text.isNotEmpty &&
                                beforeHour.text.isNotEmpty) {
                              smartToast(msg: "الرجاء ملء حقل واحد");
                              return;
                            }

                            if (afterHour.text.isNotEmpty) {
                              context
                                  .read<AvailableFoodCubit>()
                                  .changeScheduling(
                                      index: index,
                                      indexCategory: indexCategory,
                                      productId: food.id ?? "",
                                      scheduling: ">" + afterHour.text);

                              return;
                            }
                            if (beforeHour.text.isNotEmpty) {
                              context
                                  .read<AvailableFoodCubit>()
                                  .changeScheduling(
                                      index: index,
                                      indexCategory: indexCategory,
                                      productId: food.id ?? "",
                                      scheduling: "<" + beforeHour.text);

                              return;
                            }
                          },
                          child: state.maybeWhen(
                            orElse: () => Text(
                              "جدولة",
                              style: TextStyle(
                                fontSize: 14.dp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            loadingScheduling: () =>
                                LoadingAnimationWidget.threeRotatingDots(
                                    color: AppTheme.secondaryColor,
                                    size: 20.dp),
                          ),
                          style: TextButton.styleFrom(
                            foregroundColor: AppTheme.secondaryColor,
                            backgroundColor: AppTheme.lightRed,
                          )),
                    );
                  },
                ),
                SizedBox(
                  height: 1.h,
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
