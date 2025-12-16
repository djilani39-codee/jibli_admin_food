import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      color: Colors.black.withOpacity(0.10000000149011612),
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
                          print(await FirebaseMessaging.instance.getToken());
                          context
                              .read<BottomNavigationCubit>()
                              .controller
                              .jumpToPage(2);
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
