import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  /// Instantiate
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // Initialize native android notification
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/student_launcher');

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
    );

    tz.initializeTimeZones(); // <---- Make this change.
  }

  /// Schedule timed notification to appear weakly
  Future<void> scheduleDailyTenAMNotification(
      {required int day, required int hour, required String course}) async {

    final timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));

    await flutterLocalNotificationsPlugin.zonedSchedule(
        int.parse("$day$hour"),
        '$course Lecture',
        '$course starts in 5 minutes',
        _nextInstanceOfTime(day: day, hour: hour, course: course),
        const NotificationDetails(
          android: AndroidNotificationDetails('daily notification channel id',
              'daily notification channel name',
              channelDescription: 'daily notification description',
              importance: Importance.max,
              priority: Priority.high),
        ),
        androidScheduleMode: AndroidScheduleMode.alarmClock,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: '"$day$hour"',
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
  }

  tz.TZDateTime _nextInstanceOfTime(
      {required int day, required int hour, required String course}) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    /// Fetch device location
    /// Set Date to be 5 minutes later than the actual hour of lecture
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour - 1,
      55,
    );

    /// Loop through days until the weekday matches the day of the lecture
    while (scheduledDate.weekday != day) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    log('$course scheduled At: $scheduledDate,${tz.local}');
    return scheduledDate;
  }

  Future<void> clearClasses()async{
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
