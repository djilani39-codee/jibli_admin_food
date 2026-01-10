import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:jibli_admin_food/data/local_data_source/local_data_keys.dart';
import 'package:jibli_admin_food/data/local_data_source/local_data_source.dart';
import 'package:jibli_admin_food/core/notificaion/notification.dart';

import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:jibli_admin_food/app/locator.dart';
import 'package:jibli_admin_food/app/router.dart';
import 'package:jibli_admin_food/app/theme.dart';
import 'package:jibli_admin_food/core/enums.dart';
import 'package:jibli_admin_food/core/extensions/paging_extention.dart';
import 'package:jibli_admin_food/core/filter.dart';
import 'package:jibli_admin_food/main.dart';
import 'package:jibli_admin_food/presentation/food/cubit/available_cubit/available_food_cubit.dart';
import 'package:jibli_admin_food/presentation/food/cubit/food_cubit.dart';
import 'package:jibli_admin_food/presentation/food/cubit/food_filter_cubit.dart';
import 'package:jibli_admin_food/presentation/main/blocs/main_navigation_cubi.dart';
import 'package:jibli_admin_food/presentation/orders/cubits/cubit/accepted_rejected_order_cubit.dart';
import 'package:jibli_admin_food/presentation/orders/cubits/cubit/order_bloc.dart';
import 'package:jibli_admin_food/presentation/orders/cubits/order_filter_cubit.dart';
import 'package:jibli_admin_food/utils.dart';
import 'dart:async';

