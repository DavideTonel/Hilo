import 'dart:developer' as dev;

import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationMessageHandler {
  void handleForeground(RemoteMessage message) {
    dev.log("Foreground message received: ${message.data}");
  }

  void handleTap(RemoteMessage? message) {
    if (message == null) return;
    dev.log("Notification tapped: ${message.data}");
  }

  @pragma('vm:entry-point')
  Future<void> handleBackground(RemoteMessage message) async {
    dev.log("Background message received: ${message.data}");
  }

  void handleLocalTap(Map<String, dynamic> message) {
    dev.log("Local notification tapped: $message");
  }
}