import 'package:find_my_device/services/auth.dart';
import 'package:find_my_device/view/login.dart';
import 'package:find_my_device/view/search.dart';
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
          return const Center(
              child: Text("Loading", textDirection: TextDirection.ltr));
        } else if (snapshot.hasError) {
          return const Center(
              child: Text("Error Occured", textDirection: TextDirection.ltr));
        } else if (snapshot.hasData) {
          return const SearchScreen();
        } else {
          return const Login();
        }
      },
    );
  }
}
