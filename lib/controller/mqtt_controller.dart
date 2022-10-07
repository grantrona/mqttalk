import 'package:find_my_device/controller/firestore.dart';
import 'package:find_my_device/models/Mqtt_state.dart';
import 'package:find_my_device/models/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

/// Controls the connection to a MQTT broker and updates state of the app based on incoming
/// messages from subscribed topics and retrieval of message histories from firestore
class MqttController {
  final AppState _appState;
  MqttClient? _client;
  final String _id;
  final String _host;
  final String _topic;

  MqttController({
    required AppState state,
    required String id,
    required String topic,
  })  : _id = id,
        _host =  "test.mosquitto.org",
        _topic = topic,
        _appState = state;

  // Initialise the MQTT client with the default port (1883)
  void initialiseClient() {
    _client = MqttServerClient(_host, _id);
    _client!.keepAlivePeriod = 20;

    _client!.onDisconnected = onDisconnected;
    _client!.onConnected = onConnected;
    _client!.onSubscribed = onSubscribed;

    final MqttConnectMessage connectionMessage = MqttConnectMessage()
        .withClientIdentifier(_id)
        .withWillTopic("willtopic")
        .withWillMessage("Unexpected loss of connection")
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    _client!.connectionMessage = connectionMessage;

      /// Set the correct MQTT protocol for mosquito.org
    _client!.setProtocolV311();
  }

  // Connect to the MQTT broker
  void connect() async {
    assert(_client != null);
    try {
      _appState.setAppConnectionState(AppConnectionState.connecting);
      await _client!.connect();
    } on Exception catch (e) {
      print('Client exception - $e');
      disconnect();
    }
  }

  // Disconnect from a MQTT broker
  void disconnect() {
    _client!.disconnect();
  }

  // Publish a message on a particualr topic to the MQTT broker. 
  // Updates the message history in firestore with published message
  void publish(String message) {
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(message);
    _client!.publishMessage(_topic, MqttQos.exactlyOnce, builder.payload!);

    List<String> splitMessage = message.split(":");
    // Create new message object
    Message newMessage = Message(message: splitMessage.elementAt(1), sender: splitMessage.elementAt(0));
    String currentTopic = _topic.split("/").elementAt(3).toLowerCase();
    
    // Update firestore with new message
    Firestore().updateTopicHistory(currentTopic, newMessage);
  }

  // Update app state when disconnected
  void onDisconnected() {
    _appState.setAppConnectionState(AppConnectionState.disconnected);
  }

  void onSubscribed(String topic) {
    print("${_client!.clientIdentifier} has subscribed to $topic");
  }

  // When connected to a MQTT broker and subscribed to a topic, listen for new messages for that topic
  void onConnected() {
    _appState.setAppConnectionState(AppConnectionState.connected);
    _client!.subscribe(_topic, MqttQos.atLeastOnce);
    _client!.updates!.listen((messages) { 
      final MqttPublishMessage recieved = messages[0].payload as MqttPublishMessage;
      final String finalMessage = MqttPublishPayload.bytesToStringAsString(recieved.payload.message);
      final messageAndSender = finalMessage.split(":");
      _appState.setRecText(messageAndSender.elementAt(1), messageAndSender.elementAt(0));
    });
  }

  void retrieveTopicHistory(BuildContext context) async {
    _appState.setHistoryText([]);
     String currentTopic = _topic.split("/").elementAt(3).toLowerCase();
    _appState.setHistoryText(await Firestore().getTopicHistory(currentTopic, context));
  }
}
