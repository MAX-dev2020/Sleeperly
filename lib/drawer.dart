import 'dart:ui';
import 'package:sleeperly/sethours.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  final TimeOfDay time;
  final int hours;
  const NavDrawer({Key? key, required this.time, required this.hours})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AssetImage img;
    final String textTime = time.toString();
    int hour = int.parse(textTime.substring(10, textTime.length - 4));
    if (hour >= 5 && hour < 12) {
      img = const AssetImage('images/sun.gif');
    } else if (hour >= 12 && hour < 19) {
      img = const AssetImage('images/riv.gif');
    } else {
      img = const AssetImage('images/rivermoon.gif');
    }
    return SizedBox(
        width: 250,
        child: Drawer(
          backgroundColor: hour >= 5 && hour < 19
              ? const Color.fromARGB(58, 0, 0, 0)
              : const Color.fromARGB(59, 86, 86, 86),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 3.0,
              sigmaY: 3.0,
            ),
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: DrawerHeader(
                    child: const Text(""),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: img,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  dense: true,
                  title: const Text(
                    'Set Time',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 20,
                    ),
                  ),
                  textColor: Colors.white,
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SetHours(hours: hours),
                      ),
                    ),
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
