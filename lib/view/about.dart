import 'package:flutter/material.dart';

import '../globals.dart' as globals;

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, //prevents resizing of widgets from keyboard popup
      backgroundColor: globals.colorDark,
      appBar: AppBar(
        backgroundColor: globals.colorHighlight,
        title: const Text("About"),
        centerTitle: true,
        titleTextStyle: globals.defaultFontHeader,
      ),
    );
  }
}