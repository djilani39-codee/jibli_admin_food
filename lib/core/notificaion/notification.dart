import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:jibli_admin_food/app/locator.dart';
import 'package:jibli_admin_food/core/enums.dart';
import 'package:jibli_admin_food/core/extensions/paging_extention.dart';
import 'package:jibli_admin_food/data/local_data_source/local_data_keys.dart';
import 'package:jibli_admin_food/data/local_data_source/local_data_source.dart';
import 'package:jibli_admin_food/domain/entity/fast_food_entity/fast_food_response.dart';

import 'package:jibli_admin_food/domain/entity/order_entity/order_entity.dart';
import 'package:jibli_admin_food/presentation/main/blocs/main_navigation_cubi.dart';
import 'package:jibli_admin_food/presentation/orders/cubits/cubit/order_bloc.dart';
import 'package:jibli_admin_food/presentation/orders/cubits/order_filter_cubit.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../utils.dart';

class NotificationSetUp {
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();
  // Channel id can be overridden in debug to force recreation without reinstall
  static String channelId = 'jibli_admin';
  // Name of the custom sound resource (without extension) placed in Android res/raw
  // and the corresponding iOS bundle resource name (with extension) if provided.
  // Example: place `my_sound.mp3` in Android `res/raw` as `my_sound.mp3` and
  // set `customSoundAndroid = 'my_sound'` and `customSoundIos = 'my_sound.aiff'`.
  // Update these to match your sound file names. For Android use the filename
  // without extension (e.g. 'alarm' for alarm.mp3 in res/raw). For iOS include
  // the extension (e.g. 'alarm.aiff').
  static String customSoundAndroid = 'alarm';
  static String customSoundIos = 'alarm.aiff';

  static init() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    FastFoodEntity? user = sl<LocalDataSource>().getValue(LocalDataKeys.user);
    
    // Request notification permissions WITHOUT awaiting (non-blocking)
    // The permission request will happen in the background
    requestNotificationPermissions();

