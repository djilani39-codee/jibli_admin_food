import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jibli_admin_food/app/locator.dart';
import 'package:jibli_admin_food/domain/entity/order_entity/order_entity.dart';
import 'package:jibli_admin_food/gen/assets.gen.dart';
import 'package:jibli_admin_food/presentation/orders/cubits/cubit/accepted_rejected_order_cubit.dart';
import 'package:jibli_admin_food/presentation/orders/cubits/cubit/order_bloc.dart';
import 'package:jibli_admin_food/presentation/orders/cubits/order_filter_cubit.dart';
import 'package:jibli_admin_food/presentation/orders/widgets/filter_transaction_widget.dart';
import 'package:jibli_admin_food/utils.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:jibli_admin_food/app/router.dart';
import 'package:jibli_admin_food/app/theme.dart';
import 'package:jibli_admin_food/core/bloc/error.dart';
import 'package:jibli_admin_food/core/enums.dart';
import 'package:jibli_admin_food/core/filter.dart';
import 'package:jibli_admin_food/presentation/widgets/network_error_widget.dart';
import 'package:jibli_admin_food/presentation/widgets/error_widget.dart'
    as error_widget;
import 'package:jibli_admin_food/presentation/widgets/unauthorized_widget.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OrderBloc>();
    final filtecubit = context.read<OrderFilterCubit<StateOrder>>();

    cubit.pagingController.addPageRequestListener((pageKey) {
      cubit.add(OrderEvent.load(
          filter: Filter(
        page: pageKey,
        status: filtecubit.state?.name,
      )));
    });
    return MultiBlocListener(
      listeners: [
        BlocListener<OrderBloc, OrderState>(
          listener: (context, state) {
            state.whenOrNull(
                loaded: (data, pageKey) => cubit.pagingController.appendPage(
                      data,
                      pageKey,
                    ),
                lastPageLoaded: (data) =>
                    cubit.pagingController.appendLastPage(data),
                error: (error) => cubit.pagingController.error = error);
          },
        ),
        BlocListener<OrderFilterCubit<StateOrder>, StateOrder?>(
          listener: (context, state) {
            cubit.pagingController.refresh();
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("الطلبات"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: RefreshIndicator(
              color: AppTheme.secondaryColor,
              onRefresh: () async {
                cubit.pagingController.refresh();
                cubit.nextPage = 1;
              },
              child: Column(
                children: [
                  SizedBox(
                    height: 6.h,
                    child: const FilterTransactionWidget(),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        PagedSliverList<int, OrderEntity>(
                          // itemExtent: 10,
                          pagingController: cubit.pagingController,
                          builderDelegate:
                              PagedChildBuilderDelegate<OrderEntity>(
                            itemBuilder: (context, item, index) => InkWell(
                              onTap: () async {
                                detailsOrder(item: item);
                              },
                              child: item.status == "delivered"
                                  ? CompletedWidget(item: item)
                                  : item.status == "new"
                                      ? pendingWidget(
                                          index: index,
                                          item: item,
                                        )
                                      : item.status == 'accepted'
                                          ? AcceptedWidget(item: item)
                                          : CancelledWidget(
                                              item: item,
                                            ),
                            ),
                            firstPageErrorIndicatorBuilder: (context) => (cubit
                                    .pagingController.error as ErrorState)
                                .when(
                                    unAuthrized: () => UnauthorizedWidget(
                                          tryAgain: () {
                                            context.goNamed(Routes.logIn.name);
                                          },
                                        ),
                                    networkError: (message) =>
                                        NetworkErrorWidget(
                                            tryAgain: () => cubit
                                                .pagingController
                                                .refresh()),
                                    other: (message) =>
                                        error_widget.ErrorWidget(
                                          tryAgain: () =>
                                              cubit.pagingController.refresh(),
                                        )),
                            noItemsFoundIndicatorBuilder: (context) => Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  Assets.icons.emptyData,
                                  width: 150,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  "لا توجد طلبات",
                                  style: TextStyle(fontSize: 18),
                                )
                              ],
                            ),
                            firstPageProgressIndicatorBuilder: (context) =>
                                Center(
                              child: LoadingAnimationWidget.threeRotatingDots(
                                  color: AppTheme.secondaryColor, size: 30.dp),
                            ),
                            newPageProgressIndicatorBuilder: (context) =>
                                const Center(
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                  color: AppTheme.secondaryColor,
                                ),
                              ),
                            ),
                            newPageErrorIndicatorBuilder: (context) =>
                                GestureDetector(
                                    onTap: () {
                                      cubit.pagingController
                                          .retryLastFailedRequest();
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "أعد المحاولة",
                                          style: TextStyle(fontSize: 14.sp),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Icon(
                                          Icons.refresh_rounded,
                                          size: 20,
                                        )
                                      ],
                                    )),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: SizedBox(
                            //  color: Colors.transparent,
                            height: 10.h,
                          ),
                        ),
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

  Future<dynamic> detailsOrder({required OrderEntity item}) {
    return SmartDialog.show(
      alignment: Alignment.center,
      builder: (_) => Container(
        height: item.orders!.length == 1
            ? 26.h
            : item.orders!.length == 2
                ? 2 * 18.h
                : item.orders!.length == 3
                    ? 3 * 15.5.h
                    : 56.h,
        width: 45.h,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 1.h,
            ),
            Text(
              'تفاصيل الطلب',
              style: TextStyle(fontSize: 18.dp),
            ),
            SizedBox(
              width: 40.h,
              child: Divider(),
            ),
            item.orders!.length <= 2
                ? Column(
                    children: [
                      ...item.orders!
                          .map(
                            (e) => Container(
                              width: double.infinity,
                              //  height: 29.h,
                              padding: const EdgeInsets.all(10),
                              margin: EdgeInsets.only(bottom: 1.h),
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      width: 0.50, color: Color(0xFFE0E0E0)),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        e.name ?? "",
                                        style: TextStyle(
                                          fontSize: 13.dp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 2.h,
                                      ),
                                      Text(
                                        "السعر :",
                                        style: TextStyle(
                                          fontSize: 12.dp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Text(
                                        "${e.price ?? ""}" + " دج",
                                        style: TextStyle(
                                          //color: Colors.grey,
                                          fontSize: 12.dp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            top: 8.dp,
                                            left: 6.dp,
                                            right: 6.dp,
                                            bottom: 4.dp),
                                        decoration: BoxDecoration(
                                            color: AppTheme.lightRed,
                                            shape: BoxShape.circle),
                                        child: Text(
                                          "X ${e.quantity}",
                                          style: TextStyle(
                                            // fontSize: 14.dp,
                                            fontWeight: FontWeight.w700,
                                            color: AppTheme.secondaryColor,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  e.options != null && e.options!.isNotEmpty
                                      ? Row(
                                          children: [
                                            ...e.options!
                                                .map(
                                                  (option) => Text(
                                                    option + " , ",
                                                    style: TextStyle(
                                                      // color: AppTheme.gray,
                                                      fontSize: 12.dp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                )
                                                .toList()
                                          ],
                                        )
                                      : Text(
                                          "بدون تخصيص",
                                          style: TextStyle(
                                            //color: Colors.grey,
                                            fontSize: 12.dp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          )
                          .toList()
                    ],
                  )
                : item.orders!.length == 3
                    ? Column(
                        children: [
                          ...item.orders!
                              .map(
                                (e) => Container(
                                  width: double.infinity,
                                  //  height: 29.h,
                                  padding: const EdgeInsets.all(10),
                                  margin: EdgeInsets.only(bottom: 1.h),
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          width: 0.50,
                                          color: Color(0xFFE0E0E0)),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            e.name ?? "",
                                            style: TextStyle(
                                              fontSize: 13.dp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 2.h,
                                          ),
                                          Text(
                                            "السعر :",
                                            style: TextStyle(
                                              fontSize: 12.dp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 2.w,
                                          ),
                                          Text(
                                            "${e.price ?? ""}" + " دج",
                                            style: TextStyle(
                                              //color: Colors.grey,
                                              fontSize: 12.dp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: 8.dp,
                                                left: 6.dp,
                                                right: 6.dp,
                                                bottom: 4.dp),
                                            decoration: BoxDecoration(
                                                color: AppTheme.lightRed,
                                                shape: BoxShape.circle),
                                            child: Text(
                                              "X ${e.quantity}",
                                              style: TextStyle(
                                                // fontSize: 14.dp,
                                                fontWeight: FontWeight.w700,
                                                color: AppTheme.secondaryColor,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      e.options != null && e.options!.isNotEmpty
                                          ? Row(
                                              children: [
                                                ...e.options!
                                                    .map(
                                                      (option) => Text(
                                                        option + " , ",
                                                        style: TextStyle(
                                                          // color: AppTheme.gray,
                                                          fontSize: 12.dp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    )
                                                    .toList()
                                              ],
                                            )
                                          : Text(
                                              "بدون تخصيص",
                                              style: TextStyle(
                                                //color: Colors.grey,
                                                fontSize: 12.dp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                              )
                              .toList()
                        ],
                      )
                    : SizedBox(
                        height: 40.h,
                        child: SingleChildScrollView(
                          dragStartBehavior: DragStartBehavior.down,
                          // controller: controller,
                          child: Column(
                            children: [
                              ...item.orders!
                                  .map(
                                    (e) => Container(
                                      width: double.infinity,
                                      //  height: 29.h,
                                      padding: const EdgeInsets.all(10),
                                      margin: EdgeInsets.only(bottom: 1.h),
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              width: 0.50,
                                              color: Color(0xFFE0E0E0)),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                e.name ?? "",
                                                style: TextStyle(
                                                  fontSize: 13.dp,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 2.h,
                                              ),
                                              Text(
                                                "السعر :",
                                                style: TextStyle(
                                                  fontSize: 12.dp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 2.w,
                                              ),
                                              Text(
                                                "${e.price ?? ""}" + " دج",
                                                style: TextStyle(
                                                  //color: Colors.grey,
                                                  fontSize: 12.dp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(
                                                    top: 8.dp,
                                                    left: 6.dp,
                                                    right: 6.dp,
                                                    bottom: 4.dp),
                                                decoration: BoxDecoration(
                                                    color: AppTheme.lightRed,
                                                    shape: BoxShape.circle),
                                                child: Text(
                                                  "X ${e.quantity}",
                                                  style: TextStyle(
                                                    // fontSize: 14.dp,
                                                    fontWeight: FontWeight.w700,
                                                    color:
                                                        AppTheme.secondaryColor,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          e.options != null &&
                                                  e.options!.isNotEmpty
                                              ? Row(
                                                  children: [
                                                    ...e.options!
                                                        .map(
                                                          (option) => Text(
                                                            option + " , ",
                                                            style: TextStyle(
                                                              // color: AppTheme.gray,
                                                              fontSize: 12.dp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        )
                                                        .toList()
                                                  ],
                                                )
                                              : Text(
                                                  "بدون تخصيص",
                                                  style: TextStyle(
                                                    //color: Colors.grey,
                                                    fontSize: 12.dp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList()
                            ],
                          ),
                        ),
                      ),
            // SizedBox(
            //   height: 1.h,
            // ),
            SizedBox(
              width: 40.h,
              child: Divider(),
            ),
            // SizedBox(
            //   height: 1.h,
            // ),
            Row(
              children: [
                Text(
                  'المبلغ الإجمالي' + " : ",
                  style: TextStyle(fontSize: 18.dp),
                ),
                Text(
                  '${item.paidCash}' + " دج",
                  style: TextStyle(fontSize: 18.dp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class pendingWidget extends StatelessWidget {
  const pendingWidget({
    super.key,
    required this.index,
    required this.item,
  });

  final OrderEntity item;
  final int index;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OrderBloc>();

    return BlocProvider(
      create: (context) => AcceptedRejectedOrderCubit(sl()),
      child:
          BlocListener<AcceptedRejectedOrderCubit, AcceptedRejectedOrderState>(
        listener: (context, state) {
          state.whenOrNull(
            error: (msg, i) => smartToast(msg: msg ?? ""),
            SuccessRejected: (msg) {
              if (cubit.pagingController.itemList != null && index < cubit.pagingController.itemList!.length) {
                final item = cubit.pagingController.itemList![index];
                cubit.pagingController.itemList![index] = OrderEntity(
                  id: item.id,
                  elapsed: item.elapsed,
                  date: item.date,
                  time: item.time,
                  status: "rejected",
                  hint: item.hint,
                  market: item.market,
                  orders: item.orders,
                  wallet: item.wallet,
                  deliveryFee: item.deliveryFee,
                  paidCash: item.paidCash,
                  client: item.client,
                  address: item.address,
                  distance: item.distance,
                  googleMaps: item.googleMaps,
                );
              }
              smartToast(msg: msg ?? "");
            },
            Sucess: (msg) {
              if (cubit.pagingController.itemList != null && index < cubit.pagingController.itemList!.length) {
                final item = cubit.pagingController.itemList![index];
                cubit.pagingController.itemList![index] = OrderEntity(
                  id: item.id,
                  elapsed: item.elapsed,
                  date: item.date,
                  time: item.time,
                  status: "accepted",
                  hint: item.hint,
                  market: item.market,
                  orders: item.orders,
                  wallet: item.wallet,
                  deliveryFee: item.deliveryFee,
                  paidCash: item.paidCash,
                  client: item.client,
                  address: item.address,
                  distance: item.distance,
                  googleMaps: item.googleMaps,
                );
              }
              smartToast(msg: msg ?? "");
            },
          );
        },
        child: Container(
          width: double.infinity,
          // height: 30.h,
          padding: const EdgeInsets.all(10),
          margin: EdgeInsets.only(bottom: 1.h),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 0.50, color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    item.date ?? "",
                    style: TextStyle(
                      fontSize: 12.dp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  BlocBuilder<AcceptedRejectedOrderCubit,
                      AcceptedRejectedOrderState>(
                    buildWhen: (previous, current) => current.maybeWhen(
                      orElse: () => false,
                      Sucess: (msg) => true,
                      SuccessRejected: (msg) => true,
                    ),
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () => Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 249, 227),
                              borderRadius: BorderRadius.circular(4)),
                          padding:
                              EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                          child: Text(
                            'قيدالإننظار',
                            style: TextStyle(
                                color: Color.fromARGB(255, 248, 223, 0)),
                          ),
                        ),
                        Sucess: (msg) => Container(
                          decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(4)),
                          padding:
                              EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                          child: Text(
                            'مقبولة',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                        SuccessRejected: (msg) => Container(
                          decoration: BoxDecoration(
                              color: AppTheme.lightRed,
                              borderRadius: BorderRadius.circular(4)),
                          padding:
                              EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                          child: Text(
                            "مرفوضة",
                            style: TextStyle(color: AppTheme.secondaryColor),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: .5.h,
              ),
              const SizedBox(
                width: double.infinity,
                child: Divider(
                  thickness: 0.50,
                  color: Color(0xFFE1E1E1),
                ),
              ),
              SizedBox(
                height: .5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.client ?? "",
                        style: TextStyle(
                          fontSize: 14.dp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 1.5.h,
                      ),
                      Row(
                        children: [
                          Icon(
                            Iconsax.location,
                            size: 14.dp,
                            color: AppTheme.secondaryColor,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          SizedBox(
                            width: 52.w,
                            child: Text(
                              item.address ?? "",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: AppTheme.gray2,
                                fontSize: 12.dp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1.5.h,
                      ),
                      Row(
                        children: [
                          Icon(
                            Iconsax.clock,
                            size: 14.dp,
                            color: AppTheme.secondaryColor,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Text(
                            item.time ?? "",
                            style: TextStyle(
                              color: AppTheme.gray2,
                              fontSize: 12.dp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  BlocBuilder<AcceptedRejectedOrderCubit,
                      AcceptedRejectedOrderState>(
                    buildWhen: (previous, current) => current.maybeWhen(
                      orElse: () => false,
                      Sucess: (msg) => true,
                    ),
                    builder: (context, state) {
                      return SvgPicture.asset(
                        state.maybeWhen(
                          orElse: () => Assets.icons.orderConfirm,
                          Sucess: (msg) => Assets.icons.orderConfirmed,
                          SuccessRejected: (msg) => Assets.icons.emptyData,
                        ),
                        height: 10.h,
                        width: 10.h,
                      );
                    },
                  )
                ],
              ),
              SizedBox(
                height: .5.h,
              ),
              const SizedBox(
                width: double.infinity,
                child: Divider(
                  thickness: 0.50,
                  color: Color(0xFFE1E1E1),
                ),
              ),
              SizedBox(
                height: .5.h,
              ),
              BlocBuilder<AcceptedRejectedOrderCubit,
                  AcceptedRejectedOrderState>(
                buildWhen: (previous, current) => current.maybeWhen(
                    orElse: () => true, Sucess: (msg) => true),
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () => Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: AppTheme.secondaryColor,
                                // fixedSize: Size(
                                //   42.w,
                                //   5.5.h,
                                // ),
                              ),
                              onPressed: () {
                                context
                                    .read<AcceptedRejectedOrderCubit>()
                                    .accepted(
                                        Filter(
                                            acceptorder:
                                                int.parse('${item.id}')),
                                        index);
                              },
                              child: state.maybeWhen(
                                  loading: () =>
                                      LoadingAnimationWidget.progressiveDots(
                                          color: Colors.white, size: 20.dp),
                                  orElse: () => Text(
                                        "قبول",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.dp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ))),
                        ),
                        SizedBox(
                          width: 1.h,
                        ),
                        Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: AppTheme.lightRed,
                            ),
                            onPressed: () {
                              context
                                  .read<AcceptedRejectedOrderCubit>()
                                  .rejected(
                                      Filter(
                                          rejectOrder: int.parse('${item.id}')),
                                      index);
                            },
                            child: state.maybeWhen(
                              loadingrejected: () =>
                                  LoadingAnimationWidget.progressiveDots(
                                      color: AppTheme.secondaryColor,
                                      size: 20.dp),
                              orElse: () => Text(
                                "رفض",
                                style: TextStyle(
                                  color: AppTheme.secondaryColor,
                                  fontSize: 14.dp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SuccessRejected: (msg) => SizedBox(),
                    Sucess: (msg) => SizedBox(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CompletedWidget extends StatelessWidget {
  const CompletedWidget({
    super.key,
    required this.item,
  });

  final OrderEntity item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      //  height: 29.h,
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 1.h),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.50, color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                item.date ?? "",
                style: TextStyle(
                  fontSize: 12.dp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 228, 253, 241),
                    borderRadius: BorderRadius.circular(4)),
                padding: EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                child: Text(
                  'تم توصيلها',
                  style: TextStyle(color: Colors.green),
                ),
              )
            ],
          ),
          SizedBox(
            height: .5.h,
          ),
          const SizedBox(
            width: double.infinity,
            child: Divider(
              thickness: 0.50,
              color: Color(0xFFE1E1E1),
            ),
          ),
          SizedBox(
            height: .5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.client ?? "",
                    style: TextStyle(
                      fontSize: 14.dp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Row(
                    children: [
                      Icon(
                        Iconsax.location,
                        size: 14.dp,
                        color: AppTheme.secondaryColor,
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      SizedBox(
                        width: 52.w,
                        child: Text(
                          item.address ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppTheme.gray2,
                            fontSize: 12.dp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Row(
                    children: [
                      Icon(
                        Iconsax.clock,
                        size: 14.dp,
                        color: AppTheme.secondaryColor,
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Text(
                        item.time ?? "",
                        style: TextStyle(
                          color: AppTheme.gray2,
                          fontSize: 12.dp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SvgPicture.asset(
                Assets.icons.orderDelivered,
                height: 10.h,
                width: 10.h,
              )
            ],
          ),
          SizedBox(
            height: .5.h,
          ),
          const SizedBox(
            width: double.infinity,
            child: Divider(
              thickness: 0.50,
              color: Color(0xFFE1E1E1),
            ),
          ),
          SizedBox(
            height: .5.h,
          ),
        ],
      ),
    );
  }
}

class CancelledWidget extends StatelessWidget {
  const CancelledWidget({
    super.key,
    required this.item,
  });

  final OrderEntity item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      //  height: 29.h,
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 1.h),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.50, color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                item.date ?? "",
                style: TextStyle(
                  fontSize: 12.dp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                    color: AppTheme.lightRed,
                    borderRadius: BorderRadius.circular(4)),
                padding: EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                child: Text(
                  "مرفوضة",
                  style: TextStyle(color: AppTheme.secondaryColor),
                ),
              )
            ],
          ),
          SizedBox(
            height: .5.h,
          ),
          const SizedBox(
            width: double.infinity,
            child: Divider(
              thickness: 0.50,
              color: Color(0xFFE1E1E1),
            ),
          ),
          SizedBox(
            height: .5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.client ?? "",
                    style: TextStyle(
                      fontSize: 14.dp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Row(
                    children: [
                      Icon(
                        Iconsax.location,
                        size: 14.dp,
                        color: AppTheme.secondaryColor,
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      SizedBox(
                        width: 52.w,
                        child: Text(
                          item.address ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppTheme.gray2,
                            fontSize: 12.dp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Row(
                    children: [
                      Icon(
                        Iconsax.clock,
                        size: 14.dp,
                        color: AppTheme.secondaryColor,
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Text(
                        item.time ?? "",
                        style: TextStyle(
                          color: AppTheme.gray2,
                          fontSize: 12.dp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SvgPicture.asset(
                Assets.icons.emptyData,
                height: 10.h,
                width: 10.h,
              )
            ],
          ),
          SizedBox(
            height: .5.h,
          ),
          const SizedBox(
            width: double.infinity,
            child: Divider(
              thickness: 0.50,
              color: Color(0xFFE1E1E1),
            ),
          ),
          SizedBox(
            height: .5.h,
          ),
        ],
      ),
    );
  }
}

class AcceptedWidget extends StatelessWidget {
  const AcceptedWidget({
    super.key,
    required this.item,
  });

  final OrderEntity item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      //  height: 29.h,
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 1.h),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.50, color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                item.date ?? "",
                style: TextStyle(
                  fontSize: 12.dp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(4)),
                padding: EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                child: Text(
                  'مقبولة',
                  style: TextStyle(color: Colors.blue),
                ),
              )
            ],
          ),
          SizedBox(
            height: .5.h,
          ),
          const SizedBox(
            width: double.infinity,
            child: Divider(
              thickness: 0.50,
              color: Color(0xFFE1E1E1),
            ),
          ),
          SizedBox(
            height: .5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.client ?? "",
                    style: TextStyle(
                      fontSize: 14.dp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Row(
                    children: [
                      Icon(
                        Iconsax.location,
                        size: 14.dp,
                        color: AppTheme.secondaryColor,
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      SizedBox(
                        width: 52.w,
                        child: Text(
                          item.address ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppTheme.gray2,
                            fontSize: 12.dp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Row(
                    children: [
                      Icon(
                        Iconsax.clock,
                        size: 14.dp,
                        color: AppTheme.secondaryColor,
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Text(
                        item.time ?? "",
                        style: TextStyle(
                          color: AppTheme.gray2,
                          fontSize: 12.dp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SvgPicture.asset(
                Assets.icons.orderConfirmed,
                height: 10.h,
                width: 10.h,
              )
            ],
          ),
          SizedBox(
            height: .5.h,
          ),
          const SizedBox(
            width: double.infinity,
            child: Divider(
              thickness: 0.50,
              color: Color(0xFFE1E1E1),
            ),
          ),
          SizedBox(
            height: .5.h,
          ),
        ],
      ),
    );
  }
}
