import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse) async {}

class PushNotificationService {
  //! PLUGINS
  static final _localNotifications = FlutterLocalNotificationsPlugin();

//  ! INITIALIZE LOCAL NOTIFICATIONS

  static void initialize() async {
    NotificationAppLaunchDetails? details =
        await _localNotifications.getNotificationAppLaunchDetails();
    log('\n\nThis is the detail: ${details?.didNotificationLaunchApp}\n${details?.notificationResponse?.payload}\n\n');
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/student_launcher"),
      iOS: DarwinInitializationSettings(),
    );
    _localNotifications.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse:
          onDidReceiveNotificationResponse,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
  }

  //! SHOW NOTIFICATION MESSAGE
  void showNotificationOnForeground(Map<String, dynamic> message) {
    const notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
          'high_importance_channel', // id
          'High Importance Notifications', // title// description
          importance: Importance.max,
          icon: "@mipmap/student_launcher"),
      iOS: DarwinNotificationDetails(),
    );

    _localNotifications.show(DateTime.now().microsecond, message['title'],
        message['body'], notificationDetails,
        payload: 'Class Canceled');
  }
}
