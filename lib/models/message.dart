class Message {
  final String _message;
  final bool _incoming;

  Message({
    required String message,
    required bool incoming,
  })  : _message = message,
        _incoming = incoming;

  String getMessage() {
    return _message;
  }

  bool sentExternally() {
    return _incoming;
  }
}
