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

  Map<String, dynamic> toJson() => {
    'sender' : _sender,
    'text' : _message,
  };

  static Message fromJson(Map<String, dynamic> inJson) => Message(
    message: inJson['text'],
    sender: inJson['sender'],
    );
}
