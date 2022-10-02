import 'package:flutter/material.dart';

import '../globals.dart' as globals;

class Preferences extends StatefulWidget {
  const Preferences({super.key});

  @override
  State<Preferences> createState() => _PreferencesState();
}

class _PreferencesState extends State<Preferences> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, //prevents resizing of widgets from keyboard popup
      backgroundColor: globals.colorDark,
      appBar: AppBar(
        backgroundColor: globals.colorHighlight,
        title: const Text("Preferences"),
        centerTitle: true,
        titleTextStyle: globals.defaultFontHeader,
      ),
    );
  }
}