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
              value: 'Wake Up',
              groupValue: widget.ringtone,
              onChanged: (String? value) {
                FlutterRingtonePlayer.play(
                    fromAsset: "assets/Ringtones/Wake Up.mp3",
                    looping: false,
                    asAlarm: true);
                setState(() {
                  widget.ringtone = value!;
                  setRingtone('Wake Up');
                });
              },
              title: const Text('Wake Up')),
          RadioListTile(
              value: 'Alarm',
              groupValue: widget.ringtone,
              onChanged: (String? value) {
                FlutterRingtonePlayer.play(
                    fromAsset: "assets/Ringtones/Alarm.mp3",
                    looping: false,
                    asAlarm: true);
                setState(() {
                  widget.ringtone = value!;
                  setRingtone('Alarm');
                });
              },
              title: const Text('Alarm')),
          RadioListTile(
              value: 'Remix',
              groupValue: widget.ringtone,
              onChanged: (String? value) {
                FlutterRingtonePlayer.play(
                    fromAsset: "assets/Ringtones/Remix.mp3",
                    looping: false,
                    asAlarm: true);
                setState(() {
                  widget.ringtone = value!;
                  setRingtone('Remix');
                });
              },
              title: const Text('Remix')),
          RadioListTile(
              value: 'Chime',
              groupValue: widget.ringtone,
              onChanged: (String? value) {
                FlutterRingtonePlayer.play(
                    fromAsset: "assets/Ringtones/Chime.mp3",
                    looping: false,
                    asAlarm: true);
                setState(() {
                  widget.ringtone = value!;
                  setRingtone('Chime');
                });
              },
              title: const Text('Chime')),
          RadioListTile(
              value: 'Clock',
              groupValue: widget.ringtone,
              onChanged: (String? value) {
                FlutterRingtonePlayer.play(
                    fromAsset: "assets/Ringtones/Clock.mp3",
                    looping: false,
                    asAlarm: true);
                setState(() {
                  widget.ringtone = value!;
                  setRingtone('Clock');
                });
              },
              title: const Text('Clock')),
        ]));
    return rigtonesDialog;
  }
}
