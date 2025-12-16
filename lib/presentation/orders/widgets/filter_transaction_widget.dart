import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:jibli_admin_food/app/theme.dart';
import 'package:jibli_admin_food/core/enums.dart';
import 'package:jibli_admin_food/presentation/orders/cubits/order_filter_cubit.dart';

import '../cubits/cubit/order_bloc.dart';

class FilterTransactionWidget extends StatelessWidget {
  const FilterTransactionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderFilterCubit<StateOrder>, StateOrder?>(
      builder: (context, state) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FilterChip(
                label: Text(
                  "الكل",
                  style: TextStyle(
                    fontSize: 14.dp,
                    fontWeight: FontWeight.w500,
                    color:
                        state == null ? AppTheme.secondaryColor : Colors.black,
                  ),
                ),
                selectedColor: AppTheme.lightRed,
                backgroundColor: Colors.transparent,
                selected: state == null,
                showCheckmark: false,
                shape: StadiumBorder(
                    side: BorderSide(
                  width: 1,
                  color:
                      state == null ? Colors.transparent : Colors.grey.shade400,
                )),
                onSelected: (bool value) {
                  if (context.read<OrderBloc>().state == OrderState.loading()) {
                    return;
                  }
                  context.read<OrderFilterCubit<StateOrder>>().changeItem(null);
                },
              ),
              SizedBox(
                width: 1.h,
              ),
              FilterChip(
                label: Text(
                  "قيد الإنتظار",
                  style: TextStyle(
                      fontSize: 14.dp,
                      fontWeight: FontWeight.w500,
                      color: state == StateOrder.New
                          ? AppTheme.secondaryColor
                          : Colors.black),
                ),
                backgroundColor: Colors.transparent,
                selected: state == StateOrder.New,
                selectedColor: AppTheme.lightRed,
                showCheckmark: false,
                shape: StadiumBorder(
                    side: BorderSide(
                  width: 1,
                  color: state == StateOrder.New
                      ? Colors.transparent
                      : Colors.grey.shade400,
                )),
                onSelected: (bool value) {
                  if (context.read<OrderBloc>().state == OrderState.loading()) {
                    return;
                  }
                  context
                      .read<OrderFilterCubit<StateOrder>>()
                      .changeItem(StateOrder.New);
                },
              ),
              SizedBox(
                width: 1.h,
              ),
              FilterChip(
                label: Text(
                  "المقبولة",
                  style: TextStyle(
                      fontSize: 14.dp,
                      fontWeight: FontWeight.w500,
                      color: state == StateOrder.accepted
                          ? AppTheme.secondaryColor
                          : Colors.black),
                ),
                backgroundColor: Colors.transparent,
                selected: state == StateOrder.accepted,
                selectedColor: AppTheme.lightRed,
                showCheckmark: false,
                shape: StadiumBorder(
                    side: BorderSide(
                  width: 1,
                  color: state == StateOrder.accepted
                      ? Colors.transparent
                      : Colors.grey.shade400,
                )),
                onSelected: (bool value) {
                  if (context.read<OrderBloc>().state == OrderState.loading()) {
                    return;
                  }
                  context
                      .read<OrderFilterCubit<StateOrder>>()
                      .changeItem(StateOrder.accepted);
                },
              ),
              SizedBox(
                width: 1.h,
              ),
              FilterChip(
                label: Text(
                  "تم توصيلها",
                  style: TextStyle(
                      fontSize: 14.dp,
                      fontWeight: FontWeight.w500,
                      color: state == StateOrder.delivered
                          ? AppTheme.secondaryColor
                          : Colors.black),
                ),
                backgroundColor: Colors.transparent,
                selectedColor: AppTheme.lightRed,
                selected: state == StateOrder.delivered,
                showCheckmark: false,
                shape: StadiumBorder(
                    side: BorderSide(
                  width: 1,
                  color: state == StateOrder.delivered
                      ? Colors.transparent
                      : Colors.grey.shade400,
                )),
                onSelected: (bool value) {
                  if (context.read<OrderBloc>().state == OrderState.loading()) {
                    return;
                  }
                  context
                      .read<OrderFilterCubit<StateOrder>>()
                      .changeItem(StateOrder.delivered);
                },
              ),
              SizedBox(
                width: 1.h,
              ),
              FilterChip(
                label: Text(
                  "المرفوضة",
                  style: TextStyle(
                      fontSize: 14.dp,
                      fontWeight: FontWeight.w500,
                      color: state == StateOrder.rejected
                          ? AppTheme.secondaryColor
                          : Colors.black),
                ),
                backgroundColor: Colors.transparent,
                selected: state == StateOrder.rejected,
                selectedColor: AppTheme.lightRed,
                showCheckmark: false,
                shape: StadiumBorder(
                    side: BorderSide(
                  width: 1,
                  color: state == StateOrder.rejected
                      ? Colors.transparent
                      : Colors.grey.shade400,
                )),
                onSelected: (bool value) {
                  if (context.read<OrderBloc>().state == OrderState.loading()) {
                    return;
                  }
                  context
                      .read<OrderFilterCubit<StateOrder>>()
                      .changeItem(StateOrder.rejected);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
