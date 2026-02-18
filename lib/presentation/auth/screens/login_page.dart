import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jibli_admin_food/app/locator.dart';
import 'package:jibli_admin_food/app/router.dart';
import 'package:jibli_admin_food/app/theme.dart';
import 'package:jibli_admin_food/core/filter.dart';
import 'package:jibli_admin_food/core/notificaion/notification.dart';
import 'package:jibli_admin_food/presentation/cubit/other_cubit.dart';
import 'package:jibli_admin_food/presentation/main/blocs/main_navigation_cubi.dart';
import 'package:jibli_admin_food/utils.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../data/local_data_source/local_data_keys.dart';
import '../../../data/local_data_source/local_data_source.dart';
import '../../../domain/entity/fast_food_entity/fast_food_response.dart';

class login extends HookWidget {
  const login({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final password = useTextEditingController();
    final email = useTextEditingController();
    return BlocProvider(
      create: (context) => OtherCubit(sl()),
      child: BlocListener<OtherCubit, OtherState>(
        listener: (context, state) {
          state.whenOrNull(
            eroor: (error) {
              error.when(
                networkError: (message) => smartToast(msg: message),
                unAuthrized: () => smartToast(msg: "حدث خطـأ ما"),
                other: (message) => smartToast(msg: message),
              );
            },
            logedIn: () async {
              FastFoodEntity? user =
                  sl<LocalDataSource>().getValue(LocalDataKeys.user);
              final topic = user?.markets?.first.topicNotification ?? "jibl";
              
              // Store the topic for later use
              await sl<LocalDataSource>()
                  .setValue(LocalDataKeys.restaurantTopic, topic);
              
              // ✅ Enable push notifications after successful login
              await safeEnableNotifications();
              
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('تم تسجيل الدخول بنجاح')),
              );
              
              context.read<BottomNavigationCubit>().changeTap(0);
              context.goNamed(Routes.main.name);
            },
          );
        },
        child: Scaffold(
          // backgroundColor: const Color(0xFFE8ECF4),
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: CustomScrollView(slivers: [
              SliverFillRemaining(
                hasScrollBody: true,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Spacer(),
                      Text(
                        "مرحبا بك في جيبلي المحل",
                        style: TextStyle(
                            fontSize: 20.dp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text("نسعد برؤيتك مرة إخرى",
                          style: TextStyle(
                              fontSize: 20.dp, fontWeight: FontWeight.w500)),
                      // SizedBox(
                      //   height: 5.h,
                      // ),
                      Spacer(),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              inputFormatters: [
                                //  LengthLimitingTextInputFormatter(9),
                                //FilteringTextInputFormatter.digitsOnly,
                                // FilteringTextInputFormatter.allow(
                                //   RegExp(r'^\964\s?7\d{2}\s?\d{3}\s?\d{4}'),
                                //  )
                              ],
                              textInputAction: TextInputAction.next,
                              //: TextInputType.phone,
                              decoration: InputDecoration(
                                //label: const Text("phone_number"),
                                hintText: "أدخل الإيمايل",
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return "الرجاء إدخال الإيمايل";
                                }
                                return null;
                              },
                              controller: email,
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Builder(builder: (context) {
                              bool visible = false;
                              return StatefulBuilder(
                                  builder: (context, setState) {
                                return TextFormField(
                                  obscureText: !visible,
                                  style: TextStyle(fontSize: 18.dp),
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    //  labelText: "Password",
                                    hintText: "أدخل كلمة المرور",
                                    suffix: GestureDetector(
                                      onTap: () => setState(() {
                                        visible = !visible;
                                      }),
                                      child: visible
                                          ? const Icon(Ionicons.eye)
                                          : const Icon(Ionicons.eye_off),
                                    ),
                                  ),
                                  controller: password,
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return "الرجاء إدخال كلمة المرور";
                                    }
                                    return null;
                                  },
                                );
                              });
                            }),
                            SizedBox(
                              height: 1.h,
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   height: 4.h,
                      // ),
                      Spacer(),
                      BlocBuilder<OtherCubit, OtherState>(
                        builder: (context, state) {
                          return TextButton(
                              style: TextButton.styleFrom(
                                  fixedSize: Size(100.w, 5.5.h),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5))),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  if (context.read<OtherCubit>().state ==
                                      OtherState.loading()) {
                                    return;
                                  }
                                  context.read<OtherCubit>().login(
                                      filter: Filter(
                                          password: password.text,
                                          email: email.text));
                                }
                              },
                              child: state.maybeWhen(
                                orElse: () => Text(
                                  "تسجيل الدخول",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: AppTheme.lightRed,
                                      fontSize: 15.dp),
                                ),
                                loading: () =>
                                    LoadingAnimationWidget.threeRotatingDots(
                                        color: AppTheme.primaryColor,
                                        size: 20.dp),
                              ));
                        },
                      ),
                      Spacer(
                        flex: 5,
                      )
                    ],
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
