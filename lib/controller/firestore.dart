import 'package:find_my_device/models/Mqtt_state.dart';
import 'package:find_my_device/models/message.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:rxdart/rxdart.dart";

class Firestore {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  // Get the history from firebase for a particular topic
  void getHistoryFromFirebase(AppState state, String topic) {
    List<Message> newHistory = [];
    state.setHistoryText(newHistory);
  }

  // Future<List<Message>> getTopicHistory(String topic) async {
  //   var ref = _db.collection('topics').doc(topic);
  //   var snapshot = await ref.get();
  //   var data = snapshot.data();
    

  //   return data;
  // }

  Future<void> updateTopicHistory(String topic, Message message) {
    final ref = _db.collection('topics').doc(topic);
    return ref.update({'messages' : FieldValue.arrayUnion([message.toJson()])});
  }
}
