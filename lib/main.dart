import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sleeperly/current_time.dart';
import 'package:sleeperly/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _configureLocalTimeZone();
  await AndroidAlarmManager.initialize();
  _requestpremission();
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const CurrentTime(),
    },
  ));
}

Future<void> _configureLocalTimeZone() async {
  tz.initializeTimeZones();
  final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName));
}

_requestpremission() async {
  var status = await Permission.notification.status;
  if (status.isGranted) {
    print('Permission granted');
  } else if (status.isDenied) {
    if (await Permission.notification.request() == PermissionStatus.granted) {
      print('Permission granted');
    } else if (await Permission.notification.isPermanentlyDenied) {
      // The user opted to never again see the permission request dialog for this
      // app. The only way to change the permission's status now is to let the
      // user manually enable it in the system settings.
      openAppSettings();
    }
  }
}
