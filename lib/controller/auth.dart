import 'package:find_my_device/controller/firestore.dart';
import 'package:find_my_device/models/message.dart';
import 'package:find_my_device/models/Mqtt_state.dart';
import 'package:find_my_device/shared/alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class Auth {
  final firebaseInstance = FirebaseAuth.instance;
  final userStream = FirebaseAuth.instance.authStateChanges();
  final user = FirebaseAuth.instance.currentUser;

  // Sign in an existing user using provided credentials
  Future<void> signIn(
      String email, String password, BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showAlertDialog(context, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showAlertDialog(context, 'Wrong password provided for that user.');
      }
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  // Sign a user out
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  // Register a new user using provided credentials
  Future<void> register(
      String email, String password, BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showAlertDialog(context, "The password provided is too weak!")
            .showDialog();
      } else if (e.code == 'email-already-in-use') {
        showAlertDialog(context, "Email is already being used!").showDialog();
      }
    } catch (e) {
      print(e);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  // Validate a password by using reauthentication
  Future<bool> validatePassword(String password) async {
    AuthCredential credential = EmailAuthProvider.credential(
        email: user!.email ?? "null", password: password);
    try {
      final credentialCheck = await FirebaseAuth.instance.currentUser!
          .reauthenticateWithCredential(credential);
      return credentialCheck.user != null;
    } on FirebaseAuthException catch (e) {
      print(e);
      return false;
    }
  }

  // Update a users password (only works after recent validation of user)
  Future<void> updateUserPassword(String password) {
    return user!.updatePassword(password);
  }
}
