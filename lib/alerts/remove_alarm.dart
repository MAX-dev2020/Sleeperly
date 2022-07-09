import 'package:flutter/material.dart';

showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: const Text(
      "Cancel",
      style: TextStyle(
        fontFamily: 'Montserrat',
        color: Color.fromARGB(255, 0, 0, 0),
        fontWeight: FontWeight.w600,
      ),
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget deleteButton = TextButton(
    child: const Text(
      "Delete",
      style: TextStyle(
        fontFamily: 'Montserrat',
        color: Color.fromARGB(255, 0, 0, 0),
        fontWeight: FontWeight.w500,
      ),
    ),
    onPressed: () {},
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    backgroundColor: Color.fromARGB(255, 255, 255, 255),
    title: const Text(
      "Delete Alarm",
      style: TextStyle(
        fontFamily: 'Montserrat',
        color: Color.fromARGB(255, 0, 0, 0),
        fontWeight: FontWeight.w500,
      ),
    ),
    content: const Text(
      "Do you want to delete the alarm?",
      style: TextStyle(
        fontFamily: 'Montserrat',
        color: Color.fromARGB(255, 0, 0, 0),
        fontWeight: FontWeight.w500,
      ),
    ),
    actions: [
      cancelButton,
      deleteButton,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
