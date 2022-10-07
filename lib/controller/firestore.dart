import 'package:find_my_device/main.dart';
import 'package:find_my_device/models/message.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Controller for firestore, which stores message log history
class Firestore {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Retrieve the log history from firebase, then parse each JSON object to Message objects
  Future<List<Message>> getTopicHistory(String topic, BuildContext context) async {  
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));

    final ref = _db.collection('topics').doc(topic);
    final snapshot = await ref.get();
    // document does not exist, return
    if (!snapshot.exists) {
      return [];
    }
    final data = snapshot.get('messages');

    // Data for a topic is empty (no one has messaged on that topic yet)
    if(data.toString() == "[]"){
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
      return [];
    }

    // Parse and return message history for a topic
    List<Message> topicHistory = [];
    data.forEach((e) {
      Message next = Message.fromJson(e);
      topicHistory.add(next);
    });

    navigatorKey.currentState!.popUntil((route) => route.isFirst);

    return topicHistory;
  }

  // Update the topic history as new texts are sent
  Future<void> updateTopicHistory(String topic, Message message) {
    final ref = _db.collection('topics').doc(topic);
    return ref.update({'messages' : FieldValue.arrayUnion([message.toJson()])});
  }
}
