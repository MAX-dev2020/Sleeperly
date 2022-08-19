import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:sleeperly/alarm_list.dart';
import 'package:sleeperly/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:sleeperly/Themes/theme_time.dart';
import 'package:shared_preferences/shared_preferences.dart';

var random = new Random();

// ignore: must_be_immutable
class CustomAlarm extends StatelessWidget {
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
  Widget build(BuildContext context) {
    StreamController<List<String>> streams = StreamController<List<String>>();
    List<String> selectedringtone = [];
    List<String> listdays = days;
    List<String> listRingtone = [];
    List<String> listSwitch = switchSelected;
    List<String> listTime = [];
    String listRandom = randomSelected;
    List<List<dynamic>> randomNum = [];
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

                    final prefs = await SharedPreferences.getInstance();
                    if (timePicked[0] == '0') {
                      timePicked = timePicked.substring(1);
                      timePicked = '12' + timePicked;
                    }
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
                    listdays.clear();
                    for (var element in mapDays) {
                      listdays.add(jsonEncode(element));
                    }

                    prefs.setStringList('days', listdays);
                    selectedringtone = prefs.getStringList('ringtone') ?? [];
                    selectedringtone.add('wakeup');
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
                    await NotificationService().showNotification(
                        randomList[randomList.length - 1],
                        'Hello',
                        "Hello World",
                        hour1,
                        listTime[listSwitch.length - 1][2] != ':'
                            ? int.parse((listTime[listSwitch.length - 1][2] +
                                listTime[listSwitch.length - 1][3]))
                            : int.parse((listTime[listSwitch.length - 1][3]) +
                                (listTime[listSwitch.length - 1][4])),
                        0,
                        'alarm',
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
          _loadRandom();
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
