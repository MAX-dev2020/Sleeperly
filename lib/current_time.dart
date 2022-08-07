import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:sleeperly/Themes/theme_time.dart';
import 'package:sleeperly/custom_alarm.dart';
import 'package:sleeperly/drawer.dart';
import 'package:sleeperly/main.dart';
import 'package:sleeperly/services/awesome_notifications.dart';
import 'package:sleeperly/services/notification_service.dart';
import 'package:sleeperly/sleepcycle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'dart:developer' as developer;

var randomObj = Random();

class CurrentTime extends StatefulWidget {
  const CurrentTime({Key? key}) : super(key: key);

  @override
  State<CurrentTime> createState() => _CurrentTimeState();
}

class _CurrentTimeState extends State<CurrentTime> {
  List<String> time = [];
  List<String> listDays = [];
  List<String> ringtone = [];
  List<String> switchSelected = [];
  String randomId = '';
  int random = 1;
  int setHours = 0;
  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
    _loadIndex();
    _loadDays();
    _loadRingtone();
    _loadSwitch();
    _loadRandomId();
    _loadgetSetHours();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Allow Notifications'),
            content: const Text('Our app would like to send you notifications'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Don\'t Allow',
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
              ),
              TextButton(
                onPressed: () {
                  AwesomeNotifications()
                      .requestPermissionToSendNotifications()
                      .then((_) => Navigator.pop(context));
                },
                child: const Text(
                  'Allow',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      }
    });
    AwesomeNotifications().actionStream.listen((event) async {
      final prefs = await SharedPreferences.getInstance();
      int currentNotificationNumber =
          prefs.getInt('currentnotificationnumber') ?? 0;
      print('currentNotificationNumber: $currentNotificationNumber');
      FlutterRingtonePlayer.stop();
      AndroidAlarmManager.cancel(currentNotificationNumber);
    });
  }

  _loadIndex() async {
    final prefs = await SharedPreferences.getInstance();
    time = prefs.getStringList('time') ?? [];
    // prefs.clear();
  }

  _loadDays() async {
    final prefs = await SharedPreferences.getInstance();
    listDays = prefs.getStringList('days') ?? [];
    // prefs.clear();
  }

  _loadRingtone() async {
    final prefs = await SharedPreferences.getInstance();
    ringtone = prefs.getStringList('ringtone') ?? [];
    // prefs.clear();
  }

  _loadSwitch() async {
    final prefs = await SharedPreferences.getInstance();
    switchSelected = prefs.getStringList('switch') ?? [];
    // prefs.clear();
  }

  _loadRandomId() async {
    final prefs = await SharedPreferences.getInstance();
    randomId = prefs.getString('random') ?? '';
    // prefs.clear();
  }

  _loadgetSetHours() async {
    final prefs = await SharedPreferences.getInstance();
    setHours = prefs.getInt('sethours') ?? 6;
    print(setHours);
    // prefs.clear();
  }

  final StreamController<TimeOfDay> streams = StreamController<TimeOfDay>();
  bool shadow = false;
  TimeOfDay selectedTime = TimeOfDay.now();
  AssetImage background = const AssetImage('images/movesun2.gif');
  AssetImage background2 = const AssetImage('images/movemoon2.gif');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      endDrawer: NavDrawer(
        time: TimeOfDay.now(),
        hours: setHours,
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        shadowColor: Colors.black,
      ),
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              StreamBuilder<Object>(
                  stream: streams.stream,
                  builder: (context, snapshot) {
                    streams.sink.add(TimeOfDay.now());
                    String time = snapshot.data.toString();

                    if (!snapshot.hasData) {
                      return const Text("Loading.....");
                    }

                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        time.substring(10, time.length - 1),
                        style: TextStyle(
                            fontSize: 100,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                            color: const Color.fromARGB(255, 255, 255, 255),
                            shadows: <Shadow>[
                              Shadow(
                                offset: const Offset(5.0, 2.0),
                                blurRadius: 5.0,
                                color: Colors.white.withOpacity(0.3),
                              ),
                            ]),
                      ),
                    );
                  }),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black,
                  image: DecorationImage(
                    image: int.parse(
                                TimeOfDay.now().toString().substring(10, 12)) <
                            19
                        ? background
                        : background2,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 50.0),
                width: 200,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    primary: const Color.fromARGB(255, 0, 0, 0),
                    shadowColor: const Color.fromARGB(255, 255, 255, 255),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0)),
                    minimumSize: const Size(100, 40), //////// HERE
                  ),
                  onPressed: () async {
                    await _loadgetSetHours();

                    if (setHours == 0) {
                      _showDialog(context);
                    }
                    random = randomObj.nextInt(100);
                    List listSetHours = sleepCycle(setHours) ?? [];
                    if (listSetHours.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Come back later',
                            style: TextStyle(
                                fontFamily: 'Montserrat', color: Colors.black),
                          ),
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.white,
                        ),
                      );
                    } else {
                      print(
                          'hours [${listSetHours[0]}] minutes [${listSetHours[1]}]');

                      NotificationService().showNotification2(
                          0,
                          'Hello',
                          'Wake up ',
                          listSetHours[0],
                          listSetHours[1],
                          'wakeup',
                          'New Alarm');

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          'Alarm set for ${listSetHours[0]} hours '
                          '${listSetHours[1]} minutes',
                          style: const TextStyle(
                              fontFamily: 'Montserrat', color: Colors.black),
                        ),
                        duration: const Duration(seconds: 2),
                        backgroundColor: Colors.white,
                      ));
                    }
                  },
                  child: const Text(
                    'Set Alarm',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 20,
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30.0),
                width: 200,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    primary: const Color.fromARGB(255, 0, 0, 0),
                    shadowColor: const Color.fromARGB(255, 255, 255, 255),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0)),
                    minimumSize: const Size(100, 40), //////// HERE
                  ),
                  onPressed: () {
                    FlutterRingtonePlayer.stop();
                    const Text('Cancel Alarm');
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        'Alarm Cancelled',
                        style: TextStyle(
                            fontFamily: 'Montserrat', color: Colors.black),
                      ),
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.white,
                    ));
                  },
                  child: const Text(
                    'Cancel Alarm',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 20,
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 30.0),
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 3,
                        primary: const Color.fromARGB(255, 0, 0, 0),
                        shadowColor: const Color.fromARGB(255, 255, 255, 255),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0)),
                        minimumSize: const Size(100, 40), //////// HERE
                      ),
                      onPressed: () {
                        _loadIndex();
                        _loadDays();
                        _loadRingtone();
                        _loadSwitch();
                        _loadRandomId();

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CustomAlarm(
                              time: time,
                              days: listDays,
                              switchSelected: switchSelected,
                              randomSelected: randomId,
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'Custom Alarm',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 20,
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.w500,
                        ),
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}

_showDialog(BuildContext context) async {
  await showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Set Alarm'),
          content: Text(' Set Alarm for how many hours?'),
        );
      });
}
