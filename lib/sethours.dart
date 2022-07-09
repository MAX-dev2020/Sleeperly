import 'dart:ui';

import 'package:sleeperly/Themes/dialogtheme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetHours extends StatefulWidget {
  int hours;
  SetHours({Key? key, required this.hours}) : super(key: key);

  @override
  State<SetHours> createState() => _SetHoursState();
}

class _SetHoursState extends State<SetHours> {
  int setHours = 0;
  _loadgetHours() async {
    final prefs = await SharedPreferences.getInstance();
    widget.hours = prefs.getInt('sethours') ?? 6;
    print(setHours);
  }

  _loadsetHours(int setHours) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('sethours', setHours);
  }

  List<bool> _isOpen = [false, false, false, false, false, false, false, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 5,
        title: const Text('Set Time',
            style: TextStyle(
                color: Colors.white, fontFamily: 'Montserrat', fontSize: 20)),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder(
        future: _loadgetHours(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ExpansionPanelList(
                    animationDuration: Duration(milliseconds: 600),
                    children: [
                      ExpansionPanel(
                        backgroundColor: Colors.black,
                        body: RichText(
                            text: const TextSpan(
                          children: [
                            TextSpan(
                                text: "Suggested\n",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13)),
                            TextSpan(
                                text:
                                    "Go to bed at, \n08:00 PM (7.5 hrs of sleep, 5 sleep cycles) \n09:30 PM (6 hrs of sleep, 4 sleep cycles)",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Montserrat',
                                    fontSize: 13)),
                          ],
                        )),
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return RadioListTile(
                            activeColor: Colors.white,
                            title: const Text(
                              '3:30 - 4:00 AM',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'Montserrat'),
                            ),
                            value: 1,
                            groupValue: widget.hours,
                            onChanged: (int? value) {
                              setState(() {
                                widget.hours = value!;
                                _loadsetHours(widget.hours);
                              });
                            },
                          );
                        },
                        isExpanded: _isOpen[0],
                      ),
                      ExpansionPanel(
                        backgroundColor: Colors.black,
                        body: RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                  text: "Suggested\n",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13)),
                              TextSpan(
                                  text:
                                      "Go to bed at, \n08:30 PM  (7.5 hrs of sleep, 5 sleep cycles) \n10:00 PM (6 hrs of sleep, 4 sleep cycles)",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Montserrat',
                                      fontSize: 13)),
                            ],
                          ),
                        ),
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return RadioListTile(
                            activeColor: Colors.white,
                            title: const Text(
                              '4:00 - 4:30 AM',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'Montserrat'),
                            ),
                            value: 2,
                            groupValue: widget.hours,
                            onChanged: (int? value) {
                              setState(() {
                                widget.hours = value!;
                                _loadsetHours(widget.hours);
                              });
                            },
                          );
                        },
                        isExpanded: _isOpen[1],
                      ),
                      ExpansionPanel(
                          backgroundColor: Colors.black,
                          body: RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                    text: "Suggested\n",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13)),
                                TextSpan(
                                    text:
                                        "Go to bed at, \n9:00 PM (7.5 hrs of sleep, 5 sleep cycles) \n10:30 PM (6 hrs of sleep, 4 sleep cycles)",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Montserrat',
                                        fontSize: 13)),
                              ],
                            ),
                          ),
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return RadioListTile(
                              activeColor: Colors.white,
                              title: const Text(
                                '4:30 - 5:00 AM',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'Montserrat'),
                              ),
                              value: 3,
                              groupValue: widget.hours,
                              onChanged: (int? value) {
                                setState(() {
                                  widget.hours = value!;
                                  _loadsetHours(widget.hours);
                                });
                              },
                            );
                          },
                          isExpanded: _isOpen[2]),
                      ExpansionPanel(
                          backgroundColor: Colors.black,
                          body: RichText(
                              text: const TextSpan(
                            children: [
                              TextSpan(
                                  text: "Suggested\n",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13)),
                              TextSpan(
                                  text:
                                      "Go to bed at, \n9:30 PM (7.5 hrs of sleep, 5 sleep cycles) \n11:00 PM (6 hrs of sleep, 4 sleep cycles)",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Montserrat',
                                      fontSize: 13)),
                            ],
                          )),
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return RadioListTile(
                              activeColor: Colors.white,
                              title: const Text(
                                '5:00 - 5:30 AM',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'Montserrat'),
                              ),
                              value: 4,
                              groupValue: widget.hours,
                              onChanged: (int? value) {
                                setState(() {
                                  widget.hours = value!;
                                  _loadsetHours(widget.hours);
                                });
                              },
                            );
                          },
                          isExpanded: _isOpen[3]),
                      ExpansionPanel(
                          backgroundColor: Colors.black,
                          body: RichText(
                              text: const TextSpan(
                            children: [
                              TextSpan(
                                  text: "Suggested\n",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13)),
                              TextSpan(
                                  text:
                                      "Go to bed at, \n10:00 PM (7.5 hrs of sleep, 5 sleep cycles) \n11:30 PM (6 hrs of sleep, 4 sleep cycles)",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Montserrat',
                                      fontSize: 13)),
                            ],
                          )),
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return RadioListTile(
                              activeColor: Colors.white,
                              title: const Text(
                                '5:30 - 6:00 AM',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'Montserrat'),
                              ),
                              value: 5,
                              groupValue: widget.hours,
                              onChanged: (int? value) {
                                setState(() {
                                  widget.hours = value!;
                                  _loadsetHours(widget.hours);
                                });
                              },
                            );
                          },
                          isExpanded: _isOpen[4]),
                      ExpansionPanel(
                          backgroundColor: Colors.black,
                          body: RichText(
                              text: const TextSpan(
                            children: [
                              TextSpan(
                                  text: "Suggested\n",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13)),
                              TextSpan(
                                  text:
                                      "Go to bed at, \n10:30 PM (7.5 hrs of sleep, 5 sleep cycles) \n12:00 PM (6 hrs of sleep, 4 sleep cycles)",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Montserrat',
                                      fontSize: 13)),
                            ],
                          )),
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return RadioListTile(
                              activeColor: Colors.white,
                              title: const Text(
                                '6:00 - 6:30 AM',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'Montserrat'),
                              ),
                              value: 6,
                              groupValue: widget.hours,
                              onChanged: (int? value) {
                                setState(() {
                                  widget.hours = value!;
                                  _loadsetHours(widget.hours);
                                });
                              },
                            );
                          },
                          isExpanded: _isOpen[5]),
                      ExpansionPanel(
                          backgroundColor: Colors.black,
                          body: RichText(
                              text: const TextSpan(
                            children: [
                              TextSpan(
                                  text: "Suggested\n",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13)),
                              TextSpan(
                                  text:
                                      "Go to bed at, \n11:00 PM (7.5 hrs of sleep, 5 sleep cycles) \n12:30 PM (6 hrs of sleep, 4 sleep cycles)",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Montserrat',
                                      fontSize: 13)),
                            ],
                          )),
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return RadioListTile(
                              activeColor: Colors.white,
                              title: const Text(
                                '6:30 - 7:00 AM',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'Montserrat'),
                              ),
                              value: 7,
                              groupValue: widget.hours,
                              onChanged: (int? value) {
                                setState(() {
                                  widget.hours = value!;
                                  _loadsetHours(widget.hours);
                                });
                              },
                            );
                          },
                          isExpanded: _isOpen[6]),
                    ],
                    expansionCallback: (i, isOpen) => {
                      setState(
                        () {
                          _isOpen[i] = !isOpen;
                        },
                      )
                    },
                  ),
                  Container(
                      margin:
                          const EdgeInsets.only(top: 30, left: 30, right: 30),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(
                            color: Colors.white,
                            width: 0.2,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: RichText(
                            text: const TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 2.0),
                                    child: Icon(
                                      Icons.tips_and_updates_outlined,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                                TextSpan(
                                    text:
                                        " Your body's circadian rhythm functions on a set loop, aligning itself with sunrise and sunset.Being consistent with your sleep and waking times can aid long-term sleep quality.\n  No matter what you are trying out for your bedtime routine, try to stay as consistent as possible. This means finding a typical time to lay down in bed as well as getting up at the same time every day",
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 13,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
