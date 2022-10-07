import 'package:flutter/material.dart';
import '../globals.dart' as globals;

class AskConfirmDialog {
  static Future<bool?> showInputDialog(
      BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Are you sure you want to Sign out?'),
            actions: <Widget>[
              ElevatedButton(
                style: globals.profileButtonSignOut,
                child: const Text("Cancel"),
                onPressed: () => Navigator.pop(context, false),
              ),
              ElevatedButton(
                style: globals.profileButton,
                child: const Text('Yes'),
                onPressed: () => Navigator.pop(context, true),
              ),
            ],
          );
        });
  }
}
