import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

List<Map> mapdays = [];

loadIndex() async {
  final prefs = await SharedPreferences.getInstance();
  List<String> convdays = prefs.getStringList('days') ?? [];
  for (var element in convdays) {
    mapdays.add(json.decode(element));
  }
}

checked(int index) {
  String days = '';
  loadIndex();
  if (mapdays.isEmpty) {
    return days;
  }
  days += mapdays[index]['EveryDay'] ? '  EveryDay' : '';
  days += mapdays[index]['Sunday'] ? '  Sunday' : '';
  days += mapdays[index]['Monday'] ? '  Monday' : '';
  days += mapdays[index]['Tuesday'] ? '  Tuesday' : '';
  days += mapdays[index]['Wednesday'] ? '  Wednesday' : '';
  days += mapdays[index]['Thursday'] ? '  Thursday' : '';
  days += mapdays[index]['Friday'] ? '  Friday' : '';
  days += mapdays[index]['Saturday'] ? '  Saturday' : '';
  mapdays = [];
  return days;
}
