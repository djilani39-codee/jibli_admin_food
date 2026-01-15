import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
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
import 'package:jibli_admin_food/app/router.dart';
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
    // IMPORTANT: Do NOT request permissions or register token automatically.
    // Push notifications must be optional and require explicit user consent.
    // Call `NotificationSetUp.enableNotifications()` after the user opts in.

    /// background (when user taps notification and app opens)
    FirebaseMessaging.onMessageOpenedApp.listen((event) async {
      try {
        print(
            'onMessageOpenedApp invoked. messageId=${event.messageId}, data=${event.data}, notification=${event.notification != null}');

        if (event.data.isNotEmpty) {
          try {
            final data = Map<String, dynamic>.from(event.data);
            if (data['orders'] is String) {
              data['orders'] = jsonDecode(data['orders']);
            }
            final order = OrderEntity.fromJson(data);
            final String orderId = order.id?.toString() ?? data['id']?.toString() ?? '';

            // Ensure main page is visible then navigate to order details
            try {
              sl<BottomNavigationCubit>().controller.jumpToPage(0);
              sl<BottomNavigationCubit>().changeTap(0);
            } catch (_) {}

            if (orderId.isNotEmpty) {
              Future.delayed(const Duration(milliseconds: 300), () {
                try {
                  router.push('/order_details?id=$orderId');
                  return;
                } catch (e) {
                  print('Router navigation failed: $e');
                  // Fallback: add item to ordering list so user can open it manually
                  try {
                    sl<OrderBloc>().pagingController.addItem(order);
                  } catch (e) {
                    print('Fallback addItem failed: $e');
                  }
                }
              });
            }
          } catch (e) {
            print('Error parsing onMessageOpenedApp data: $e');
          }
        } else {
          if (sl<BottomNavigationCubit>().state != 0) {
            sl<BottomNavigationCubit>().controller.jumpToPage(0);
            sl<BottomNavigationCubit>().changeTap(0);
          }
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

        // Show smart notification if there are active notifications
        final activeNotification = await _localNotifications.getActiveNotifications();
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

        if (value.data.isNotEmpty) {
          try {
            final data = Map<String, dynamic>.from(value.data);
            if (data['orders'] is String) {
              data['orders'] = jsonDecode(data['orders']);
            }
            final order = OrderEntity.fromJson(data);
            final String orderId = order.id?.toString() ?? data['id']?.toString() ?? '';

            // Ensure main page is visible then navigate to order details
            try {
              sl<BottomNavigationCubit>().controller.jumpToPage(0);
              sl<BottomNavigationCubit>().changeTap(0);
            } catch (_) {}

            // Add delay to ensure router is ready
            if (orderId.isNotEmpty) {
              Future.delayed(const Duration(milliseconds: 500), () {
                try {
                  router.push('/order_details?id=$orderId');
                  return;
                } catch (e) {
                  print('Router navigation failed: $e');
                  // Fallback: add item to ordering list
                  try {
                    sl<OrderBloc>().pagingController.addItem(order);
                  } catch (e) {
                    print('Fallback addItem failed: $e');
                  }
                }
              });
            }
          } catch (e) {
            print('Error handling initial message: $e');
          }
        }
      } catch (e) {
        print('getInitialMessage error: $e');
        return;
      }
    });

    // Still set up local notification channels and handlers, but avoid
    // registering the device / requesting permission until user consents.
    await _setUpNotifications();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print(
          'onMessage received. messageId=${message.messageId}, from=${message.from}, notification=${message.notification != null}, data=${message.data}');
      if (message.data.isNotEmpty) {
        final data = message.data;

        // If payload contains an image URL, attempt to download and show
        // a Big Picture style notification on Android.
        AndroidNotificationDetails androidDetails;
        try {
          final String? imageUrl = data['image'] ?? message.notification?.android?.imageUrl?.toString();
          if (imageUrl != null && imageUrl.isNotEmpty) {
            // download image to temporary directory
            final String fileName = 'notif_${DateTime.now().millisecondsSinceEpoch}.png';
            final tempPath = (await getTemporaryDirectory()).path;
            final String fullPath = '$tempPath/$fileName';
            try {
              await Dio().download(imageUrl, fullPath);
              final BigPictureStyleInformation bigPictureStyle = BigPictureStyleInformation(
                FilePathAndroidBitmap(fullPath),
                contentTitle: data['title'] ?? message.notification?.title,
                summaryText: data['body'] ?? message.notification?.body,
              );

              androidDetails = AndroidNotificationDetails(
                channelId,
                'High Importance Notifications',
                channelDescription: 'Notifications for orders and updates',
                importance: Importance.max,
                priority: Priority.high,
                ongoing: false,
                autoCancel: true,
                icon: '@mipmap/launcher_icon',
                playSound: true,
                enableVibration: true,
                enableLights: true,
                sound: RawResourceAndroidNotificationSound(customSoundAndroid),
                visibility: NotificationVisibility.public,
                fullScreenIntent: true,
                styleInformation: bigPictureStyle,
              );
            } catch (e) {
              // download failed - fall back to normal notification
              androidDetails = AndroidNotificationDetails(
                channelId,
                'High Importance Notifications',
                channelDescription: 'Notifications for orders and updates',
                importance: Importance.max,
                priority: Priority.high,
                ongoing: false,
                autoCancel: true,
                icon: '@mipmap/launcher_icon',
                playSound: true,
                enableVibration: true,
                enableLights: true,
                sound: RawResourceAndroidNotificationSound(customSoundAndroid),
                visibility: NotificationVisibility.public,
                fullScreenIntent: true,
              );
            }
          } else {
            // no image -> regular android details
            androidDetails = AndroidNotificationDetails(
              channelId, // id
              'High Importance Notifications',
              channelDescription: 'Notifications for orders and updates',
              importance: Importance.max,
              priority: Priority.high,
              ongoing: false,
              autoCancel: true,
              icon: '@mipmap/launcher_icon',
              playSound: true,
              enableVibration: true,
              enableLights: true,
              sound: RawResourceAndroidNotificationSound(customSoundAndroid),
              visibility: NotificationVisibility.public,
              fullScreenIntent: true,
            );
          }
        } catch (e) {
          // any unexpected error -> use basic android details
          androidDetails = AndroidNotificationDetails(
            channelId, // id
            'High Importance Notifications',
            channelDescription: 'Notifications for orders and updates',
            importance: Importance.max,
            priority: Priority.high,
            ongoing: false,
            autoCancel: true,
            icon: '@mipmap/launcher_icon',
            playSound: true,
            enableVibration: true,
            enableLights: true,
            sound: RawResourceAndroidNotificationSound(customSoundAndroid),
            visibility: NotificationVisibility.public,
            fullScreenIntent: true,
          );
        }

        // show notification using the computed androidDetails
        // Pass only the order ID as payload for proper navigation
        final String orderId = data['id']?.toString() ?? '';
        await _localNotifications.show(
          message.hashCode,
          data['title'] ?? message.notification?.title,
          data['body'] ?? message.notification?.body,
          NotificationDetails(
            android: androidDetails,
            iOS: const DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
            ),
          ),
          payload: orderId,
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

  /// Call this after the user explicitly opts in to enable push notifications.
  /// This requests permission, obtains the FCM token, and subscribes to topic.
  static Future<void> enableNotifications() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Request platform notification permission (shows system prompt)
    await requestNotificationPermissions();

    final settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional) {
      try {
        final String? token = await FirebaseMessaging.instance.getToken();
        if (token != null) {
          await sl<LocalDataSource>().setValue(LocalDataKeys.fcmToken, token);
          print('FCM token: $token');
        }
      } catch (e) {
        print('Failed to get FCM token: $e');
      }

      try {
        final FastFoodEntity? user = sl<LocalDataSource>().getValue(LocalDataKeys.user);
        await messaging.subscribeToTopic(user?.markets?.first.topicNotification ?? "jibl");
      } catch (e) {
        print('Failed to subscribe to topic: $e');
      }

      // Persist that notifications are enabled so app UI can reflect state
      try {
        await sl<LocalDataSource>().setValue(LocalDataKeys.notificationsEnabled, true);
      } catch (_) {}
    } else {
      print('User declined notification permissions: ${settings.authorizationStatus}');
    }
  }

  /// Disable push notifications: unsubscribe and clear stored token/state.
  static Future<void> disableNotifications() async {
    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      final FastFoodEntity? user = sl<LocalDataSource>().getValue(LocalDataKeys.user);
      await messaging.unsubscribeFromTopic(user?.markets?.first.topicNotification ?? "jibl");
    } catch (e) {
      print('Failed to unsubscribe from topic: $e');
    }
    try {
      await sl<LocalDataSource>().setValue(LocalDataKeys.fcmToken, null);
      await sl<LocalDataSource>().setValue(LocalDataKeys.notificationsEnabled, false);
    } catch (_) {}
  }

  static _setUpNotifications() async {
    // If in debug, add a timestamp suffix to channel id so Android creates
    // a fresh channel and picks up any configuration changes immediately.
    if (kDebugMode) {
      channelId = 'jibli_admin_debug_${DateTime.now().millisecondsSinceEpoch}';
    } else {
      channelId = 'jibli_admin';
    }

    // Ensure a stable channel matching the server-side channel id exists
    const AndroidNotificationChannel jibliAdminChannel = AndroidNotificationChannel(
      'jibli_admin', // must match server channel id
      'High Importance Notifications',
      description: 'هذه القناة تستخدم لإشعارات الطلبات الجديدة',
      importance: Importance.max,
      playSound: true,
      // sound must reference the raw resource name (without extension)
      sound: RawResourceAndroidNotificationSound('alarm'),
    );

    // Also create the existing (possibly debug) channel used locally
    final AndroidNotificationChannel channel = AndroidNotificationChannel(
      channelId, // id (may include debug suffix in debug builds)
      'High Importance Notifications',
      playSound: true,
      enableVibration: true,
      importance: Importance.max,
      // Use custom raw resource sound if present in res/raw
      sound: RawResourceAndroidNotificationSound(customSoundAndroid),
      description: 'إشعارات الطلبات الجديدة - إشعارات عاجلة وسريعة',
    );

    final androidImpl = _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    await androidImpl?.createNotificationChannel(jibliAdminChannel);
    await androidImpl?.createNotificationChannel(channel);

    const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/launcher_icon');
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
        // Handle notification tapped logic here
        try {
          final payload = response.payload;
          if (payload != null && payload.isNotEmpty) {
            print('Notification tapped payload: $payload');
            // Navigate to order details using the payload ID
            Future.delayed(const Duration(milliseconds: 200), () {
              try {
                router.push('/order_details?id=$payload');
              } catch (e) {
                print('Failed to navigate from notification: $e');
              }
            });
          }
        } catch (e) {
          print('Error handling notification response: $e');
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
          icon: '@mipmap/launcher_icon',
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
      print('✓ Notification permission granted');
      // Now subscribe to topic after permission is granted
      await _subscribeToRestaurantTopic();
    } else if (status.isDenied) {
      print('✗ Notification permission denied - app will continue without notifications');
      // Don't block app, user can enable later in Settings
    } else if (status.isPermanentlyDenied) {
      print('✗ Notification permission permanently denied');
      // Silently continue - don't force settings dialog
    }
  } catch (e) {
    print('Error requesting notification permission: $e');
    // Continue app even if permission request fails
  }
}

/// Subscribe to restaurant topic safely
Future<void> _subscribeToRestaurantTopic() async {
  try {
    final FirebaseMessaging messaging = FirebaseMessaging.instance;
    final FastFoodEntity? user = sl<LocalDataSource>().getValue(LocalDataKeys.user);
    final topic = user?.markets?.first.topicNotification ?? "jibl";
    
    await messaging.subscribeToTopic(topic);
    print('✓ Subscribed to topic: $topic');
  } catch (e) {
    print('Failed to subscribe to topic: $e');
    // Continue even if subscription fails
  }
}
/// Safe method to enable notifications - can be called anytime after user consent
/// This is useful for settings screens where user wants to enable notifications later
Future<void> safeEnableNotifications() async {
  try {
    await NotificationSetUp.enableNotifications();
  } catch (e) {
    print('Error enabling notifications: $e');
    // Silently fail - app continues to work
  }
}