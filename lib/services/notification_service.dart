import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  int insistentFlag = 4;
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

  tz.TZDateTime _nextInstance(int hour, int minutes, String? timeZone) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.getLocation(timeZone!));
    tz.TZDateTime scheduleDate = tz.TZDateTime(
        tz.getLocation(timeZone), now.year, now.month, now.day, hour, minutes);

    // if (scheduleDate.isBefore(now)) {
    //   scheduleDate = scheduleDate.add(const Duration(days: 1));
    // }
    return scheduleDate;
  }

  tz.TZDateTime _nextInstanceOfDayWeek(
      int hour, int minutes, int day, String? timeZone) {
    tz.TZDateTime scheduledDate = _nextInstance(hour, minutes, timeZone);
    if (day != 0) {
      while (scheduledDate.weekday != day) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }
    } else {
      final tz.TZDateTime now = tz.TZDateTime.now(tz.getLocation(timeZone!));
      if (scheduledDate.isBefore(now)) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }
    }
    print(scheduledDate);
    return scheduledDate;
  }

  Future<void> showNotification(
    int id,
    String title,
    String body,
    int hour,
    int minutes,
    int day,
    String ringtone,
    String channelId,
  ) async {
    final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      _nextInstanceOfDayWeek(hour, minutes, day, timeZoneName),

      NotificationDetails(
        // Android details
        android: AndroidNotificationDetails(
          channelId,
          "${channelId * 10}reminder",
          channelDescription: "Monish",
          importance: Importance.max,
          priority: Priority.max,
          fullScreenIntent: true,
          icon: '@drawable/ic_stat_sleeping',
          color: Colors.black,
          sound: RawResourceAndroidNotificationSound(ringtone),
          playSound: true,
          additionalFlags: Int32List.fromList(
            <int>[insistentFlag],
          ),
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
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
    // AndroidNotificationDetails androidPlatformChannelSpecifics =
    //     AndroidNotificationDetails(channelId, 'Main Channel',
    //         channelDescription: 'repeating description');
    // NotificationDetails platformChannelSpecifics =
    //     NotificationDetails(android: androidPlatformChannelSpecifics);
    // await flutterLocalNotificationsPlugin.periodicallyShow(0, 'repeating title',
    //     'repeating body', RepeatInterval.everyMinute, platformChannelSpecifics,
    //     androidAllowWhileIdle: true);
  }

  Future<void> showNotification2(
    int id,
    String title,
    String body,
    int hour,
    int minutes,
    String ringtone,
    String channelId,
  ) async {
    print(hour);
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(Duration(hours: hour, minutes: minutes)),

      NotificationDetails(
        // Android details
        android: AndroidNotificationDetails(
          channelId,
          'Main Channel2',
          channelDescription: "Monish",
          importance: Importance.max,
          priority: Priority.max,
          fullScreenIntent: true,
          icon: '@drawable/ic_stat_sleeping',
          color: Colors.black,
          sound: RawResourceAndroidNotificationSound(ringtone),
          playSound: true,
          additionalFlags: Int32List.fromList(<int>[insistentFlag]),
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

  Future<void> showNotification3(
    int id,
    String title,
    String body,
    int seconds,
    String ringtone,
    String channelId,
  ) async {
    print(seconds);
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(Duration(seconds: 5)),

      NotificationDetails(
        // Android details
        android: AndroidNotificationDetails(channelId, 'Main Channel3',
            channelDescription: "Monish",
            importance: Importance.max,
            priority: Priority.max,
            fullScreenIntent: true,
            icon: '@drawable/ic_stat_sleeping',
            color: Colors.black,
            playSound: true
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
