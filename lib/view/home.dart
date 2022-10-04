import 'package:find_my_device/view_model/auth.dart';
import 'package:find_my_device/shared/load_screen.dart';
import 'package:find_my_device/view/login.dart';
import 'package:find_my_device/view/messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: Auth().userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadScreen();
        } else if (snapshot.hasError) {
          return const Center(
              child: Text("Error Occured", textDirection: TextDirection.ltr));
        } else if (snapshot.hasData) {
          return const Messages();
        } else {
          return const Login();
        }
      },
    );
  }
}
