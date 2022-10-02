import 'package:find_my_device/routes.dart';
import 'package:find_my_device/services/auth.dart';
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
          return StreamBuilder(
            stream: Auth().userStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: Text("Loading", textDirection: TextDirection.ltr));
              } else if (snapshot.hasError) {
                return const Center(
                    child: Text("Error Occured",
                        textDirection: TextDirection.ltr));
              } else if (snapshot.hasData) {
                return MaterialApp(
                  initialRoute: '/',
                  routes: appRoutes,
                );
              } else {
                return MaterialApp(
                  initialRoute: '/login',
                  routes: appRoutes,
                );
              }
            },
          );
        }
        // TODO indicate loading while app is initialising
        return const Text('Loading');
      },
    );
  }
}
