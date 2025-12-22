// import 'dart:async';
//
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MaterialApp(home: _SimpleExampleApp()));
// }
//
// class _SimpleExampleApp extends StatefulWidget {
//   const _SimpleExampleApp();
//
//   @override
//   _SimpleExampleAppState createState() => _SimpleExampleAppState();
// }
//
// class _SimpleExampleAppState extends State<_SimpleExampleApp> {
//   late AudioPlayer player = AudioPlayer();
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Create the audio player.
//     player = AudioPlayer();
//
//     // Set the release mode to keep the source after playback has completed.
//     player.setReleaseMode(ReleaseMode.stop);
//
//     // Start the player as soon as the app is displayed.
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       await player.setSource(AssetSource('ambient_c_motion.mp3'));
//       await player.resume();
//     });
//   }
//
//   @override
//   void dispose() {
//     // Release all sources and dispose the player.
//     player.dispose();
//
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Simple Player'),
//       ),
//       body: PlayerWidget(player: player),
//     );
//   }
// }
//
// // The PlayerWidget is a copy of "/lib/components/player_widget.dart".
// //#region PlayerWidget
//
// class PlayerWidget extends StatefulWidget {
//   final AudioPlayer player;
//
//   const PlayerWidget({
//     required this.player,
//     super.key,
//   });
//
//   @override
//   State<StatefulWidget> createState() {
//     return _PlayerWidgetState();
//   }
// }
//
// class _PlayerWidgetState extends State<PlayerWidget> {
//   PlayerState? _playerState;
//   Duration? _duration;
//   Duration? _position;
//
//   StreamSubscription? _durationSubscription;
//   StreamSubscription? _positionSubscription;
//   StreamSubscription? _playerCompleteSubscription;
//   StreamSubscription? _playerStateChangeSubscription;
//
//   bool get _isPlaying => _playerState == PlayerState.playing;
//
//   bool get _isPaused => _playerState == PlayerState.paused;
//
//   String get _durationText => _duration?.toString().split('.').first ?? '';
//
//   String get _positionText => _position?.toString().split('.').first ?? '';
//
//   AudioPlayer get player => widget.player;
//
//   @override
//   void initState() {
//     super.initState();
//     // Use initial values from player
//     _playerState = player.state;
//     player.getDuration().then(
//           (value) => setState(() {
//         _duration = value;
//       }),
//     );
//     player.getCurrentPosition().then(
//           (value) => setState(() {
//         _position = value;
//       }),
//     );
//     _initStreams();
//   }
//
//   @override
//   void setState(VoidCallback fn) {
//     // Subscriptions only can be closed asynchronously,
//     // therefore events can occur after widget has been disposed.
//     if (mounted) {
//       super.setState(fn);
//     }
//   }
//
//   @override
//   void dispose() {
//     _durationSubscription?.cancel();
//     _positionSubscription?.cancel();
//     _playerCompleteSubscription?.cancel();
//     _playerStateChangeSubscription?.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final color = Theme.of(context).primaryColor;
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: <Widget>[
//         Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             IconButton(
//               key: const Key('play_button'),
//               onPressed: _isPlaying ? null : _play,
//               iconSize: 48.0,
//               icon: const Icon(Icons.play_arrow),
//               color: color,
//             ),
//             IconButton(
//               key: const Key('pause_button'),
//               onPressed: _isPlaying ? _pause : null,
//               iconSize: 48.0,
//               icon: const Icon(Icons.pause),
//               color: color,
//             ),
//             IconButton(
//               key: const Key('stop_button'),
//               onPressed: _isPlaying || _isPaused ? _stop : null,
//               iconSize: 48.0,
//               icon: const Icon(Icons.stop),
//               color: color,
//             ),
//           ],
//         ),
//         Slider(
//           onChanged: (value) {
//             final duration = _duration;
//             if (duration == null) {
//               return;
//             }
//             final position = value * duration.inMilliseconds;
//             player.seek(Duration(milliseconds: position.round()));
//           },
//           value: (_position != null &&
//               _duration != null &&
//               _position!.inMilliseconds > 0 &&
//               _position!.inMilliseconds < _duration!.inMilliseconds)
//               ? _position!.inMilliseconds / _duration!.inMilliseconds
//               : 0.0,
//         ),
//         Text(
//           _position != null
//               ? '$_positionText / $_durationText'
//               : _duration != null
//               ? _durationText
//               : '',
//           style: const TextStyle(fontSize: 16.0),
//         ),
//       ],
//     );
//   }
//
//   void _initStreams() {
//     _durationSubscription = player.onDurationChanged.listen((duration) {
//       setState(() => _duration = duration);
//     });
//
//     _positionSubscription = player.onPositionChanged.listen(
//           (p) => setState(() => _position = p),
//     );
//
//     _playerCompleteSubscription = player.onPlayerComplete.listen((event) {
//       setState(() {
//         _playerState = PlayerState.stopped;
//         _position = Duration.zero;
//       });
//     });
//
//     _playerStateChangeSubscription =
//         player.onPlayerStateChanged.listen((state) {
//           setState(() {
//             _playerState = state;
//           });
//         });
//   }
//
//   Future<void> _play() async {
//     await player.resume();
//     setState(() => _playerState = PlayerState.playing);
//   }
//
//   Future<void> _pause() async {
//     await player.pause();
//     setState(() => _playerState = PlayerState.paused);
//   }
//
//   Future<void> _stop() async {
//     await player.stop();
//     setState(() {
//       _playerState = PlayerState.stopped;
//       _position = Duration.zero;
//     });
//   }
// }

import 'dart:isolate';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:jibli_admin_food/app/app.dart';
import 'package:jibli_admin_food/core/notificaion/notification.dart';

import 'app/locator.dart' as di;
import 'core/bootstrap/bootstrap.dart';

// final player = AudioPlayer();
ReceivePort port = ReceivePort();

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Initialize Firebase in background isolate
  await Firebase.initializeApp();
  
  try {
    print(
        'Firebase background handler invoked. messageId=${message.messageId}, from=${message.from}, notification=${message.notification != null}, data=${message.data}');
  } catch (_) {}

  // Initialize local notifications in background isolate to show notification
  try {
    final FlutterLocalNotificationsPlugin _localNotifications =
        FlutterLocalNotificationsPlugin();
    
    // Initialize the plugin in background
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings();
    
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );
    
    await _localNotifications.initialize(initializationSettings);
    
    // Extract notification details from message
    String title = message.notification?.title ?? message.data['title'] ?? 'Notification';
    String body = message.notification?.body ?? message.data['body'] ?? '';
    
    // Show notification in background
    await _localNotifications.show(
      message.hashCode,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'jibli_admin', // Channel ID
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
          fullScreenIntent: true,
          // Use custom raw resource sound (resource name without extension)
          sound: RawResourceAndroidNotificationSound(NotificationSetUp.customSoundAndroid),
          visibility: NotificationVisibility.public,
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      payload: message.data.toString(),
    );
    
    print('Background: Showing notification - title=$title, body=$body');
  } catch (e) {
    print('Background handler notification error: $e');
  }

  // Forward data to main isolate if app is running
  final SendPort? send = IsolateNameServer.lookupPortByName("_listener_");
  if (send == null) {
    print("Background handler: can't find the main isolate sender (app might be terminated)");
  }
  
  if (message.data.isNotEmpty) {
    try {
      send?.send(message.data);
      print('Background handler: forwarded data to main isolate.');
    } catch (e) {
      print('Background handler: failed to forward data: $e');
    }
  }
}

