import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:roadsyouwalked_app/model/notification/local_notification_service.dart';
import 'package:roadsyouwalked_app/model/notification/remote_notification_service.dart';
import 'dart:developer' as dev;

class NotificationService {
  final void Function(Map<String, dynamic> message) handleLocalTap;
  final void Function(RemoteMessage? message) handleTap;
  final Future<void> Function(RemoteMessage message) handleBackground;
  final void Function(RemoteMessage message) handleForeground;

  late final AndroidNotificationChannel _androidChannel =
      const AndroidNotificationChannel(
        "high_importance_channel",
        "High Importance Notifications",
        description: "Used for important reminders",
        importance: Importance.high,
      );

  late final LocalNotificationService local = LocalNotificationService(
    onNotificationTap: handleLocalTap,
    androidChannel: _androidChannel,
  );

  late final RemoteNotificationService remote = RemoteNotificationService(
    onInitialOrTap: handleTap,
    onBackground: handleBackground,
    onForeground: (message) {
      handleForeground(message);
      local.showNotification({
        "title": message.notification?.title ?? "null",
        "body": message.notification?.body ?? "null",
        ...message.data,
      });
    },
  );

  NotificationService({
    required this.handleLocalTap,
    required this.handleTap,
    required this.handleBackground,
    required this.handleForeground,
  });

  Future<void> init() async {
    dev.log("Initializing notification service");
    await local.init();
    await remote.init();
  }
}
