import 'package:find_my_device/shared/ask_input_alert.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../controller/auth.dart';
import '../globals.dart' as globals;

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var user = Auth().user;

  @override
  Widget build(BuildContext context) {
    if (user != null) {
      return Scaffold(
        backgroundColor: globals.colorDark,
        body: Center(
          child: Column(
            children: [
              Expanded(
                flex: 10,
                child: Column(
                  children: [
                    const Icon(
                      Icons.person_pin,
                      size: 200,
                      color: globals.colorLight,
                    ),
                    Text(
                      user!.email ?? 'loading...',
                      style: globals.defaultUserHeader,
                    ),
                  ],
                ),
              ),
              Expanded(
                  flex: 11,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                        child: FractionallySizedBox(
                          widthFactor: 0.7,
                          child: ElevatedButton.icon(
                              icon: const Icon(Icons.email),
                              label: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          10, 0, 0, 0),
                                      child: Text(
                                        'Change Email',
                                        style: globals.buttonFontText,
                                      ))),
                              style: globals.profileButton,
                              onPressed: () {
                                Navigator.pushNamed(context, '/manageEmail') .then((_) => setState(() {
                                  user = Auth().user;
                                },));
                              }),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                        child: FractionallySizedBox(
                          widthFactor: 0.7,
                          child: ElevatedButton.icon(
                              icon: const Icon(Icons.lock_person),
                              label: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          10, 0, 0, 0),
                                      child: Text(
                                        'Reset Password',
                                        style: globals.buttonFontText,
                                      ))),
                              style: globals.profileButton,
                              onPressed: () async {
                                // _confirmPassword(context);
                                Navigator.pushNamed(context, '/managePassword');
                              }),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                        child: FractionallySizedBox(
                          widthFactor: 0.7,
                          child: ElevatedButton.icon(
                              icon: const Icon(Icons.exit_to_app),
                              label: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          10, 0, 0, 0),
                                      child: Text(
                                        'Sign Out',
                                        style: globals.buttonFontText,
                                      ))),
                              style: globals.profileButtonSignOut,
                              onPressed: () async {
                                bool? confirmed = await AskConfirmDialog.showInputDialog(context);
                                if (confirmed != null && confirmed) {
                                  _doSignOut();
                                }
                              }),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text("Error! No user signed in!"),
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

  void _doSignOut() {
    Auth().signOut();
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
