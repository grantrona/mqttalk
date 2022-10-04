import 'package:find_my_device/models/Mqtt_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:mqtt_client/mqtt_client.dart';

class MqttController {
  AppState _appState;
  MqttClient? _client;
  String _id;
  String _host;
  String _topic;

  MqttController({
    required AppState state,
    required String id,
    required String host,
    required String topic,
  })  : _id = id,
        _host = host,
        _topic = topic,
        _appState = state;

  void initialiseClient() {
    _client = MqttClient(_host, _id);

    _client!.port = 8883;
    _client!.keepAlivePeriod = 60;

    _client!.onDisconnected = onDisconnect;
    _client!.onConnected = onConnect;
    _client!.onSubscribed = onSubscribe;

    final MqttConnectMessage connectionMessage = MqttConnectMessage()
        .withClientIdentifier(_id)
        .withWillTopic("willtopic")
        .withWillMessage("Unexpected loss of connection")
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    _client!.connectionMessage = connectionMessage;

    print("Client Connecting...");
  }

  // Connect to the host
  // ignore: avoid_void_async
  void connect() async {
    assert(_client != null);
    try {
      print('EXAMPLE::Mosquitto start client connecting....');
      _appState.setAppConnectionState(AppConnectionState.connecting);
      await _client!.connect();
    } on Exception catch (e) {
      print('EXAMPLE::client exception - $e');
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

  void onDisconnect() {
    print(_client!.connectionStatus!.returnCode.toString());
    _appState.setAppConnectionState(AppConnectionState.disconnected);
  }

  void onSubscribe(String topic) {
    print(_client!.clientIdentifier + " has subscribed to " + topic);
  }

  void onConnect() {
    print(_client!.connectionStatus!.returnCode.toString());
    _appState.setAppConnectionState(AppConnectionState.connected);
    _client!.subscribe(_topic, MqttQos.atLeastOnce);
    _client!.updates!.listen((messages) { 
      final MqttPublishMessage recieved = messages[0].payload as MqttPublishMessage;
      final String finalMessage = MqttPublishPayload.bytesToStringAsString(recieved.payload.message);
      _appState.setRecText(finalMessage);
    });
  }
}
