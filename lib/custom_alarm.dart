import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'dart:math';
import 'dart:ui';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:sleeperly/alarm_list.dart';
import 'package:sleeperly/services/awesome_notifications.dart';
import 'package:sleeperly/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:sleeperly/Themes/theme_time.dart';
import 'dart:developer' as developer;
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

var random = new Random();
const String countKey = 'count';
int c = 0;

// ignore: must_be_immutable
class CustomAlarm extends StatefulWidget {
  List<String> time;
  List<String> days;
  List<String> switchSelected;
  String randomSelected;
  CustomAlarm(
      {Key? key,
      required this.time,
      required this.days,
      required this.switchSelected,
      required this.randomSelected})
      : super(key: key);

  @override
  State<CustomAlarm> createState() => _CustomAlarmState();
}

class _CustomAlarmState extends State<CustomAlarm> {
  @override
  void initState() {
    if (c == 0) {
      port.listen((message) async => await stopAlarm(message));
    }
    c++;
    super.initState();
  }

  playRingtone() async {
    FlutterRingtonePlayer.playAlarm();
  }

  static SendPort? uiSendPort;
  int counts = 0;
  Future<void> stopAlarm(int i) async {
    developer.log('Increment counter!');

    counts++;
    createSleeperlyNotification(i);
    FlutterRingtonePlayer.playAlarm();
  }

  static Future<void> callback(int i) async {
    developer.log('Alarm fired! $i');
    // if (i == 0) {
    //   developer.log('Alarm stopped!');
    //   FlutterRingtonePlayer.stop();
    // } else {
    //   developer.log('Alarm firingggg');
    //   FlutterRingtonePlayer.playAlarm();
    // }
    // final prefs = await SharedPreferences.getInstance();
    // final currentCount = prefs.getInt(countKey) ?? 0;
    // await prefs.setInt('countKey', currentCount + 1);
    // FlutterRingtonePlayer.playAlarm();
    // tz.initializeTimeZones();
    uiSendPort ??= IsolateNameServer.lookupPortByName(isolateName);
    uiSendPort?.send(i);
    // NotificationService()
    //     .showNotification2(1, 'OneTIme', 'oneShot', 2, 'Remix', 'sds');
  }

  StreamController<List<String>> streams = StreamController<List<String>>();
  @override
  Widget build(BuildContext context) {
    List<String> selectedringtone = [];
    List<String> listdays = widget.days;
    List<String> listRingtone = [];
    List<String> listSwitch = widget.switchSelected;
    List<String> listTime = [];
    String listRandom = widget.randomSelected;
    List<List<dynamic>> randomNum = [];
    _loaddays() async {
      final prefs = await SharedPreferences.getInstance();
      List<String> convdays = prefs.getStringList('days') ?? [];
      listdays = convdays;
    }

    _loadtime() async {
      final prefs = await SharedPreferences.getInstance();
      widget.time = prefs.getStringList('time') ?? [];
    }

    _loadRingtone() async {
      final prefs = await SharedPreferences.getInstance();
      listRingtone = prefs.getStringList('ringtone') ?? [];
    }

    _loadSwitch() async {
      final prefs = await SharedPreferences.getInstance();
      listSwitch = prefs.getStringList('switch') ?? [];
    }

    _loadRandom() async {
      final prefs = await SharedPreferences.getInstance();
      listRandom = prefs.getString('random') ?? '';
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
                    widget.time.add(timePicked);
                    prefs.setStringList('time', widget.time);
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
                    selectedringtone.add('alarm');
                    prefs.setStringList('ringtone', selectedringtone);

                    listSwitch.clear();
                    listSwitch = prefs.getStringList('switch') ?? [];
                    listSwitch.add('true');
                    prefs.setStringList('switch', listSwitch);

                    listRandom = prefs.getString('random') ?? '';
                    List randomList = [];
                    if (listRandom.isNotEmpty) {
                      randomList = jsonDecode(listRandom);
                    }

                    int num = random.nextInt(100);
                    randomNum = [];

                    print("randomList custom $randomList");
                    for (int i = 0; i < randomList.length; i++) {
                      randomNum.add(randomList[i]);
                    }
                    randomList.add(num);
                    randomNum.add([num]);

                    int hour1;

                    prefs.setString('random', jsonEncode(randomNum));
                    await _loadRandom();

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
                    int days = DateTime.now().day;
                    int minutesss = (listTime[listSwitch.length - 1][2] != ':'
                        ? int.parse((listTime[listSwitch.length - 1][2] +
                            listTime[listSwitch.length - 1][3]))
                        : int.parse((listTime[listSwitch.length - 1][3]) +
                            (listTime[listSwitch.length - 1][4])));
                    print("minutes: $minutesss");
                    print("hour: ${DateTime.now().minute}");
                    if (minutesss <= DateTime.now().minute) {
                      if (days == 7) {
                        days = 0;
                      }
                      days++;
                      print("days now: ${DateTime.now().day}");
                      print("days: $days");
                    }
                    int i = 1;
                    await AndroidAlarmManager.oneShotAt(
                        DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            days,
                            hour1,
                            listTime[listSwitch.length - 1][2] != ':'
                                ? int.parse((listTime[listSwitch.length - 1]
                                        [2] +
                                    listTime[listSwitch.length - 1][3]))
                                : int.parse((listTime[listSwitch.length - 1]
                                        [3]) +
                                    (listTime[listSwitch.length - 1][4])),
                            0),
                        randomList[randomList.length - 1],
                        callback,
                        exact: true,
                        wakeup: true);

                    print(listSwitch.length - 1);
                    print(hour1);

                    // listTime[0][2] != ':'
                    //     ? print(int.parse((listTime[listSwitch.length - 1][2] +
                    //         listTime[listSwitch.length - 1][3])))
                    //     : print(int.parse((listTime[listSwitch.length - 1][3]) +
                    //         (listTime[listSwitch.length - 1][4])));

                    // await NotificationService().showNotification(
                    //     randomList[randomList.length - 1],
                    //     'Hello',
                    //     "Hello World",
                    //     hour1,
                    //     listTime[listSwitch.length - 1][2] != ':'
                    //         ? int.parse((listTime[listSwitch.length - 1][2] +
                    //             listTime[listSwitch.length - 1][3]))
                    //         : int.parse((listTime[listSwitch.length - 1][3]) +
                    //             (listTime[listSwitch.length - 1][4])),
                    //     0,
                    //     'alarm',
                    //     'channel 8');
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
          _loadRandom();

          streams.sink.add(widget.time);
          return AlarmList(
            time: widget.time,
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
