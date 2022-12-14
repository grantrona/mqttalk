import 'package:find_my_device/models/Mqtt_state.dart';
import 'package:find_my_device/routes.dart';
import 'package:find_my_device/shared/load_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => AppState()),
    ], child: const App()
  ));
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

final navigatorKey = GlobalKey<NavigatorState>();

class _AppState extends State<App> {
  final Future<FirebaseApp> _initializeApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    // Wait until initailisation and connection to firebase as completed before starting the app
    return FutureBuilder(
      future: _initializeApp,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error occured during initialisation!", textDirection: TextDirection.ltr);
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            routes: appRoutes,
          );
        }
        return const LoadScreen();
      },
    );
  }
}
