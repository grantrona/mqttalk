import 'package:flutter/cupertino.dart';

enum AppConnectionState { connected, disconnected, connecting }

class AppState with ChangeNotifier {
  AppConnectionState _connectionState = AppConnectionState.disconnected;
  String _recText = "";
  String _history = "";

  void setRecText(String text) {
    _recText = text;
    _history += "\n""$_recText";
    notifyListeners();
    
  }

  void setAppConnectionState(AppConnectionState state) {
    _connectionState = state;
    notifyListeners();
  }

  String getRecText() {
    return _recText;
  }

  String getHistoryText() {
    return _history;
  }

  AppConnectionState getState() {
    return _connectionState;
  }
}