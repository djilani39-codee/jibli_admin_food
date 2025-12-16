import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:go_router/go_router.dart';
import 'package:jibli_admin_food/domain/entity/food_entity/food_entity.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../../app/locator.dart';
import '../../../app/theme.dart';
import '../cubit/available_cubit/available_food_cubit.dart';
import '../cubit/food_cubit.dart';
import 'bottom_sheet_edit_food.dart';
import 'bottom_sheet_scheduling.dart';

class FoodItem extends StatelessWidget {
  const FoodItem(
      {super.key,
      required this.food,
      required this.index,
      required this.indexCategory});

  final Products food;
  final int index;
  final int indexCategory;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AvailableFoodCubit(sl()),
      child: BlocListener<AvailableFoodCubit, AvailableFoodState>(
        listener: (context, state) {
          state.whenOrNull(
            succes: (index, indexCategory, state, price, description,
                scheduling, name) {
              context.read<FoodCubit>().update(
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
        child: InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: AppTheme.primaryColor,
              elevation: 0,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15))),
              builder: (_) => BottomSheetEdit(
                food: food,
                onSucces: (
                    {required description,
                    required index,
                    required indexCategory,
                    required price,
                    required name,
                    required state}) {
                  context.read<FoodCubit>().update(
                      index: index,
                      indexCategory: indexCategory,
                      state: state,
                      price: price,
                      name: name,
                      scheduling: null,
                      description: description);
                },
                index: index,
                indexCategory: indexCategory,
              ),
            );
          },
          child: Container(
            width: double.infinity,
            height: 29.h,
            margin: EdgeInsets.only(bottom: 1.h),
            padding: const EdgeInsets.all(10),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 0.50, color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "الرقم"
                      " : "
                      '${food.id}',
                      style: TextStyle(
                        fontSize: 12.dp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                        onTap: () {
                          if (food.availableTime == null ||
                              food.availableTime == "null") {
                            AwesomeDialogScheduling(context, () {}).show();
                            return;
                          } else {
                            AwesomeDialogSchedulingEdit(context, () {}).show();
                            return;
                          }
                        },
                        child: Text(
                          food.availableTime == null ||
                                  food.availableTime == 'null'
                              ? "جدولة"
                              : "مجدول",
                          style: TextStyle(
                              fontSize: 12.dp, color: AppTheme.secondaryColor),
                        )),
                    SizedBox(
                      width: 2.h,
                    ),
                    Row(
                      children: [
                        Text(
                          food.available ?? true ? "متوفر" : 'غير متوفر',
                          style: TextStyle(
                            color: AppTheme.gray2,
                            fontSize: 10.dp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        BlocBuilder<AvailableFoodCubit, AvailableFoodState>(
                          builder: (context, state) {
                            return state.maybeWhen(
                              orElse: () => Transform.scale(
                                scale: 0.6,
                                child: Switch(
                                  activeColor: AppTheme.primaryColor,
                                  inactiveTrackColor: AppTheme.lightRed,
                                  activeTrackColor: AppTheme.secondaryColor,
                                  value: food.available!,
                                  onChanged: (value) {
                                    if (AvailableFoodState.loading() == state) {
                                      return;
                                    }
                                    context
                                        .read<AvailableFoodCubit>()
                                        .changeStatus(
                                          index: index,
                                          indexCategory: indexCategory,
                                          productId: food.id!,
                                          state: value,
                                        );
                                  },
                                ),
                              ),
                              loading: () => SizedBox(
                                height: 5.h,
                                width: 5.h,
                                child: LoadingAnimationWidget.progressiveDots(
                                    color: AppTheme.secondaryColor,
                                    size: 20.dp),
                              ),
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Divider(
                    thickness: 0.50,
                    color: Color(0xFFE1E1E1),
                  ),
                ),

                Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: food.image?.url ?? '',
                      imageBuilder: (context, imageProvider) => Container(
                        width: 11.h,
                        height: 13.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey.shade200,
                        highlightColor: Colors.grey.shade50,
                        child: Container(
                          width: 11.h,
                          height: 13.h,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      errorWidget: (_, __, ___) => Container(
                        width: 11.h,
                        height: 13.h,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            food.name ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14.dp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Row(
                            children: [
                              Text(
                                "الوصف"
                                " : ",
                                style: TextStyle(
                                  fontSize: 12.dp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  food.description ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: AppTheme.gray2,
                                    fontSize: 12.dp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Row(
                            children: [
                              Text(
                                "السعر"
                                " : ",
                                style: TextStyle(
                                    fontSize: 12.dp,
                                    fontWeight: FontWeight.w700),
                              ),
                              BlocBuilder<AvailableFoodCubit,
                                  AvailableFoodState>(
                                builder: (context, Availablestate) {
                                  return Availablestate.maybeWhen(
                                    orElse: () => Text(
                                      "${food.price}"
                                      " دج ",
                                      style: TextStyle(
                                        color: AppTheme.secondaryColor,
                                        fontSize: 14.dp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    // SuccesSetPrice:
                                    //     (ind, indexFood, price, productId) {
                                    //   // SmartDialog.dismiss();
                                    //   // smartToast(msg: "تم تعديل السعر بنجاح");
                                    //   if (food.id ==
                                    //       productId) {
                                    //     food.price = price;
                                    //   }
                                    //   return Text(
                                    //     "${food.price}"
                                    //     " دج ",
                                    //     style: TextStyle(
                                    //       color: AppTheme.secondaryColor,
                                    //       fontSize: 14.dp,
                                    //       fontWeight: FontWeight.w500,
                                    //     ),
                                    //   );
                                    // },
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // SizedBox(
                //   height: .5.h,
                // ),
                const SizedBox(
                  width: double.infinity,
                  child: Divider(
                    thickness: 0.50,
                    color: Color(0xFFE1E1E1),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AwesomeDialog AwesomeDialogScheduling(
      BuildContext context, Function() onTap) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      animType: AnimType.rightSlide,
      title: 'تساؤل',
      desc:
          "هل تريد جدولة هذه الأكلة؟,بحيث يتيح ذلك عدم تلقي الطلبات خارح الأوقات المجدولة عليه",
      // btnCancelOnPress: () {},
      btnOkText: "جدولة",
      btnOkColor: AppTheme.lightRed,
      buttonsTextStyle: TextStyle(
          fontSize: 18.dp,
          fontWeight: FontWeight.bold,
          color: AppTheme.secondaryColor),

      btnOkOnPress: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: AppTheme.primaryColor,
          elevation: 0,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15), topLeft: Radius.circular(15))),
          builder: (_) => BottomSheetScheduling(
            food: food,
            onSucces: (
                {required description,
                required index,
                required indexCategory,
                required price,
                required name,
                required String? scheduling,
                required state}) {
              context.read<FoodCubit>().update(
                  index: index,
                  indexCategory: indexCategory,
                  state: state,
                  price: price,
                  name: name,
                  scheduling: scheduling,
                  description: description);
            },
            index: index,
            indexCategory: indexCategory,
          ),
        );
      },
      // btnCancelOnPress: () {},
    );
  }

  AwesomeDialog AwesomeDialogSchedulingEdit(
      BuildContext context, Function() onTap) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      animType: AnimType.rightSlide,
      title: 'تساؤل',
      desc:
          "هل تريد جدولة هذه الأكلة؟,بحيث يتيح ذلك عدم تلقي الطلبات خارح الأوقات المجدولة عليه",
      // btnCancelOnPress: () {},
      btnOkText: "جدولة",
      btnOkColor: AppTheme.lightRed,
      buttonsTextStyle: TextStyle(
          fontSize: 18.dp,
          fontWeight: FontWeight.bold,
          color: AppTheme.secondaryColor),
      btnCancel: BlocConsumer<AvailableFoodCubit, AvailableFoodState>(
        listener: (context, state) {
          state.whenOrNull(
            succes: (index, indexCategory, state, price, description,
                scheduling, name) {
              context.pop();
              context.read<FoodCubit>().update(
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
        builder: (context, state) {
          return BlocBuilder<AvailableFoodCubit, AvailableFoodState>(
            builder: (context, state) {
              return TextButton(
                child: state.maybeWhen(
                  orElse: () => Text(
                    "إلغاءالجدولة",
                    style: TextStyle(
                        fontSize: 16.dp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  loadingScheduling: () =>
                      LoadingAnimationWidget.threeRotatingDots(
                          color: Colors.white, size: 20.dp),
                ),
                onPressed: () {
                  if (State == AvailableFoodState.loadingScheduling()) {
                    return;
                  }
                  context.read<AvailableFoodCubit>().changeScheduling(
                      index: index,
                      indexCategory: indexCategory,
                      productId: food.id ?? "",
                      scheduling: 'null');
                },
              );
            },
          );
        },
      ),
      btnOkOnPress: () {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: AppTheme.primaryColor,
            elevation: 0,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15))),
            builder: (_) => BottomSheetScheduling(
                food: food,
                onSucces: (
                    {required description,
                    required index,
                    required indexCategory,
                    required price,
                    required name,
                    required String? scheduling,
                    required state}) {
                  context.read<FoodCubit>().update(
                      index: index,
                      indexCategory: indexCategory,
                      state: state,
                      price: price,
                      name: name,
                      scheduling: scheduling,
                      description: description);
                },
                index: index,
                indexCategory: indexCategory));
      },
    );
  }
}
