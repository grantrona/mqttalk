import 'package:find_my_device/view/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final Future<FirebaseApp> _initializeApp = Firebase.initializeApp();

  // escapes the 'No MediaQuery widget found' error
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeApp,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error occured during initialisation!");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return const MaterialApp(
            home: Login()     
          ); 
        }
        // indicate loading while app is initialising
        return const Text('Loading');
      },
    );
  }
}