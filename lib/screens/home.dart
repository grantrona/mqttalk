import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../globals.dart' as globals;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset:
            false, //prevents resizing of widgets from keyboard popup
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blue.shade800,
          title: const Text("Home"),
          centerTitle: true,
          titleTextStyle: globals.defaultFontHeader,
        ),

        body: Container(
          
        ));
  }
}
