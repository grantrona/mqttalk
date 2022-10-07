import 'package:flutter/material.dart';
import '../globals.dart' as globals;

class LoadScreen extends StatefulWidget {
  const LoadScreen({super.key});

  @override
  State<LoadScreen> createState() => _LoadScreenState();
}

// Splash screen while the app is initialising/connecting to firebase
class _LoadScreenState extends State<LoadScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: globals.colorDark,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.flutter_dash,
                  color: Colors.white,
                  size: 150,
                ),
                Text("Initializing...",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: globals.headTextSize,
                      fontWeight: FontWeight.bold,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