void main() async {
  // 1. تشغيل المحرك الأساسي (الخطوة الوحيدة التي ننتظرها)
  WidgetsFlutterBinding.ensureInitialized();
  
  // 2. تشغيل اللغات (ضروري قبل الواجهة)
  await EasyLocalization.ensureInitialized();

  // 3. تشغيل الواجهة فوراً مع شاشة أولية آمنة
  // AppStarter سيعرض واجهة بسيطة ثم يشغّل الخدمات الثقيلة في الخلفية
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ar'),
      child: const AppStarter(),
    ),
  );
}

// دالة التشغيل في الخلفية لضمان عدم تعليق التطبيق
Future<void> _initServices() async {
  try {
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    
    // تشغيل الـ Dependency Injection والإشعارات
    await di.init();
    await NotificationSetUp.init();
    
    print("iOS Services Initialized in background");
  } catch (e) {
    print("Background Init Error: $e");
  }
}

class AppStarter extends StatefulWidget {
  const AppStarter({super.key});

  @override
  State<AppStarter> createState() => _AppStarterState();
}

class _AppStarterState extends State<AppStarter> {
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    _start();
  }

  Future<void> _start() async {
    try {
      await _initServices();
    } catch (e) {
      print('AppStarter init error: $e');
    }

    if (!mounted) return;
    setState(() => _ready = true);
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: const Color(0xFFEE4266),
          body: Center(
            child: Image.asset(
              'assets/logo/logo_jibli.jpeg',
              width: 120,
              height: 120,
            ),
          ),
        ),
      );
    }

    return const MyApp();
  }
}
