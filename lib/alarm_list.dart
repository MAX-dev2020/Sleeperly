import 'package:sleeperly/custom_alarm.dart';
import 'package:sleeperly/services/notification_service.dart';

import 'dart:convert';
import 'package:sleeperly/custom_alarm_settings.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class AlarmList extends StatefulWidget {
  List<String> time;
  List<String> days;
  List<String> ringtone;
  List<String> switchSelected;
  String randomId;

  AlarmList({
    Key? key,
    required this.time,
    required this.days,
    required this.ringtone,
    required this.switchSelected,
    required this.randomId,
  }) : super(key: key);

  @override
  State<AlarmList> createState() => _AlarmListState();
}

class _AlarmListState extends State<AlarmList> {
  List<String> latestDays = [];
  List<String> latestDays1 = [];
  List<String> latestRingtone1 = [];
  List<String> latestRingtone = [];
  List<String> latestTime1 = [];
  List<String> latestTime = [];
  List<String> latestSwitchSelected = [];
  List<String> latestSwitchSelected1 = [];
  String latestRandom = '';
  String latestRandom1 = '';
  List<List<int>> finalRandom = [];
  int id = 0;
  List oldId = [];
  String ringtone = '';
  int oldIndex = 0;
  int screen = 0;
  int randomnumber = 0;
  String times = '';
  List<String> finalTime = [];
  var item = '';