import '../domain/entity/order_entity/order_entity.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _debugDialogShown = false;
  // Navigator key used to show dialogs from top-level (works with GoRouter)
  final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
  @override
  void initState() {
    super.initState();
    onListen();

    // FCM listeners to handle notifications in different app states
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      try {
        print('FCM onMessage (foreground): ${message.notification?.title}');
        // Optionally show local notification or in-app banner
        NotificationSetUp.showLocalNotification(
          title: message.notification?.title ?? message.data['title'],
          body: message.notification?.body ?? message.data['body'],
          payload: message.data.toString(),
        );
      } catch (e) {
        print('Error handling onMessage: $e');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      try {
        print('FCM onMessageOpenedApp: opened from background');
        _navigateToScreen(message);
      } catch (e) {
        print('Error handling onMessageOpenedApp: $e');
      }
    });

    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        try {
          print('FCM getInitialMessage: opened from terminated state');
          _navigateToScreen(message);
        } catch (e) {
          print('Error handling getInitialMessage: $e');
        }
      }
    });
    // Show debug dialog without blocking the UI (show also in TestFlight/devices)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showDebugDialog();
    });
  }

  void _showDebugDialog() async {
    if (_debugDialogShown) return;
    _debugDialogShown = true;
    
    try {
      // Get FCM token; prefer cached value but fall back to asking Firebase
      String token = sl<LocalDataSource>().getValue(LocalDataKeys.fcmToken) ?? '';
      if (token.isEmpty || token == 'Loading...') {
        try {
          final String? fetched = await FirebaseMessaging.instance.getToken();
          token = fetched ?? 'N/A';
        } catch (_) {
          token = 'N/A';
        }
      }

      // Use standard showDialog to ensure dialog appears even if SmartDialog
      // overlay isn't initialized yet (works in TestFlight/devices).
      if (!context.mounted) return;
      await showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
          title: const Text('Debug: FCM & Notification'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                const Text('FCM token:'),
                SelectableText(token),
                const SizedBox(height: 12),
                const Text('cURL (استبدل SERVER_KEY بالقيمة الخاصة بك):',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                SelectableText(
                  'curl -X POST -H "Authorization: key=SERVER_KEY" -H "Content-Type: application/json" -d "{\\"to\\":\\"' +
                      token +
                      '\\",\\"priority\\":\\"high\\",\\"notification\\":{\\"title\\":\\"طلب جديد\\",\\"body\\":\\"لديك طلب جديد الآن\\"},\\"data\\":{}}" https://fcm.googleapis.com/fcm/send',
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Copy'),
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: token));
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Copy cURL'),
              onPressed: () async {
                final curl =
                    'curl -X POST -H "Authorization: key=SERVER_KEY" -H "Content-Type: application/json" -d "{\\"to\\":\\"' +
                        token +
                        '\\",\\"priority\\":\\"high\\",\\"notification\\":{\\"title\\":\\"طلب جديد\\",\\"body\\":\\"لديك طلب جديد الآن\\"},\\"data\\":{}}" https://fcm.googleapis.com/fcm/send';
                await Clipboard.setData(ClipboardData(text: curl));
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Send test notification'),
              onPressed: () async {
                Navigator.of(context).pop();
                await NotificationSetUp.showLocalNotification(
                  title: 'Test notification',
                  body: 'This is a test notification',
                );
              },
            ),
            TextButton(
              child: const Text('Close'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    } catch (e) {
      print('Error showing debug dialog: $e');
    }
  }

  onListen() {
    port.listen((message) {
      try {
        // Handle message in background without blocking UI
        Future.microtask(() async {
          try {
            final activeNotification =
                await FlutterLocalNotificationsPlugin().getActiveNotifications();
            await SmartDialog.dismiss();
            showSmartNotification(
              length: activeNotification.length,
              body: message["body"],
              title: message["title"],
            );

            if (sl<OrderFilterCubit<StateOrder>>().state == null ||
                sl<OrderFilterCubit<StateOrder>>().state == StateOrder.New) {
              final data = message;
              if (data.containsKey('orders')) {
                data['orders'] = jsonDecode(data['orders']);
              }
              final order = OrderEntity.fromJson(data);
              sl<OrderBloc>().pagingController.addItem(order);
            }
          } catch (e) {
            print('Error handling message in onListen: $e');
          }
        });
      } catch (e) {
        print('Error in port.listen: $e');
      }
    });
  }

  void _navigateToScreen(RemoteMessage message) {
    try {
      final String? type = message.data['type']?.toString();
      final String? orderId = message.data['id']?.toString();

      if (type == 'order' && orderId != null && orderId.isNotEmpty) {
        // Prefer to show Orders tab in the main screen
        try {
          sl<BottomNavigationCubit>().controller.jumpToPage(0);
          sl<BottomNavigationCubit>().changeTap(0);
        } catch (_) {}

        // Attempt to navigate to a dedicated order route if available
        try {
          router.go('/order_details?id=$orderId');
          return;
        } catch (_) {}

        // Fallback: show an in-app dialog with quick info
        try {
          final ctx = rootNavigatorKey.currentContext ?? context;
          if (ctx.mounted) {
            showDialog<void>(
              context: ctx,
              builder: (c) => AlertDialog(
                title: const Text('فتح الطلب'),
                content: Text('عرض تفاصيل الطلب #$orderId'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(c).pop(),
                    child: const Text('إغلاق'),
                  ),
                ],
              ),
            );
          }
        } catch (e) {
          print('Fallback dialog failed: $e');
        }
      } else {
        // Default fallback: go to notifications or main
        try {
          // '/notifications' route is not defined; navigate to main instead
          router.go(Routes.main.path);
        } catch (_) {
          try {
            sl<BottomNavigationCubit>().controller.jumpToPage(0);
            sl<BottomNavigationCubit>().changeTap(0);
          } catch (e) {
            print('Default navigation fallback failed: $e');
          }
        }
      }
    } catch (e) {
      print('Error in _navigateToScreen: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<BottomNavigationCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<OrderFilterCubit<StateOrder>>(),
        ),
        BlocProvider(create: (context) => FoodFilterCubit<Item>(init: null)),
        BlocProvider(
          create: (context) => sl<OrderBloc>(),
        ),
        BlocProvider(
          create: (context) => FoodCubit(sl())..load(filter: Filter()),
        ),
        BlocProvider(
          create: (context) => AvailableFoodCubit(sl()),
        ),
        BlocProvider(
          create: (context) => AcceptedRejectedOrderCubit(sl()),
        )
      ],
      child: FlutterSizer(builder: (context, orientation, deviceType) {
        return

            //  DevicePreview(
            //   enabled: !kReleaseMode,
            //   builder: (context) =>
            MaterialApp.router(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          routerConfig: router,
          builder: (context, child) {
            final dialog = FlutterSmartDialog.init()(context, child);
            final stackChildren = <Widget>[dialog];
              // debug FAB removed
              return Stack(children: stackChildren);
          },
        );
      }),
    );
  }
}

Future<dynamic> showSmartNotificationBackground(dynamic message, int length) {
    return SmartDialog.show(
      clickMaskDismiss: false,
      builder: (_) => Container(
            height: 20.h,
            width: 80.w,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              children: [
                Text(
                    length == 1
                        ? message['title'] ?? "طلب جديد"
                        : "طلبات جديدة",
                    style: TextStyle(
                        fontSize: 20.dp, fontWeight: FontWeight.w700)),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  children: [
                    Text(
                        length == 1 ? message["body"] ?? "" : "من جيبلي المطعم",
                        style: TextStyle(
                            fontSize: 15.dp, fontWeight: FontWeight.w500)),
                  ],
                ),
                Spacer(),
                SizedBox(
                  height: 5.5.h,
                  width: 60.h,
                  child: TextButton(
                    child: Text("اخذ بعين الإعتبار"),
                    onPressed: () async {
                      FlutterLocalNotificationsPlugin().cancelAll();
                      if (sl<BottomNavigationCubit>().state != 0) {
                        sl<BottomNavigationCubit>().controller.jumpToPage(0);
                        sl<BottomNavigationCubit>().changeTap(0);
                      }
                      SmartDialog.dismiss();
                    },
                  ),
                ),
              ],
            ),
          ),
      alignment: Alignment.center);
}
