import 'package:flutter/material.dart';

// Alert prompt to notify user of events
showAlertDialog(BuildContext context, String alertText) {
  // set up buttons
  Widget dismissButton = TextButton(
    child: const Text("OK"),
    onPressed:  () {
      Navigator.of(context).pop();
    },
  );
  // set up AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Alert"),
    content: Text(alertText),
    actions: [
      dismissButton,
    ],
  );
  // show dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}