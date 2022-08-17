// import 'dart:math';
// import 'dart:developer' as developer;
// import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// int randomNumber() {
//   return Random().nextInt(100);
// }

// Future<void> createSleeperlyNotification(int i) async {
//   developer.log(' hello $i');
//   await AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: randomNumber(),
//         channelKey: 'basic_channel',
//         title: 'Hello ',
//         body: 'Wake up!',
//       ),
//       actionButtons: [
//         NotificationActionButton(
//           key: 'Cancel',
//           label: 'Cancel',
//         )
//       ]);
//   final prefs = await SharedPreferences.getInstance();

//   prefs.setInt('currentnotificationnumber', i);
// }
