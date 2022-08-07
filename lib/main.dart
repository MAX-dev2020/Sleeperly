import 'dart:ui';
import 'dart:isolate';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:sleeperly/current_time.dart';
import 'package:sleeperly/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

const String isolateName = 'isolate';

/// A port used to communicate from a background isolate to the UI isolate.
final ReceivePort port = ReceivePort();
void main() async {
  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      'resource://drawable/moon2',
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            ledColor: Colors.white,
            channelShowBadge: true)
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupkey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
      debug: true);

  WidgetsFlutterBinding.ensureInitialized();
  await _configureLocalTimeZone();
  await AndroidAlarmManager.initialize();

  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const CurrentTime(),
    },
  ));

  IsolateNameServer.registerPortWithName(
    port.sendPort,
    isolateName,
  );
}

Future<void> _configureLocalTimeZone() async {
  tz.initializeTimeZones();
  final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName));
}
