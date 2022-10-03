import 'package:find_my_device/view/login.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../services/auth.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text("PROFILE"),
            ElevatedButton(
                child: const Text('Sign Out'),
                onPressed: () async {
                  Auth().signOut();
                  navigatorKey.currentState!.popUntil((route) => route.isFirst);
                }),
          ],
        ),
      ),
    );
  }
}
