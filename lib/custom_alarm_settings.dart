import 'dart:convert';

import 'package:sleeperly/Themes/dialogtheme.dart';
import 'package:sleeperly/current_time.dart';
import 'package:sleeperly/dialogs/days.dart';
import 'package:sleeperly/dialogs/ringtones.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomAlarmSettings extends StatefulWidget {
  final String time;
  final int index;
  const CustomAlarmSettings({
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        elevation: 3,
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
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
              ),
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
            InkWell(
              onTap: () async {
                getRingtone();
                showDialog(
                    context: context,
                    builder: (context) {
                      return Theme(
                          data: buildDialogTheme(),
                          child: RingtonesDialog(
                            ringtoneList: selectedringtone,
                            ringtone: selectedringtone[widget.index],
                            index: widget.index,
                          ));
                    }).then((value) {
                  FlutterRingtonePlayer.stop();
                });
                final prefs = await SharedPreferences.getInstance();
                List<String> select = prefs.getStringList('ringtone') ?? [];
                FlutterRingtonePlayer.play(
                    fromAsset: "assets/Ringtones/${select[widget.index]}.mp3",
                    looping: false,
                    asAlarm: true);
                print(selectedringtone.length);
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
                            Icons.music_note_outlined,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Ringtone',
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
                        padding: EdgeInsets.only(left: 40, top: 10),
                        child: Text(
                          'Select ringtone for alarm',
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
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Divider(
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Icon(
                          Icons.volume_up_outlined,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'Volume',
                          style: TextStyle(
                              fontSize: 40,
                              fontFamily: 'Montserrat',
                              color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
                Slider(
                  label: r.toString(),
                  thumbColor: const Color.fromARGB(255, 255, 255, 255),
                  activeColor: Colors.white,
                  inactiveColor: const Color.fromARGB(255, 123, 118, 118),
                  min: 0.0,
                  max: 100.0,
                  divisions: 10,
                  onChanged: (value) {
                    setState(() {
                      r = value;
                    });
                  },
                  value: r,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  child: null,
                  decoration: const BoxDecoration(
                    backgroundBlendMode: BlendMode.clear,
                    color: Colors.transparent,
                    image: DecorationImage(
                      image: AssetImage("images/waves.gif"),
                      fit: BoxFit.cover,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
