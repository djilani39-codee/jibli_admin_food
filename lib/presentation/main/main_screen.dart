import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:jibli_admin_food/utils.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jibli_admin_food/app/theme.dart';
import 'package:jibli_admin_food/presentation/food/screens/food_screens.dart';
import 'package:jibli_admin_food/presentation/orders/screens/orders_screen.dart';
import 'package:jibli_admin_food/presentation/profile/screens/profile_screens.dart';

import 'blocs/main_navigation_cubi.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  void showTokenDialog(BuildContext context, String token) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("FCM Token"),
          content: SelectableText(token),
          actions: [
            TextButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: token));
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("تم نسخ التوكن بنجاح")),
                );
              },
              child: const Text("نسخ وإغلاق"),
            ),
          ],
        );
      },
    );
  }
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: kDebugMode
          ? FloatingActionButton(
        backgroundColor: Colors.red,
        child: const Icon(Icons.bug_report),
        onPressed: () async {
          // 1. إظهار تنبيه للمستخدم بالانتظار
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("جاري الاتصال بخادم APNs... انتظر لحظة")),
          );

          String? apnsToken;

          // 2. محاولة جلب التوكن من أبل لمدة 10 ثوانٍ (محاولة كل ثانية)
          for (int i = 0; i < 10; i++) {
            apnsToken = await FirebaseMessaging.instance.getAPNSToken();
            if (apnsToken != null) break; // إذا وجده يخرج من الحلقة فوراً
            await Future.delayed(const Duration(seconds: 1));
          }

          // 3. إذا حصلنا على توكن أبل، نطلب توكن Firebase
          if (apnsToken != null) {
            String? fcmToken = await FirebaseMessaging.instance.getToken();
            if (fcmToken != null) {
              showTokenDialog(context, fcmToken); // إظهار التوكن النهائي
            }
          } else {
            // 4. إذا فشل بعد 10 ثوانٍ
            showTokenDialog(context,
                "فشل: APNS Token غير جاهز. تأكد من اتصال الإنترنت والموافقة على الإشعارات.");
          }
        },
          )
          : null,
      body: Stack(
        alignment: Alignment(0, 0.87.dp),
        children: [
          PageView(
            controller: context.read<BottomNavigationCubit>().controller,
            onPageChanged: (value) {
              context.read<BottomNavigationCubit>().changeTap(value);
            },
            children: [
              OrdersScreen(),
              FoodScreen(),
              ProfileScreen(),
            ],
          ),
          BlocBuilder<BottomNavigationCubit, int>(
            builder: (context, state) {
              return Container(
                width: 90.w,
                height: 8.5.h,
                padding: EdgeInsets.all(5),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () async {
                          var pendingNotificationRequests =
                              await FlutterLocalNotificationsPlugin()
                                  .getActiveNotifications()
                                  .asStream()
                                  .isBroadcast;
                          print(pendingNotificationRequests);
                          context
                              .read<BottomNavigationCubit>()
                              .controller
                              .jumpToPage(0);
                          context.read<BottomNavigationCubit>().changeTap(0);
                          await FlutterLocalNotificationsPlugin().cancelAll();
                        },
                        child: NavItems(
                          icon: Iconsax.home,
                          label: 'home',
                          focus: state == 0,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          context
                              .read<BottomNavigationCubit>()
                              .controller
                              .jumpToPage(1);
                          context.read<BottomNavigationCubit>().changeTap(1);
                        },
                        child: NavItems(
                          icon: Iconsax.document,
                          label: "المأكولات",
                          focus: state == 1,
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          // Fetch token and show immediate feedback so TestFlight users
                          // can copy it without relying on the debug FAB.
                          String? token;
                          try {
                            token = await FirebaseMessaging.instance.getToken();
                            final preview = token != null && token.length > 10
                                ? token.substring(0, 10) + '...'
                                : (token ?? 'N/A');
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Token preview: $preview')),
                              );
                            }
                            if (token != null && context.mounted) {
                              await showDialog<void>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('FCM Token'),
                                  content: SelectableText(token!),
                                  actions: [
                                    TextButton(
                                      onPressed: () async {
                                        await Clipboard.setData(
                                            ClipboardData(text: token!));
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Copy & Close'),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Close'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Error: $e')));
                            }
                          }

                          // proceed to profile page as before
                          context.read<BottomNavigationCubit>().controller.jumpToPage(2);
                          context.read<BottomNavigationCubit>().changeTap(2);
                        },
                        child: NavItems(
                          icon: Iconsax.user,
                          label: 'البروفايل',
                          focus: state == 2,
                        ),
                      ),
                    ]),
              );
            },
          ),
        ],
      ),
    );
  }
}

class NavItems extends StatelessWidget {
  const NavItems(
      {super.key,
      required this.icon,
      required this.label,
      required this.focus});

  final String label;
  final IconData icon;
  final bool focus;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // focus
        //     ? SvgPicture.asset(Assets.assets_icons_Polygon_1_svg)
        //     :
        SizedBox(
          height: .5.w,
        ),
        SizedBox(
          height: 1.w,
        ),
        Icon(
          icon,
          color: focus ? AppTheme.secondaryColor : null,
        ),
        SizedBox(
          height: 1.w,
        ),
        Text(
          label,
          style: TextStyle(color: focus ? AppTheme.secondaryColor : null),
        )
      ],
    );
  }
}
