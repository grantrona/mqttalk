import 'package:flutter/material.dart';
import '../globals.dart' as globals;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset:
            false, //prevents resizing of widgets from keyboard popup
        backgroundColor: globals.colorDark,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blue.shade800,
          title: const Text("Home"),
          centerTitle: true,
          titleTextStyle: globals.defaultFontHeader,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Image.asset(
                  'assets/images/radar.png',
                  height: 200,
                  width: 200,
                  ),
              ),

            ],
          ),
        ));
  }
}
