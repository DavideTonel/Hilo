import 'dart:convert';
import 'dart:developer' as dev;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  dev.log("Title: ${message.notification?.title}");
  dev.log("Body: ${message.notification?.body}");
  dev.log("Data: ${message.data}");
}

class FirebaseApi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
    "high_importance_channel",
    "High Importance Notifications",
    description: "This channel is used for important notifications.",
    importance: Importance.defaultImportance,
    playSound: true,
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    dev.log("Notifiaction recived with app in foreground");
  }

  Future<void> initPushNotifications() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
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
            icon: "@mipmap/ic_launcher"
          )
        ),
        payload: jsonEncode(message.toMap())
      );
    });
  }

  Future<void> initLocalNotifications() async {
    const iOSSettings = DarwinInitializationSettings();
    const androidSettings = AndroidInitializationSettings("@mipmap/ic_launcher");
    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iOSSettings
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
    final platform = _localNotifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    if (platform != null) {
      // Add any platform-specific initialization logic here if needed
      await platform.createNotificationChannel(_androidChannel);
    }
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    // Log the token needed in order to get the token the first time
    // To do that initialize in the main function and call this method
    dev.log("Token: $fCMToken"); // TODO: store somewhere safe
    initPushNotifications();
    initLocalNotifications();
  }
}