  List<String> day = [
    'Never',
    'EveryDay',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  String switches = '';
  int hour = 0;
  @override
  Widget build(BuildContext context) {
    String days = '';

    List<String> finalDays = widget.days;
    List<Map> finalDaysMaps = [];
    List<String> finalRingtone = widget.ringtone;

    _loaddays() async {
      final prefs = await SharedPreferences.getInstance();
      List<String> convdays = prefs.getStringList('days') ?? [];
      finalDays = convdays;
    }

    _loadtime() async {
      final prefs = await SharedPreferences.getInstance();
      List<String> convtime = prefs.getStringList('time') ?? [];
      widget.time = convtime;
    }

    _loadRandom(int index, int i) async {
      final prefs = await SharedPreferences.getInstance();
      String convdays = prefs.getString('random') ?? '';
      List convdaysList = jsonDecode(convdays);

      id = convdaysList[index][i];
    }

    for (var element in finalDays) {
      finalDaysMaps.add(json.decode(element));
    }
    String getMapValues(int index) {
      String values = '';
      int i = 0;

      for (var element in finalDaysMaps[index].values) {
        if (element) {
          if (element == true && (i == 0 || i == 1)) {
            values += ' ' + finalDaysMaps[index].keys.elementAt(i) + ' ';
            return values;
          }
          values += ' ' + finalDaysMaps[index].keys.elementAt(i) + ' ';
        }
        i++;
      }

      return values;
    }

    int getDay(int index) {
      int i = 0;
      for (var element in finalDaysMaps[index].values) {
        if (element) {
          print(element);
          if (finalDaysMaps[index].keys.elementAt(i) == 'Monday') {
            return 1;
          }
          if (finalDaysMaps[index].keys.elementAt(i) == 'Tuesday') {
            return 2;
          }
          if (finalDaysMaps[index].keys.elementAt(i) == 'Wednesday') {
            return 3;
          }
          if (finalDaysMaps[index].keys.elementAt(i) == 'Thursday') {
            return 4;
          }
          if (finalDaysMaps[index].keys.elementAt(i) == 'Friday') {
            return 5;
          }
          if (finalDaysMaps[index].keys.elementAt(i) == 'Saturday') {
            return 6;
          }
          if (finalDaysMaps[index].keys.elementAt(i) == 'Sunday') {
            return 7;
          }
        }
        i++;
      }
      return 0;
    }

    int getDays(String day) {
      if (day == 'Monday') {
        return 1;
      }
      if (day == 'Tuesday') {
        return 2;
      }
      if (day == 'Wednesday') {
        return 3;
      }
      if (day == 'Thursday') {
        return 4;
      }
      if (day == 'Friday') {
        return 5;
      }
      if (day == 'Saturday') {
        return 6;
      }
      if (day == 'Sunday') {
        return 7;
      }
      return 0;
    }

    setRandom(int index, List num) async {
      final prefs = await SharedPreferences.getInstance();
      String convdays = prefs.getString('random') ?? '';
      List convdaysList = jsonDecode(convdays);
      convdaysList.insert(index, num);
      prefs.setString('random', jsonEncode(convdaysList));
    }

    getRandomNum() async {
      final prefs = await SharedPreferences.getInstance();
      String convdays = prefs.getString('random') ?? '';
      List randomList = [];
      randomList = jsonDecode(convdays);
      randomnumber = random.nextInt(100);
      while (true) {
        if (randomList.contains(num) && randomList.isNotEmpty) {
          randomnumber = random.nextInt(100);
        } else {
          break;
        }
      }
    }

    _loadRingtone() async {
      final prefs = await SharedPreferences.getInstance();
      finalRingtone = prefs.getStringList('ringtone') ?? [];
    }

    bool isSwitchEnabled(int index) {
      try {
        if (widget.switchSelected[index] == 'false') {
          return false;
        } else {
          return true;
        }
      } catch (e) {
        return false;
      }
    }

    setSwitch() async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setStringList('switch', widget.switchSelected);
    }

    setNotifications(int index) async {
      List number = [];
      int count = 0;
      for (int i = 0; i < 9; i++) {
        if (finalDaysMaps[index][day[i]] == true) {
          if (widget.time[index][6] == 'P' || widget.time[index][5] == 'P') {
            if (int.parse(widget.time[index].split(':')[0]) == 12) {
              hour = int.parse(widget.time[index].split(':')[0]);
            } else {
              hour = int.parse(widget.time[index].split(':')[0]) + 12;
            }
          } else {
            if (int.parse(widget.time[index].split(':')[0]) == 12) {
              hour = 0;
            } else {
              hour = int.parse(widget.time[index].split(':')[0]);
            }
          }
          _loadRandom(index, count);
          _loadRingtone();
          String ringtoneNow = finalRingtone[index];

          count++;
          await NotificationService().showNotification(
              id,
              'Hello',
              "Hello World",
              hour,
              widget.time[index][2] != ':'
                  ? int.parse((widget.time[index][2] + widget.time[index][3]))
                  : int.parse(
                      (widget.time[index][3]) + (widget.time[index][4])),
              getDays(day[i]),
              ringtoneNow,
              'New Alarm');
          number.add(randomnumber);
        }
      }
    }

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ScrollConfiguration(
        behavior: const ScrollBehavior(),
        child: GlowingOverscrollIndicator(
          color: Colors.white,
          axisDirection: AxisDirection.down,
          child: ListView.separated(
            itemCount: widget.time.length,
            itemBuilder: (BuildContext context, int index) {
              try {
                item = widget.time[index];
              } catch (e) {
                item = widget.time[index - 1];
              }

              return Dismissible(
                  background: Container(
                    color: Colors.white,
                    child: const Icon(Icons.close_outlined),
                  ),
                  key: Key(item),
                  confirmDismiss: (direction) async {
                    final prefs = await SharedPreferences.getInstance();
                    final snackbar = SnackBar(
                      elevation: 5,
                      duration: const Duration(seconds: 2),
                      backgroundColor: Colors.white,
                      content: const Text(
                        'Alarm Deleted',
                        style: TextStyle(
                            color: Colors.black, fontFamily: 'Montserrat'),
                      ),
                      action: SnackBarAction(
                        label: 'Undo',
                        textColor: Colors.black,
                        onPressed: () async {
                          latestTime = prefs.getStringList('time') ?? [];
                          setState(() {
                            latestTime.insert(index, times);
                          });
                          prefs.setStringList('time', latestTime);
                          widget.time = prefs.getStringList('time') ?? [];

                          latestDays = prefs.getStringList('days') ?? [];
                          setState(() {
                            latestDays.insert(
                              index,
                              latestDays1[index],
                            );
                          });
                          prefs.setStringList('days', latestDays);
                          widget.days = prefs.getStringList('days') ?? [];
                          finalDays = widget.days;

                          latestRingtone =
                              prefs.getStringList('ringtone') ?? [];
                          setState(() {
                            latestRingtone.insert(
                              index,
                              ringtone,
                            );
                          });
                          prefs.setStringList('ringtone', latestRingtone);
                          widget.ringtone =
                              prefs.getStringList('ringtone') ?? [];

                          latestSwitchSelected =
                              prefs.getStringList('switch') ?? [];
                          setState(() {
                            latestSwitchSelected.insert(
                              index,
                              switches,
                            );
                          });

                          prefs.setStringList('switch', latestSwitchSelected);
                          widget.switchSelected =
                              prefs.getStringList('switch') ?? [];
                          latestRandom = prefs.getString('random') ?? '';
                          List randomList = json.decode(latestRandom);
                          setState(() {
                            randomList.insert(
                              index,
                              oldId,
                            );
                          });
                          prefs.setString('random', jsonEncode(randomList));
                          widget.randomId = prefs.getString('random') ?? '';
                          for (int i = 0; i < randomList[index].length; i++) {
                            NotificationService()
                                .cancelNotification(randomList[index][i]);
                          }
                          setNotifications(index);
                        },
                      ),
                    );

                    latestTime1 = prefs.getStringList('time') ?? [];
                    times = latestTime1[index];
                    setState(() {
                      latestTime1.removeAt(index);
                    });

                    prefs.setStringList('time', latestTime1);
                    widget.time = prefs.getStringList('time') ?? [];

                    latestRingtone1 = prefs.getStringList('ringtone') ?? [];
                    ringtone = latestRingtone1[index];
                    setState(() {
                      latestRingtone1.removeAt(index);
                    });

                    prefs.setStringList('ringtone', latestRingtone1);
                    widget.ringtone = prefs.getStringList('ringtone') ?? [];

                    latestDays1 = prefs.getStringList('days') ?? [];
                    List<Map> mapdays1 = [];
                    List<String> convdays = prefs.getStringList('days') ?? [];
                    for (var element in convdays) {
                      mapdays1.add(json.decode(element));
                    }
                    setState(() {
                      mapdays1.removeAt(index);
                    });
                    List<String> convdays1 = [];
                    for (var element in mapdays1) {
                      convdays1.add(json.encode(element));
                    }
                    prefs.setStringList('days', convdays1);
                    widget.days = prefs.getStringList('days') ?? [];
                    finalDays = widget.days;

                    latestSwitchSelected1 = prefs.getStringList('switch') ?? [];
                    switches = latestSwitchSelected1[index];
                    setState(() {
                      latestSwitchSelected1.removeAt(index);
                    });

                    prefs.setStringList('switch', latestSwitchSelected1);
                    widget.switchSelected = prefs.getStringList('switch') ?? [];

                    latestRandom1 = prefs.getString('random') ?? '';

                    List randomList = jsonDecode(latestRandom1);
                    oldId = randomList[index];
                    setState(() {
                      randomList.removeAt(index);
                    });

                    prefs.setString('random', jsonEncode(randomList));
                    widget.randomId = prefs.getString('random') ?? '';

                    NotificationService().cancelNotification(id);
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  },
                  child: SizedBox(
                    height: 110,
                    child: InkWell(
                      splashColor: Colors.white,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CustomAlarmSettings(
                                    time: widget.time[index],
                                    index: index,
                                  )),
                        ).then((value) async {
                          await _loaddays();
                          await _loadRingtone();

                          final prefs = await SharedPreferences.getInstance();
                          List<String> select =
                              prefs.getStringList('time') ?? [];
                          if (timePicked != '00:00') {
                            select[index] = timePicked;
                            prefs.setStringList('time', select);
                          }
                          timePicked = '00:00';

                          String ringtoneNow = finalRingtone[index];
                          finalDaysMaps = [];
                          for (var element in finalDays) {
                            finalDaysMaps.add(json.decode(element));
                          }
                          await _loadtime();

                          String convdays = prefs.getString('random') ?? '';
                          List randomList = jsonDecode(convdays);
                          if (randomList[index].isNotEmpty) {
                            for (int i = 0; i < randomList[index].length; i++) {
                              NotificationService()
                                  .cancelNotification(randomList[index][i]);
                            }
                          } else {
                            _loadRandom(index, 0);
                            NotificationService().cancelNotification(id);
                          }

                          randomList.removeAt(index);
                          prefs.setString('random', jsonEncode(randomList));
                          List number = [];
                          for (int i = 0; i < 9; i++) {
                            if (finalDaysMaps[index][day[i]] == true &&
                                i != 1) {
                              await getRandomNum();
                              if (widget.time[index][6] == 'P' ||
                                  widget.time[index][5] == 'P') {
                                if (int.parse(
                                        widget.time[index].split(':')[0]) ==
                                    12) {
                                  hour = int.parse(
                                      widget.time[index].split(':')[0]);
                                } else {
                                  hour = int.parse(
                                          widget.time[index].split(':')[0]) +
                                      12;
                                }
                              } else {
                                if (int.parse(
                                        widget.time[index].split(':')[0]) ==
                                    12) {
                                  hour = 0;
                                } else {
                                  hour = int.parse(
                                      widget.time[index].split(':')[0]);
                                }
                              }
                              await NotificationService().showNotification(
                                  randomnumber,
                                  'Hello',
                                  "Hello World",
                                  hour,
                                  widget.time[index][2] != ':'
                                      ? int.parse((widget.time[index][2] +
                                          widget.time[index][3]))
                                      : int.parse((widget.time[index][3]) +
                                          (widget.time[index][4])),
                                  getDays(day[i]),
                                  'alarm',
                                  'New Alarm');
                              number.add(randomnumber);
                            }
                          }
                          setRandom(index, number);
                        });
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color.fromARGB(255, 0, 0, 0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ListTile(
                                isThreeLine: true,
                                title: Text(
                                  widget.time[index],
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontSize: 40,
                                      fontFamily: 'Montserrat'),
                                ),
                                subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      getMapValues(index),
                                      style: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 13,
                                          fontFamily: 'Montserrat'),
                                    )),
                                trailing: Switch(
                                  value: isSwitchEnabled(index),
                                  onChanged: (value) async {
                                    setState(() {
                                      widget.switchSelected[index] =
                                          value.toString();
                                      setSwitch();
                                    });
                                    if (!value) {
                                      final prefs =
                                          await SharedPreferences.getInstance();
                                      String convdays =
                                          prefs.getString('random') ?? '';
                                      List randomList = jsonDecode(convdays);
                                      for (int i = 0;
                                          i < randomList[index].length;
                                          i++) {
                                        NotificationService()
                                            .cancelNotification(
                                                randomList[index][i]);
                                      }
                                    } else {
                                      _loadRingtone();
                                      String ringtoneNow = finalRingtone[index];
                                      setNotifications(index);
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ));
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(
              height: 10,
            ),
          ),
        ),
      ),
    );
  }
}
