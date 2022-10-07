import 'dart:convert';
import 'dart:math';
import 'package:find_my_device/main.dart';
import 'package:find_my_device/models/message.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Firestore {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Message>> getTopicHistory(String topic, BuildContext context) async {  
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));

    final ref = _db.collection('topics').doc(topic);
    final snapshot = await ref.get();
    if (!snapshot.exists) {
      return [];
    }
    final data = snapshot.get('messages');

    if(data.toString() == "[]"){
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
      return [];
    }

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
