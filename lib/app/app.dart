import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
  @override
  void initState() {
    super.initState();
    onListen();
    // Show debug dialog without blocking the UI
    if (kDebugMode) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showDebugDialog();
      });
    }
  }

  void _showDebugDialog() {
    if (_debugDialogShown) return;
    _debugDialogShown = true;
    
    try {
      // Get FCM token without blocking (non-blocking check)
      String token =
          sl<LocalDataSource>().getValue(LocalDataKeys.fcmToken) ?? 'Loading...';

      // Use SmartDialog to reliably show an overlay dialog
      SmartDialog.show(
        builder: (_) => AlertDialog(
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
                SmartDialog.dismiss();
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
                SmartDialog.dismiss();
              },
            ),
            TextButton(
              child: const Text('Send test notification'),
              onPressed: () async {
                SmartDialog.dismiss();
                await NotificationSetUp.showLocalNotification(
                  title: 'Test notification',
                  body: 'This is a test notification',
                );
              },
            ),
            TextButton(
              child: const Text('Close'),
              onPressed: () => SmartDialog.dismiss(),
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
          useInheritedMediaQuery: true,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          routerConfig: router,
          builder: (context, child) {
            final dialog = FlutterSmartDialog.init()(context, child);
            final stackChildren = <Widget>[dialog];
            if (kDebugMode) {
              stackChildren.add(Positioned(
                right: 16,
                bottom: 16,
                child: SafeArea(
                  child: FloatingActionButton(
                    heroTag: 'debug_notify',
                    child: const Icon(Icons.bug_report),
                    onPressed: () async {
                      final token = sl<LocalDataSource>()
                              .getValue(LocalDataKeys.fcmToken) ??
                          'N/A';
                      // Delay to ensure Navigator is available
                      await Future.delayed(const Duration(milliseconds: 100));
                      if (!context.mounted) return;
                      await showDialog<void>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Debug: FCM & Notification'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: [
                                Text('FCM token:'),
                                SelectableText(token),
                                SizedBox(height: 12),
                                Text(
                                    'cURL (استبدل SERVER_KEY بالقيمة الخاصة بك):',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                                SizedBox(height: 6),
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
                                await Clipboard.setData(
                                    ClipboardData(text: token));
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
                                await Clipboard.setData(
                                    ClipboardData(text: curl));
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
                    },
                  ),
                ),
              ));
            }
            return Stack(children: stackChildren);
          },
        );
      }),
    );
  }
}

Future<dynamic> showSmartNotificationBackground(dynamic message, int length) {
  return SmartDialog.show(
      backDismiss: false,
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
