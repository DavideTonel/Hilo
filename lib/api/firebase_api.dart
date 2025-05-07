import 'dart:convert';
import 'dart:developer' as dev;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// A top-level function to handle background messages received via Firebase Cloud Messaging.
///
/// This function is triggered when the app is in the background or terminated,
/// and a push notification is received.
///
/// It logs the title, body, and data of the incoming [RemoteMessage].
@pragma('vm:entry-point')
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  dev.log("Title: ${message.notification?.title}");
  dev.log("Body: ${message.notification?.body}");
  dev.log("Data: ${message.data}");
}

/// A utility class for initializing and managing Firebase push notifications.
///
/// This class handles foreground, background, and terminated state message delivery,
/// sets up local notification channels, and manages notification display on both
/// Android and iOS platforms.
class FirebaseApi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  /// Android notification channel used for displaying high importance notifications.
  final _androidChannel = const AndroidNotificationChannel(
    "high_importance_channel",
    "High Importance Notifications",
    description: "This channel is used for important notifications.",
    importance: Importance.defaultImportance,
    playSound: true,
  );

  /// Plugin for displaying local notifications.
  final _localNotifications = FlutterLocalNotificationsPlugin();

  /// Handles messages when the app is opened via a notification.
  ///
  /// This is used to handle notification taps that bring the app from the
  /// background or terminated state to the foreground.
  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    dev.log("Notification received with app in foreground");
  }

  /// Initializes push notification handling for all app states.
  ///
  /// This includes:
  /// - Foreground message handling and display via local notifications
  /// - Background and terminated state handling via registered listeners
  Future<void> initPushNotifications() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // Handle notification that opened the app from a terminated state.
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    // Listen for notifications when the app is in the background and opened by the user.
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

    // Register background message handler.
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    // Listen for messages when the app is in the foreground.
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;

      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: 'ic_notification',
            largeIcon: DrawableResourceAndroidBitmap('ic_notification'),
          ),
          iOS: const DarwinNotificationDetails(),
        ),
        payload: jsonEncode(message.toMap()),
      );
    });
  }

  /// Initializes the local notifications plugin.
  ///
  /// Sets up platform-specific settings and handles notification tap callbacks
  /// to allow interaction with messages after they are shown locally.
  Future<void> initLocalNotifications() async {
    const iOSSettings = DarwinInitializationSettings();
    const androidSettings = AndroidInitializationSettings("@mipmap/ic_launcher");
    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iOSSettings,
    );

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (details) {
        final payload = details.payload;
        if (payload == null) return;

        final message = jsonDecode(payload) as Map<String, dynamic>;
        handleMessage(RemoteMessage.fromMap(message));
      },
    );

    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (platform != null) {
      // Create notification channel on Android.
      await platform.createNotificationChannel(_androidChannel);
    }
  }

  /// Initializes all required permissions and listeners for notifications.
  ///
  /// Requests user permission, fetches and logs the FCM token, and
  /// initializes both push and local notification systems.
  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();

    final fCMToken = await _firebaseMessaging.getToken();
    dev.log("Token: $fCMToken");

    initPushNotifications();
    initLocalNotifications();
  }
}
