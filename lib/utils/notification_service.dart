import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print('notification action tapped with input: ${notificationResponse.input}');
  }
}
class LocalNotificationService {

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // Initialize native android notification
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    // Initialize native Ios Notifications
    const DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
      onDidReceiveNotificationResponse: notificationTapBackground
    );

    tz.initializeTimeZones();
  }

  void showNotificationAndroid(String title, String value) async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('channel_id', 'Channel Name',
        channelDescription: 'Channel Description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');

    int notification_id = 1;
    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin
        .show(notification_id, title, value, notificationDetails, payload: 'Not present');
  }
  Future<void> scheduleDailyTenAMNotification() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'daily scheduled notification title',
        'daily scheduled notification body',
        _nextInstanceOfTenAM(),
        const NotificationDetails(
          android: AndroidNotificationDetails(
              'daily notification channel id', 'daily notification channel name',
              channelDescription: 'daily notification description'),
        ),
        payload: 'testing',
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
    log('scheduled');
    print(_nextInstanceOfTenAM());
  }
  // tz.TZDateTime _nextInstanceOfFiveMinutes() {
  //   final tz.TZDateTime now = tz.TZDateTime.now(timezone);
  //   tz.TZDateTime scheduledDate = now.add(const Duration(seconds: 10));
  //   return scheduledDate;
  // }
  tz.TZDateTime _nextInstanceOfTenAM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.timeZoneDatabase.locations['Africa/Lagos']!);
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.timeZoneDatabase.locations['Africa/Lagos']!, now.year, now.month, now.day, 15,30);
    // if (scheduledDate.isBefore(now)) {
    //   scheduledDate = scheduledDate.add(const Duration(days: 1));
    // }
    return scheduledDate;
  }
}