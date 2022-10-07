/// Model for all messages, stores the message text and the sender of the text
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

  // Convert to json
  Map<String, dynamic> toJson() => {
    'sender' : _sender,
    'text' : _message,
  };

  // Convert from json to a Message object
  static Message fromJson(Map<String, dynamic> inJson) => Message(
    message: inJson['text'],
    sender: inJson['sender'],
    );
}
