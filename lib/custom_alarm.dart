import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:sleeperly/alarm_list.dart';
import 'package:sleeperly/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:sleeperly/Themes/theme_time.dart';
import 'dart:developer' as developer;
import 'package:shared_preferences/shared_preferences.dart';

var random = new Random();

// ignore: must_be_immutable
class CustomAlarm extends StatelessWidget {
  List<String> time;
  List<String> days;
  List<String> switchSelected;
  List<String> randomSelected;
  CustomAlarm(
      {Key? key,
      required this.time,
      required this.days,
      required this.switchSelected,
      required this.randomSelected})
      : super(key: key);

  // static Future<void> callback() async {
  //   developer.log('Alarm fired!');
  //   await FlutterRingtonePlayer.play(
  //     android: AndroidSounds.alarm,
  //     ios: IosSounds.alarm,
  //   );
  //   tz.initializeTimeZones();
  //   NotificationService()
  //       .showNotification2(1, 'OneTIme', 'oneShot', 2, 'Remix', 'sds');
  // }

  @override
  Widget build(BuildContext context) {
    StreamController<List<String>> streams = StreamController<List<String>>();
    List<String> selectedringtone = [];
    List<String> listdays = days;
    List<String> listRingtone = [];
    List<String> listSwitch = switchSelected;
    List<String> listTime = [];
    List<String> listRandom = randomSelected;
    int randomNum;
    _loaddays() async {
      final prefs = await SharedPreferences.getInstance();
      List<String> convdays = prefs.getStringList('days') ?? [];
      listdays = convdays;
    }

    _loadtime() async {
      final prefs = await SharedPreferences.getInstance();
      time = prefs.getStringList('time') ?? [];
    }

    _loadRingtone() async {
      final prefs = await SharedPreferences.getInstance();
      listRingtone = prefs.getStringList('ringtone') ?? [];
    }

    _loadSwitch() async {
      final prefs = await SharedPreferences.getInstance();
      listSwitch = prefs.getStringList('switch') ?? [];
    }

    TimeOfDay selectedtime = TimeOfDay.now();
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.black,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
                color: Colors.white,
                icon: const Icon(Icons.alarm_add),
                onPressed: () async {
                  TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: selectedtime,
                    builder: (context, child) {
                      return MediaQuery(
                        data: MediaQuery.of(context).copyWith(
                            alwaysUse24HourFormat: false, textScaleFactor: 1),
                        child: Theme(
                          data: buildShrineTheme(),
                          child: child!,
                        ),
                      );
                    },
                  );
                  if (picked != null) {
                    listTime.clear();
                    String timePicked = getformattedTime(picked);
                    print(timePicked);
                    final prefs = await SharedPreferences.getInstance();
                    time.add(timePicked);
                    prefs.setStringList('time', time);
                    listTime = prefs.getStringList('time') ?? [];
                    listdays = prefs.getStringList('days') ?? [];
                    List<Map> mapDays = [];
                    for (var element in listdays) {
                      mapDays.add(json.decode(element));
                    }
                    mapDays.add({
                      'Never': true,
                      'EveryDay': false,
                      'Monday': false,
                      'Tuesday': false,
                      'Wednesday': false,
                      'Thursday': false,
                      'Friday': false,
                      'Saturday': false,
                      'Sunday': false,
                    });
                    int anyTrue = 0;
                    listdays.clear();
                    for (var element in mapDays) {
                      listdays.add(jsonEncode(element));
                    }

                    prefs.setStringList('days', listdays);
                    selectedringtone = prefs.getStringList('ringtone') ?? [];
                    selectedringtone.add('Wake Up');
                    prefs.setStringList('ringtone', selectedringtone);

                    listSwitch.clear();
                    listSwitch = prefs.getStringList('switch') ?? [];
                    listSwitch.add('true');
                    prefs.setStringList('switch', listSwitch);

                    listRandom = prefs.getStringList('random') ?? [];
                    randomNum = random.nextInt(100);
                    while (true) {
                      if (listRandom.contains(randomNum.toString())) {
                        randomNum = random.nextInt(100);
                      } else {
                        break;
                      }
                    }
                    int hour1;
                    listRandom.add(randomNum.toString());
                    prefs.setStringList('random', listRandom);
                    if (listTime[listSwitch.length - 1][6] == 'P' ||
                        listTime[listSwitch.length - 1][5] == 'P') {
                      if (int.parse(
                              listTime[listSwitch.length - 1].split(':')[0]) ==
                          12) {
                        hour1 = int.parse(
                            listTime[listSwitch.length - 1].split(':')[0]);
                      } else {
                        hour1 = int.parse(
                                listTime[listSwitch.length - 1].split(':')[0]) +
                            12;
                      }
                    } else {
                      if (int.parse(
                              listTime[listSwitch.length - 1].split(':')[0]) ==
                          12) {
                        hour1 = 0;
                      } else {
                        hour1 = int.parse(
                            listTime[listSwitch.length - 1].split(':')[0]);
                      }
                    }
                    print("randomNum: $randomNum");

                    // await AndroidAlarmManager.oneShot(
                    //   const Duration(seconds: 5),
                    //   // Ensure we have a unique alarm ID.
                    //   1,
                    //   callback,
                    //   exact: true,
                    //   wakeup: true,
                    // );
                    // AndroidAlarmManager.periodic(
                    //     const Duration(seconds: 60), 1, callback,
                    //     startAt: DateTime(
                    //         DateTime.now().year,
                    //         DateTime.now().month,
                    //         hour1,
                    //         listTime[0][2] != ':'
                    //             ? int.parse((listTime[listSwitch.length - 1]
                    //                     [2] +
                    //                 listTime[listSwitch.length - 1][3]))
                    //             : int.parse((listTime[listSwitch.length - 1]
                    //                     [3]) +
                    //                 (listTime[listSwitch.length - 1][4])),
                    //         0),
                    //     exact: true,
                    //     wakeup: true);
                    print(listSwitch.length - 1);
                    print(hour1);

                    listTime[0][2] != ':'
                        ? print(int.parse((listTime[listSwitch.length - 1][2] +
                            listTime[listSwitch.length - 1][3])))
                        : print(int.parse((listTime[listSwitch.length - 1][3]) +
                            (listTime[listSwitch.length - 1][4])));

                    NotificationService().showNotification(
                        randomNum,
                        'Hello',
                        "Hello World",
                        hour1,
                        listTime[listSwitch.length - 1][2] != ':'
                            ? int.parse((listTime[listSwitch.length - 1][2] +
                                listTime[listSwitch.length - 1][3]))
                            : int.parse((listTime[listSwitch.length - 1][3]) +
                                (listTime[listSwitch.length - 1][4])),
                        0,
                        'Wake Up',
                        '$randomNum');
                  }
                }),
          ),
        ],
      ),
      body: StreamBuilder<Object>(
        //this will build the list of alarms in an isntant state
        stream: streams.stream,
        builder: (context, snapshot) {
          _loaddays();
          _loadtime();
          _loadRingtone();
          _loadSwitch();
          streams.sink.add(time);
          return AlarmList(
            time: time,
            days: listdays,
            ringtone: listRingtone,
            switchSelected: listSwitch,
            randomId: listRandom,
          );
        },
      ),
    );
  }
}

getformattedTime(TimeOfDay time) {
  int hour = time.hour;
  if (time.hour > 12) {
    hour = int.parse(time.hour.toString()) - 12;
  }
  String minute =
      time.minute < 10 ? '0' + time.minute.toString() : time.minute.toString();
  return '$hour:$minute ${(time.period.toString().split('.')[1]).toUpperCase()}';
}
