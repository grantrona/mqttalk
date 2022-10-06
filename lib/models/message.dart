class Message {
  final String _message;
  final String _sender;

  Message({
    required String message,
    required String sender,
  })  : _message = message,
        _sender = sender;

  String getMessage() {
    return _message;
  }

  String getSender() {
    return _sender;
  }
}
