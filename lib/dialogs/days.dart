import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DaysDialog extends StatefulWidget {
  final int index;
  final List<Map> mapdays;
  const DaysDialog({Key? key, required this.index, required this.mapdays})
      : super(key: key);

  @override
  State<DaysDialog> createState() => _DaysDialogState();
}

class _DaysDialogState extends State<DaysDialog> {
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  _setIndex(List<Map> mapdays) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> convdaysString = [];
    for (var element in mapdays) {
      convdaysString.add(json.encode(element));
    }

    prefs.setStringList('days', convdaysString);
  }

  bool isChecked(int index, String day) {
    return widget.mapdays[widget.index][day];
  }

  @override
  Widget build(BuildContext context) {
    AlertDialog daysDialog = AlertDialog(
        title: const Text(
          'Days',
          style: TextStyle(),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CheckboxListTile(
                title: const Text('Never'),
                value: isChecked(widget.index, 'Never'),
                onChanged: (value) {
                  setState(() {
                    widget.mapdays[widget.index]['Never'] = value;
                    widget.mapdays[widget.index]['EveryDay'] = false;
                    widget.mapdays[widget.index]['Sunday'] = false;
                    widget.mapdays[widget.index]['Monday'] = false;
                    widget.mapdays[widget.index]['Tuesday'] = false;
                    widget.mapdays[widget.index]['Wednesday'] = false;
                    widget.mapdays[widget.index]['Thursday'] = false;
                    widget.mapdays[widget.index]['Friday'] = false;
                    widget.mapdays[widget.index]['Saturday'] = false;
                    _setIndex(widget.mapdays);
                  });
                }),
            CheckboxListTile(
                title: const Text('EveryDay'),
                value: isChecked(widget.index, 'EveryDay'),
                onChanged: (value) {
                  setState(() {
                    widget.mapdays[widget.index]['EveryDay'] = value;
                    widget.mapdays[widget.index]['Sunday'] = value;
                    widget.mapdays[widget.index]['Monday'] = value;
                    widget.mapdays[widget.index]['Tuesday'] = value;
                    widget.mapdays[widget.index]['Wednesday'] = value;
                    widget.mapdays[widget.index]['Thursday'] = value;
                    widget.mapdays[widget.index]['Friday'] = value;
                    widget.mapdays[widget.index]['Saturday'] = value;
                    widget.mapdays[widget.index]['Never'] = false;
                    _setIndex(widget.mapdays);
                  });
                }),
            CheckboxListTile(
                title: const Text('Every Sunday'),
                value: isChecked(widget.index, 'Sunday'),
                onChanged: (value) {
                  setState(() {
                    widget.mapdays[widget.index]['Sunday'] = value;
                    widget.mapdays[widget.index]['EveryDay'] = false;
                    widget.mapdays[widget.index]['Never'] = false;
                    _setIndex(widget.mapdays);
                  });
                }),
            CheckboxListTile(
              title: const Text('Every Monday'),
              value: isChecked(widget.index, 'Monday'),
              onChanged: (value) {
                setState(() {
                  widget.mapdays[widget.index]['Monday'] = value;
                  widget.mapdays[widget.index]['EveryDay'] = false;
                  widget.mapdays[widget.index]['Never'] = false;
                  _setIndex(widget.mapdays);
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Every Tuesday'),
              value: isChecked(widget.index, 'Tuesday'),
              onChanged: (value) {
                setState(() {
                  widget.mapdays[widget.index]['Tuesday'] = value;
                  widget.mapdays[widget.index]['EveryDay'] = false;
                  widget.mapdays[widget.index]['Never'] = false;
                  _setIndex(widget.mapdays);
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Every Wednesday'),
              value: isChecked(widget.index, 'Wednesday'),
              onChanged: (value) {
                setState(() {
                  widget.mapdays[widget.index]['Wednesday'] = value;
                  widget.mapdays[widget.index]['EveryDay'] = false;
                  widget.mapdays[widget.index]['Never'] = false;
                  _setIndex(widget.mapdays);
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Every Thursday'),
              value: isChecked(widget.index, 'Thursday'),
              onChanged: (value) {
                setState(() {
                  widget.mapdays[widget.index]['Thursday'] = value;
                  widget.mapdays[widget.index]['EveryDay'] = false;
                  widget.mapdays[widget.index]['Never'] = false;
                  _setIndex(widget.mapdays);
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Every Friday'),
              value: isChecked(widget.index, 'Friday'),
              onChanged: (value) {
                setState(() {
                  widget.mapdays[widget.index]['Friday'] = value;
                  widget.mapdays[widget.index]['EveryDay'] = false;
                  widget.mapdays[widget.index]['Never'] = false;
                  _setIndex(widget.mapdays);
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Every Saturday'),
              value: isChecked(widget.index, 'Saturday'),
              onChanged: (value) {
                setState(() {
                  widget.mapdays[widget.index]['Saturday'] = value;
                  widget.mapdays[widget.index]['EveryDay'] = false;
                  widget.mapdays[widget.index]['Never'] = false;
                  _setIndex(widget.mapdays);
                });
              },
            ),
          ],
        ));
    return daysDialog;
  }
}
