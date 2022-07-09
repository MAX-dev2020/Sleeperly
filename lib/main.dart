import 'package:sleeperly/current_time.dart';
import 'package:sleeperly/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();

  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const CurrentTime(),
    },
  ));
}
