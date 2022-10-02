import 'package:flutter/material.dart';

showAlertDialog(BuildContext context, String alertText) {

  // set up the buttons
  Widget dismissButton = TextButton(
    child: const Text("OK"),
    onPressed:  () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Alert"),
    content: Text(alertText),
    actions: [
      dismissButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}