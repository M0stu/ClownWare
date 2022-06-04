import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  PushNotificationsService() {
    notificationSeting();
  }

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<void> notificationSeting() async {
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }
}
