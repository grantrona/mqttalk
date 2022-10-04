import 'dart:html';

import 'package:flutter/cupertino.dart';

enum AppConnectionState { connected, disconnected, connecting }

class AppState with ChangeNotifier {
  AppConnectionState _connectionState = AppConnectionState.disconnected;
  String _recText = "";
  final List<String>_history = [];

  void setRecText(String text) {
    _recText = text;
    _history.add(_recText);
    notifyListeners();
    
  }

  void setAppConnectionState(AppConnectionState state) {
    _connectionState = state;
    notifyListeners();
  }

  String getRecText() {
    return _recText;
  }

  List<String> getHistoryText() {
    return _history;
  }

  AppConnectionState getState() {
    return _connectionState;
  }
}