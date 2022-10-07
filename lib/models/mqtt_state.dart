import 'package:find_my_device/models/message.dart';
import 'package:flutter/cupertino.dart';

enum AppConnectionState { connected, disconnected, connecting }

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