    // Enable foreground notifications
    await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    // Retrieve and persist FCM token
    try {
      final String? token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        // save locally for server registration
        await sl<LocalDataSource>().setValue(LocalDataKeys.fcmToken, token);
        print('FCM token: $token');
      }
    } catch (e) {
      print('Failed to get FCM token: $e');
    }

    /// background (when user taps notification and app opens)
    FirebaseMessaging.onMessageOpenedApp.listen((event) async {
      try {
        print(
            'onMessageOpenedApp invoked. messageId=${event.messageId}, data=${event.data}, notification=${event.notification != null}');
        if (sl<BottomNavigationCubit>().state != 0) {
          sl<BottomNavigationCubit>().controller.jumpToPage(0);
          sl<BottomNavigationCubit>().changeTap(0);
        }
      } catch (e) {
        print('onMessageOpenedApp error: $e');
        return;
      }
    });

    /// terminated
    messaging.getInitialMessage().then((value) async {
      if (value == null) {
        print('getInitialMessage: null');
        return;
      }
      try {
        print(
            'getInitialMessage invoked. messageId=${value.messageId}, data=${value.data}, notification=${value.notification != null}');
        final activeNotification =
            await _localNotifications.getActiveNotifications();
        if (activeNotification.length >= 1) {
          SmartDialog.dismiss();
          showSmartNotification(
            length: activeNotification.length,
            body: value.data["body"],
            title: value.data["title"],
          );
        } else {
          showSmartNotification(
            length: activeNotification.length,
            body: value.data["body"],
            title: value.data["title"],
          );
        }
        sl<BottomNavigationCubit>().controller.jumpToPage(0);
        sl<BottomNavigationCubit>().changeTap(0);
      } catch (e) {
        print('getInitialMessage error: $e');
        return;
      }
    });

    // Subscribe to topic
    messaging
        .subscribeToTopic(user?.markets?.first.topicNotification ?? "jibl");

    await _setUpNotifications();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print(
          'onMessage received. messageId=${message.messageId}, from=${message.from}, notification=${message.notification != null}, data=${message.data}');
      if (message.data.isNotEmpty) {
        final data = message.data;

        // show local notification using the shared plugin instance
        await _localNotifications.show(
          message.hashCode,
          data['title'] ?? message.notification?.title,
          data['body'] ?? message.notification?.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channelId, // id
              'High Importance Notifications',
              channelDescription: 'Notifications for orders and updates',
              importance: Importance.max,
              priority: Priority.high,
              ongoing: false,
              autoCancel: true,
              icon: '@mipmap/ic_launcher',
              playSound: true,
              enableVibration: true,
              enableLights: true,
              sound: null, // null = use channel default (system sound)
              visibility: NotificationVisibility.public,
              fullScreenIntent: true,
            ),
            iOS: const DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
            ),
          ),
          payload: data.toString(),
        );

        if (sl<OrderFilterCubit<StateOrder>>().state == null ||
            sl<OrderFilterCubit<StateOrder>>().state == StateOrder.New) {
          data['orders'] = jsonDecode(data['orders']);
          final order = OrderEntity.fromJson(data);
          sl<OrderBloc>().pagingController.addItem(order);
        }

        final activeNotification =
            await _localNotifications.getActiveNotifications();
        if (activeNotification.length >= 1) {
          SmartDialog.dismiss();
          showSmartNotification(
            length: activeNotification.length,
            body: message.data["body"],
            title: message.data["title"],
          );
          Fluttertoast.showToast(
            msg: message.data['body'] ?? message.notification?.body ?? 'لديك إشعار جديد',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: const Color(0xFF222222),
            textColor: Colors.white,
            fontSize: 14.0,
          );
          return;
        }
        showSmartNotification(
          length: activeNotification.length,
          body: message.data["body"],
          title: message.data["title"],
        );
        Fluttertoast.showToast(
          msg: message.data['body'] ?? message.notification?.body ?? 'لديك إشعار جديد',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: const Color(0xFF222222),
          textColor: Colors.white,
          fontSize: 14.0,
        );
      } else {
        // If no data payload, still log
        print(
            'onMessage: no data payload. notification=${message.notification?.title}/${message.notification?.body}');
        Fluttertoast.showToast(
          msg: message.notification?.body ?? 'لديك إشعار جديد',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: const Color(0xFF222222),
          textColor: Colors.white,
          fontSize: 14.0,
        );
      }
    });
  }

  static _setUpNotifications() async {
    // If in debug, add a timestamp suffix to channel id so Android creates
    // a fresh channel and picks up any configuration changes immediately.
    if (kDebugMode) {
      channelId = 'jibli_admin_debug_${DateTime.now().millisecondsSinceEpoch}';
    } else {
      channelId = 'jibli_admin';
    }

    final AndroidNotificationChannel channel = AndroidNotificationChannel(
      channelId, // id
      'High Importance Notifications',
      playSound: true,
      enableVibration: true,
      importance: Importance.max,
      // Use custom raw resource sound if present in res/raw
      sound: RawResourceAndroidNotificationSound(customSoundAndroid),
      description: 'إشعارات الطلبات الجديدة - إشعارات عاجلة وسريعة',
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin);

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) {
        // Handle notification tapped logic here; log payload if present
        try {
          final payload = response.payload;
          if (payload != null && payload.isNotEmpty) {
            print('Notification tapped payload: $payload');
          }
        } catch (e) {
          // ignore
        }
      },
    );
  }

  /// Public helper to show a local notification (useful for debug/testing).
  static Future<void> showLocalNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    await _localNotifications.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channelId, // id
          'High Importance Notifications',
          importance: Importance.max,
          priority: Priority.high,
          ongoing: false,
          autoCancel: true,
          icon: '@mipmap/ic_launcher',
          playSound: true,
          enableVibration: true,
          // Use custom raw resource sound if available
          sound: RawResourceAndroidNotificationSound(customSoundAndroid),
        ),
        iOS: DarwinNotificationDetails(sound: customSoundIos),
      ),
      payload: payload,
    );
  }
}

Future<void> requestNotificationPermissions() async {
  try {
    final PermissionStatus status = await Permission.notification.request();
    if (status.isGranted) {
      print('Notification permission granted');
    } else if (status.isDenied) {
      print('Notification permission denied');
      // Don't block UI with openAppSettings here
      // User can enable in Settings manually
    } else if (status.isPermanentlyDenied) {
      print('Notification permission permanently denied');
      // Optionally open settings in background
      Future.delayed(const Duration(seconds: 2), () {
        openAppSettings();
      });
    }
  } catch (e) {
    print('Error requesting notification permission: $e');
  }
}
