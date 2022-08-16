import 'dart:async';
import 'dart:convert';
import 'alarm_list.dart';
import 'package:sleeperly/Themes/dialogtheme.dart';
import 'package:sleeperly/Themes/theme_time.dart';
import 'package:sleeperly/current_time.dart';
import 'package:sleeperly/dialogs/days.dart';
import 'package:sleeperly/dialogs/ringtones.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:shared_preferences/shared_preferences.dart';

String timePicked = '00:00';

class CustomAlarmSettings extends StatefulWidget {
  String time;
  final int index;
  CustomAlarmSettings({
    Key? key,
    required this.time,
    required this.index,
  }) : super(key: key);

  @override
  State<CustomAlarmSettings> createState() => _CustomAlarmSettingsState();
}

class _CustomAlarmSettingsState extends State<CustomAlarmSettings> {
  List<Map> mapdays = [];
  List<String> selectedringtone = [];
  double r = 20.0;
  _loadIndex() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> convdays = prefs.getStringList('days') ?? [];
    mapdays = [];
    for (var element in convdays) {
      mapdays.add(json.decode(element));
    }
  }

  getRingtone() async {
    final prefs = await SharedPreferences.getInstance();
    selectedringtone = prefs.getStringList('ringtone') ?? [];
  }

  @override
  Widget build(BuildContext context) {
    StreamController<String> controller = StreamController<String>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        elevation: 3,
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: StreamBuilder<Object>(
                stream: controller.stream,
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    widget.time = snapshot.data.toString();
                  }

                  return Text(
                    widget.time,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 60,
                      fontFamily: 'Montserrat',
                      shadows: <Shadow>[
                        Shadow(
                          offset: const Offset(5.0, 2.0),
                          blurRadius: 5.0,
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ],
                    ),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: InkWell(
              onTap: () {
                _loadIndex();
                showDialog(
                    context: context,
                    builder: (context) {
                      return Theme(
                          data: buildDialogTheme(),
                          child: DaysDialog(
                            index: widget.index,
                            mapdays: mapdays,
                          ));
                    });
              },
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.repeat_outlined,
                            color: Colors.white,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              'Repeat',
                              style: TextStyle(
                                  fontSize: 40,
                                  fontFamily: 'Montserrat',
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 40, top: 10),
                        child: Text(
                          "Select days to repeat alarm",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Montserrat',
                              color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Divider(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          // InkWell(
          //   onTap: () async {
          //     getRingtone();
          //     showDialog(
          //         context: context,
          //         builder: (context) {
          //           return Theme(
          //               data: buildDialogTheme(),
          //               child: RingtonesDialog(
          //                 ringtoneList: selectedringtone,
          //                 ringtone: selectedringtone[widget.index],
          //                 index: widget.index,
          //               ));
          //         }).then((value) {
          //       FlutterRingtonePlayer.stop();
          //     });
          //     final prefs = await SharedPreferences.getInstance();
          //     List<String> select = prefs.getStringList('ringtone') ?? [];
          //     FlutterRingtonePlayer.play(
          //         fromAsset: "assets/Ringtones/${select[widget.index]}.mp3",
          //         looping: false,
          //         asAlarm: true);
          //     print(selectedringtone.length);
          //   },
          //   child: Align(
          //     alignment: Alignment.topLeft,
          //     child: Column(
          //       children: [
          //         Row(
          //           children: const [
          //             Padding(
          //               padding: EdgeInsets.only(left: 20),
          //               child: Icon(
          //                 Icons.music_note_outlined,
          //                 color: Colors.white,
          //               ),
          //             ),
          //             Padding(
          //               padding: EdgeInsets.only(left: 20),
          //               child: Text(
          //                 'Ringtone',
          //                 style: TextStyle(
          //                     fontSize: 40,
          //                     fontFamily: 'Montserrat',
          //                     color: Colors.white),
          //               ),
          //             ),
          //           ],
          //         ),
          //         const Align(
          //           alignment: Alignment.topLeft,
          //           child: Padding(
          //             padding: EdgeInsets.only(left: 40, top: 10),
          //             child: Text(
          //               'Select ringtone for alarm',
          //               style: TextStyle(
          //                   fontSize: 20,
          //                   fontFamily: 'Montserrat',
          //                   color: Colors.white),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // const Padding(
          //   padding: EdgeInsets.only(top: 10, bottom: 10),
          //   child: Divider(
          //     color: Color.fromARGB(255, 255, 255, 255),
          //   ),
          // ),
          InkWell(
            onTap: () async {
              getRingtone();
              TimeOfDay? picked = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
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
                timePicked = getformattedTime(picked);
                controller.sink.add(timePicked);
                // final prefs = await SharedPreferences.getInstance();
                // List<String> select = prefs.getStringList('time') ?? [];
                // select[widget.index] = timePicked;
                // prefs.setStringList('time', select);
              }
            },
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                children: [
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Icon(
                          Icons.edit_notifications_outlined,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'Edit Alarm',
                          style: TextStyle(
                              fontSize: 40,
                              fontFamily: 'Montserrat',
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 40, top: 10, bottom: 10),
                      child: Text(
                        'Edit time for alarm',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Montserrat',
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 0),
            child: Divider(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),

          Expanded(
            // your image goes here which will take as much height as possible.

            child: Image.asset(
              'images/waves.gif',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          // height: MediaQuery.of(context).size.height,
          // width: MediaQuery.of(context).size.width,
          // child: null,
          // decoration: const BoxDecoration(
          //   backgroundBlendMode: BlendMode.clear,
          //   color: Colors.transparent,
          //   image: DecorationImage(
          //     image: AssetImage("images/waves.gif"),
          //     fit: BoxFit.cover,
          //     alignment: Alignment.topCenter,
          //   ),
          // ))
        ],
      ),
    );
  }
}

getformattedTime(TimeOfDay time) {
  int hour = time.hour;
  if (time.hour > 12) {
    hour = int.parse(time.hour.toString()) - 12;
  }
  if (time.hour == 0) {
    hour = 12;
  }
  String minute =
      time.minute < 10 ? '0' + time.minute.toString() : time.minute.toString();
  return '$hour:$minute ${(time.period.toString().split('.')[1]).toUpperCase()}';
}
