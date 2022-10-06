import 'package:find_my_device/controller/auth.dart';
import 'package:find_my_device/models/Mqtt_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

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

  void initialiseClient() {
    _client = MqttServerClient(_host, _id);

    // _client!.port = 8883;
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

      /// Set the correct MQTT protocol for mosquito
    _client!.setProtocolV311();

    print("Client Connecting...");
  }

  // Connect to the host
  // ignore: avoid_void_async
  void connect() async {
    assert(_client != null);
    try {
      print('Mosquitto start client connecting....');
      _appState.setAppConnectionState(AppConnectionState.connecting);
      await _client!.connect();
    } on Exception catch (e) {
      print('Client exception - $e');
      disconnect();
    }
  }

  void disconnect() {
    print('Disconnected');
    _client!.disconnect();
  }

  void publish(String message) {
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(message);
    _client!.publishMessage(_topic, MqttQos.exactlyOnce, builder.payload!);
  }

  void onDisconnected() {
    print(_client!.connectionStatus!.returnCode.toString());
    _appState.setAppConnectionState(AppConnectionState.disconnected);
  }

  void onSubscribed(String topic) {
    print(_client!.clientIdentifier + " has subscribed to " + topic);
  }

  void onConnected() {
    print(_client!.connectionStatus!.returnCode.toString());
    _appState.setAppConnectionState(AppConnectionState.connected);
    _client!.subscribe(_topic, MqttQos.atLeastOnce);
    _client!.updates!.listen((messages) { 
      final MqttPublishMessage recieved = messages[0].payload as MqttPublishMessage;
      final String finalMessage = MqttPublishPayload.bytesToStringAsString(recieved.payload.message);
      final messageAndSender = finalMessage.split(":");
      _appState.setRecText(messageAndSender.elementAt(1), messageAndSender.elementAt(0));
      // if (sender == Auth().user!.email) {
      //   _appState.setRecText(finalMessage, false);
      // } else {
      //   _appState.setRecText(finalMessage, true);
      // }
    });
  }
}
