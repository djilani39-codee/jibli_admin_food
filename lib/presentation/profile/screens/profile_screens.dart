import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:go_router/go_router.dart';
import 'package:jibli_admin_food/app/locator.dart';
import 'package:jibli_admin_food/app/router.dart';
import 'package:jibli_admin_food/app/theme.dart';
import 'package:jibli_admin_food/core/filter.dart';
import 'package:jibli_admin_food/data/local_data_source/local_data_keys.dart';
import 'package:jibli_admin_food/data/local_data_source/local_data_source.dart';
import 'package:jibli_admin_food/domain/entity/fast_food_entity/fast_food_response.dart';
import 'package:jibli_admin_food/presentation/cubit/other_cubit.dart';
import 'package:jibli_admin_food/utils.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure any global SmartDialog overlay is dismissed so taps work
    try {
      SmartDialog.dismiss();
    } catch (_) {}
    FastFoodEntity? user = sl<LocalDataSource>().getValue(LocalDataKeys.user);
    final savedTopic = sl<LocalDataSource>().getValue<String>(LocalDataKeys.restaurantTopic);

    return BlocProvider(
      create: (context) => OtherCubit(sl()),
      child: BlocListener<OtherCubit, OtherState>(
        listener: (context, state) {
          state.whenOrNull(
            success: (msg) {
              smartToast(msg: "تم تغببر حالة المحل");
            },
          );
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("بروفايل المطعم"),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 1.h,
                  ),
                  ProfileHeadline(
                    user: user!,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const ProfileBanner(),
                          SizedBox(
                            height: 2.h,
                          ),
                          ListTile(
                            onTap: () async {
                              context.pushNamed(Routes.workDays.name);
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            tileColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),

                            title: Text(
                              'مواقيت العمل',
                              style: TextStyle(
                                  fontSize: 14.dp, fontWeight: FontWeight.w700),
                            ),
                            // subtitle: Text(
                            //   "Contact_support_to_report_problems_within_the_platform"
                            //       ,
                            //   style: TextStyle(
                            //       fontSize: 12.dp, fontWeight: FontWeight.w300),
                            // ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                              color: AppTheme.gray,
                            ),
                          ),

                          SizedBox(
                            height: 1.h,
                          ),
                          ListTile(
                            onTap: () async {},
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            tileColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),

                            title: Text(
                              "الأجازة",
                              style: TextStyle(
                                  fontSize: 14.dp, fontWeight: FontWeight.w700),
                            ),
                            // subtitle: Text(
                            //   "Contact_support_to_report_problems_within_the_platform"
                            //       ,
                            //   style: TextStyle(
                            //       fontSize: 12.dp, fontWeight: FontWeight.w300),
                            // ),
                            trailing: SizedBox(
                              width: 4.h,
                              height: 4.h,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: BlocBuilder<OtherCubit, OtherState>(
                                  builder: (context, state) {
                                    return state.maybeMap(
                                      orElse: () {
                                        FastFoodEntity? user =
                                            sl<LocalDataSource>()
                                                .getValue(LocalDataKeys.user);
                                        return Switch(
                                          activeColor: AppTheme.primaryColor,
                                          inactiveTrackColor: AppTheme.lightRed,
                                          activeTrackColor:
                                              AppTheme.secondaryColor,
                                          value:
                                              user?.markets?.first.onVacation ??
                                                  false,
                                          onChanged: (value) {
                                            print(value);
                                            context
                                                .read<OtherCubit>()
                                                .onVacation(
                                                  filter:
                                                      Filter(onVaction: value),
                                                );
                                          },
                                        );
                                      },
                                      loading: (value) => Padding(
                                        padding: EdgeInsets.only(left: 8),
                                        child: LoadingAnimationWidget
                                            .progressiveDots(
                                                color: AppTheme.secondaryColor,
                                                size: 20.dp),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 1.h,
                          ),
                          ListTile(
                            onTap: () async {
                              final topic = savedTopic ??
                                  user.markets?.first.topicNotification ??
                                  'غير متوفر';
                              await Clipboard.setData(ClipboardData(text: topic));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('تم نسخ التوبيك: $topic')),
                              );
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            tileColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),

                            title: Text(
                              "توبيك الإشعارات",
                              style: TextStyle(
                                  fontSize: 14.dp, fontWeight: FontWeight.w700),
                            ),
                            subtitle: Text(
                              savedTopic ?? user.markets?.first.topicNotification ??
                                  'غير متوفر',
                              style: TextStyle(
                                  fontSize: 12.dp, fontWeight: FontWeight.w300),
                            ),
                            trailing: const Icon(
                              Icons.copy,
                              size: 20,
                              color: AppTheme.gray,
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          ListTile(
                            onTap: () async {
                              FirebaseMessaging.instance.unsubscribeFromTopic(
                                  user.markets?.first.topicNotification ??
                                      "jibl");
                              await sl<LocalDataSource>()
                                  .clear()
                                  .then((value) async {
                                context.goNamed(Routes.logIn.name);
                                sl<Dio>().options.queryParameters.clear();
                              });
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            tileColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),

                            title: Text(
                              "تسجيل الخروج",
                              style: TextStyle(
                                  fontSize: 14.dp, fontWeight: FontWeight.w700),
                            ),
                            // subtitle: Text(
                            //   "Contact_support_to_report_problems_within_the_platform"
                            //       ,
                            //   style: TextStyle(
                            //       fontSize: 12.dp, fontWeight: FontWeight.w300),
                            // ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                              color: AppTheme.gray,
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                        ],
                      ),
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

class ProfileHeadline extends StatelessWidget {
  const ProfileHeadline({required this.user, Key? key}) : super(key: key);
  final FastFoodEntity user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CachedNetworkImage(
          imageUrl: user.markets?.first.image?.icon ?? "",
          imageBuilder: (context, imageProvider) => Container(
            width: 13.h,
            height: 13.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
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
              width: 13.w,
              height: 13.w,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          errorWidget: (_, __, ___) => Container(
            width: 13.w,
            height: 13.w,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(
          height: 1.h,
        ),
        Text(
          user.markets?.first.marketName ?? "",
          style: TextStyle(fontSize: 20.dp),
        ),
        SizedBox(
          height: .5.h,
        ),
        Text(
          user.markets?.first.marketPhone ?? "",
          style: TextStyle(fontSize: 18.dp),
        )
      ],
    );
  }
}
