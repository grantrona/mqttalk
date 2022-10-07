import 'package:find_my_device/models/message.dart';
import 'package:flutter/cupertino.dart';

// The connection states (to a MQTT broker) the app can be in
enum AppConnectionState { connected, disconnected, connecting }

/// Model for information for the current state of the app. Stores connection
/// status to an MQTT borker and message history for a subscribed topic which the view will display. 
/// Updates view using Provider
class AppState with ChangeNotifier {
  AppConnectionState _connectionState = AppConnectionState.disconnected;
  String _recText = "";
  List<Message> _history = [];

  void setRecText(String text, String sender) {
    _recText = text;
    _history.add(Message(message: _recText, sender: sender));
    notifyListeners();
  }

  void setAppConnectionState(AppConnectionState state) {
    _connectionState = state;
    notifyListeners();
  }

  String getRecText() {
    return _recText;
  }

  List<Message> getHistoryText() {
    return _history;
  }

  AppConnectionState getState() {
    return _connectionState;
  }

  void setHistoryText(List<Message> history) {
    _history = history;
  }
}
