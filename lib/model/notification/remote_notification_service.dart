import 'dart:developer' as dev;

import 'package:firebase_messaging/firebase_messaging.dart';

class RemoteNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final void Function(RemoteMessage? message) onInitialOrTap;
  final Future<void> Function(RemoteMessage message) onBackground;
  final void Function(RemoteMessage message) onForeground;

  RemoteNotificationService({
    required this.onInitialOrTap,
    required this.onBackground,
    required this.onForeground,
  });

  Future<void> init() async {
    dev.log("Initializing remote notifications");
    await _firebaseMessaging.requestPermission();

    final token = await _firebaseMessaging.getToken();
    dev.log("Firebase device token: $token");

    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(onInitialOrTap);
    FirebaseMessaging.onMessageOpenedApp.listen(onInitialOrTap);
    FirebaseMessaging.onBackgroundMessage(onBackground);
    FirebaseMessaging.onMessage.listen(onForeground);
  }
}

class FirebaseApi {
}
