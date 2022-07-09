import 'package:sleeperly/services/notification_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:convert';
import 'package:sleeperly/custom_alarm_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

// ignore: must_be_immutable
class AlarmList extends StatefulWidget {
  List<String> time;
  List<String> days;
  List<String> ringtone;
  List<String> switchSelected;
  List<String> randomId;
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
  bool s = false;
  List<String> latestDays = [];
  List<String> latestDays1 = [];
  List<String> latestRingtone1 = [];
  List<String> latestRingtone = [];
  List<String> latestTime1 = [];
  List<String> latestTime = [];
  List<String> latestSwitchSelected = [];
  List<String> latestSwitchSelected1 = [];
  List<String> latestRandom = [];
  List<String> latestRandom1 = [];
  String id = '';
  String ringtone = '';
  int screen = 0;
  String times = '';
  var item;
  String switches = '';
  int hour = 0;
  @override
  Widget build(BuildContext context) {
    String days = '';

    List<String> finalDays = widget.days;
    List<Map> finalDaysMaps = [];
    List<String> finalRingtone = widget.ringtone;

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

    String getRingtones(int index) {
      String values = '';
      try {
        values = finalRingtone[index];
      } catch (e) {
        values = 'Wake Up';
      }

      return values;
    }

    bool isSwitchEnabled(int index) {
      try {
        if (widget.switchSelected[index] == 'false') {
          return false;
        } else {
          return true;
        }
      } catch (e) {
        print("wrong");
        return false;
      }
    }

    setSwitch() async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setStringList('switch', widget.switchSelected);
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
                        onPressed: () {
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
                          print("latestdays ${latestDays.length}");
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
                          print("latestringtone ${latestRingtone}");
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
                          print("latestswitch ${widget.switchSelected}");

                          latestRandom = prefs.getStringList('random') ?? [];
                          setState(() {
                            latestRandom.insert(
                              index,
                              id,
                            );
                          });
                          prefs.setStringList('random', latestRandom);
                          widget.randomId = prefs.getStringList('random') ?? [];
                          print("latestrandom ${widget.randomId}");

                          if (widget.time[index][6] == 'P' ||
                              widget.time[index][5] == 'P') {
                            hour = int.parse(widget.time[index].split(':')[0]) +
                                12;
                          } else {
                            hour = int.parse(widget.time[index].split(':')[0]);
                          }
                          NotificationService().showNotification(
                              int.parse(widget.randomId[index]),
                              'Hello',
                              "Hello World",
                              hour,
                              widget.time[index][2] != ':'
                                  ? int.parse((widget.time[index][2] +
                                      widget.time[index][3]))
                                  : int.parse((widget.time[index][3]) +
                                      (widget.time[index][4])),
                              'Wake Up',
                              'New Alarm');
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
                    print("latestringtone ${latestRingtone1}");
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

                    print("time ${widget.time.length}");
                    print("mapdays ${mapdays1.length}");

                    List<String> convdays1 = [];
                    for (var element in mapdays1) {
                      convdays1.add(json.encode(element));
                    }
                    print("$convdays1");
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
                    print("latestswitch ${latestSwitchSelected1}");

                    latestRandom1 = prefs.getStringList('random') ?? [];
                    id = latestRandom1[index];
                    setState(() {
                      latestRandom1.removeAt(index);
                    });

                    prefs.setStringList('random', latestRandom1);
                    widget.randomId = prefs.getStringList('random') ?? [];
                    print("latestrandom ${latestRandom1}");

                    NotificationService().cancelNotification(int.parse(id));
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  },
                  child: SizedBox(
                    height: 140,
                    child: InkWell(
                      splashColor: Colors.white,
                      onTap: () {
                        print("index $index");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CustomAlarmSettings(
                              time: widget.time[index],
                              index: index,
                            ),
                          ),
                        );
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
                                  onChanged: (value) {
                                    setState(() {
                                      widget.switchSelected[index] =
                                          value.toString();
                                      setSwitch();
                                      print(index);
                                    });
                                    if (!value) {
                                      NotificationService().cancelNotification(
                                          int.parse(widget.randomId[index]));
                                    } else {
                                      if (widget.time[index][6] == 'P' ||
                                          widget.time[index][5] == 'P') {
                                        hour = int.parse(widget.time[index]
                                                .split(':')[0]) +
                                            12;
                                      } else {
                                        hour = int.parse(
                                            widget.time[index].split(':')[0]);
                                      }
                                      NotificationService().showNotification(
                                          int.parse(widget.randomId[index]),
                                          'Hello',
                                          "Hello World",
                                          int.parse(
                                              widget.time[index].split(':')[0]),
                                          widget.time[index][2] != ':'
                                              ? int.parse((widget.time[index]
                                                      [2] +
                                                  widget.time[index][3]))
                                              : int.parse((widget.time[index]
                                                      [3]) +
                                                  (widget.time[index][4])),
                                          'Wake Up',
                                          'New Alarm');
                                    }
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 30, right: 10, bottom: 10),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  getRingtones(index),
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontSize: 13,
                                      fontFamily: 'Montserrat'),
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