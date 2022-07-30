import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

// ignore: must_be_immutable
class RingtonesDialog extends StatefulWidget {
  List<String> ringtoneList;
  String ringtone;
  int index;
  RingtonesDialog(
      {Key? key,
      required this.ringtone,
      required this.index,
      required this.ringtoneList})
      : super(key: key);

  @override
  State<RingtonesDialog> createState() => _RingtonesDialogState();
}

class _RingtonesDialogState extends State<RingtonesDialog> {
  setRingtone(String ringtone) async {
    final prefs = await SharedPreferences.getInstance();
    widget.ringtoneList[widget.index] = ringtone;
    prefs.setStringList('ringtone', widget.ringtoneList);
  }

  @override
  Widget build(BuildContext context) {
    AlertDialog rigtonesDialog = AlertDialog(
        title: const Text('Ringtones'),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          RadioListTile(
              value: 'wakeup',
              groupValue: widget.ringtone,
              onChanged: (String? value) {
                FlutterRingtonePlayer.play(
                    fromAsset: "assets/Ringtones/wakeup.mp3",
                    looping: false,
                    asAlarm: true);
                setState(() {
                  widget.ringtone = value!;
                  setRingtone('wakeup');
                });
              },
              title: const Text('Wakeup')),
          RadioListTile(
              value: 'alarm',
              groupValue: widget.ringtone,
              onChanged: (String? value) {
                FlutterRingtonePlayer.play(
                    fromAsset: "assets/Ringtones/alarm.mp3",
                    looping: false,
                    asAlarm: true);
                setState(() {
                  widget.ringtone = value!;
                  setRingtone('alarm');
                });
              },
              title: const Text('Alarm')),
          RadioListTile(
              value: 'remix',
              groupValue: widget.ringtone,
              onChanged: (String? value) {
                FlutterRingtonePlayer.play(
                    fromAsset: "assets/Ringtones/remix.mp3",
                    looping: false,
                    asAlarm: true);
                setState(() {
                  widget.ringtone = value!;
                  setRingtone('remix');
                });
              },
              title: const Text('Remix')),
          RadioListTile(
              value: 'chime',
              groupValue: widget.ringtone,
              onChanged: (String? value) {
                FlutterRingtonePlayer.play(
                    fromAsset: "assets/Ringtones/chime.mp3",
                    looping: false,
                    asAlarm: true);
                setState(() {
                  widget.ringtone = value!;
                  setRingtone('chime');
                });
              },
              title: const Text('Chime')),
          RadioListTile(
              value: 'clock',
              groupValue: widget.ringtone,
              onChanged: (String? value) {
                FlutterRingtonePlayer.play(
                    fromAsset: "assets/Ringtones/clock.mp3",
                    looping: false,
                    asAlarm: true);
                setState(() {
                  widget.ringtone = value!;
                  setRingtone('clock');
                });
              },
              title: const Text('Clock')),
        ]));
    return rigtonesDialog;
  }
}
