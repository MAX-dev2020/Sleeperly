import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future<void> initNotification() async {
    // Android initialization
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/ic_stat_sleeping');

    // ios initialization
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    // the initialization settings are initialized after they are setted
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  tz.TZDateTime _nextInstance(int hour, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minutes,
    );

    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }
    print(scheduleDate);
    return scheduleDate;
  }

  // tz.TZDateTime _nextInstanceOfMondayTenAM(int hour, int minutes, int day) {
  //   tz.TZDateTime scheduledDate = _nextInstance(hour, minutes);
  //   while (scheduledDate.weekday != day) {
  //     scheduledDate = scheduledDate.add(const Duration(days: 1));
  //   }
  //   return scheduledDate;
  // }

  Future<void> showNotification(
    int id,
    String title,
    String body,
    int hour,
    int minutes,
    String ringtone,
    String channelId,
  ) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      _nextInstance(hour, minutes),

      NotificationDetails(
        // Android details
        android: AndroidNotificationDetails(
          channelId, 'Main Channel',
          channelDescription: "Monish",
          importance: Importance.max,
          priority: Priority.max,
          fullScreenIntent: true,
          icon: '@drawable/ic_stat_sleeping',
          color: Colors.black,

          // sound: RawResourceAndroidNotificationSound(ringtone)
        ),

        // iOS details
        iOS: const IOSNotificationDetails(
          sound: 'default.wav',
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),

      // Type of time interpretation
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      // To show notification even when the app is closed
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> showNotification2(
    int id,
    String title,
    String body,
    int hour,
    String ringtone,
    String channelId,
  ) async {
    print(hour);
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(Duration(seconds: hour)),

      NotificationDetails(
        // Android details
        android: AndroidNotificationDetails(
          channelId, 'Main Channel',
          channelDescription: "Monish",
          importance: Importance.max,
          priority: Priority.max,
          fullScreenIntent: true,
          icon: '@drawable/ic_stat_sleeping',
          color: Colors.black,

          // sound: RawResourceAndroidNotificationSound(ringtone)
        ),

        // iOS details
        iOS: const IOSNotificationDetails(
          sound: 'default.wav',
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),

      // Type of time interpretation
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      // To show notification even when the app is closed
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
