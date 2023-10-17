import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:mqtt_client/mqtt_client.dart';

class Model extends ChangeNotifier {
  String _temperatura = "33";
  late bool estadoConeccion;
  late String estadoLed;

  set temperatura(String data) {
    _temperatura = data;
    print(" payload $data");
    notifyListeners();
  }

  String get temperatura => _temperatura;

  Model() {}

  Future<MqttServerClient> conectar() async {
    MqttServerClient client =
        MqttServerClient.withPort('34.125.227.33', 'flutter_client', 1883);
    client.logging(on: true);
    client.onConnected = () {
      print("Conectado......");
      client.subscribe("esp32/test", MqttQos.atLeastOnce);
    };
    client.onDisconnected = () {
      print("Desconectado........................................");
    };
    client.onUnsubscribed = (x) {
      print("3333333333333");
    };
    client.onSubscribed = (x) {
      print("suscripto a topico $x");
    };
    client.onSubscribeFail = (x) {
      print("55555555555555555");
    };
    client.pongCallback = () {
      print("6566666666666666666666");
    };

    final connMessage = MqttConnectMessage()
        .authenticateAs('prueba', 'pancho@esteban')
        .keepAliveFor(60)
        .withWillTopic('esp32/test')
        .withWillMessage('Mensaje desde flutter')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    client.connectionMessage = connMessage;
    try {
      print("conectado");
      await client.connect();
    } catch (e) {
      print('Exception: $e');
      client.disconnect();
    }

    client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      MqttPublishMessage message = c[0].payload as MqttPublishMessage;
      String payload =
          MqttPublishPayload.bytesToStringAsString(message.payload.message);
      _temperatura = payload.trim();
      notifyListeners();
      print('mensaje :${payload.trim()} del topic: ${c[0].topic}>');
    });

    return client;
  }

  void conectar2() async {
    final client =
        MqttServerClient.withPort('ws://34.125.227.33/mqtt', 'fluter', 8083);
    // MqttServerClient.withPort(
    //    'ws://192.168.0.12/mqtt', 'fluter_cliente', 8083);

    // Establece las credenciales si es necesario
    client.useWebSocket = true;
    print("${client.clientIdentifier}");

    try {
      await client.connect();
      print("conectado");

      // Suscribirse a un tema
      String subscriptionTopic = 'esp32/test';
      client.subscribe(subscriptionTopic, MqttQos.atLeastOnce);

      // Escuchar mensajes
      client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
        print(" data $c");
        final MqttPublishMessage message = c[0].payload as MqttPublishMessage;
        final payload =
            MqttPublishPayload.bytesToStringAsString(message.payload.message);

        print('Recibido mensaje en el tema $subscriptionTopic: $payload');
      });

      // Publicar un mensaje
      final topic = 'esp32/test';
      final builder = MqttClientPayloadBuilder();
      builder.addString('Hola desde Flutter');
      final builderVacio = MqttClientPayloadBuilder();
      builderVacio.addString('Sin Data');
      client.publishMessage(
          topic, MqttQos.atLeastOnce, builder.payload ?? builderVacio.payload!);

      // Desconectar
      client.disconnect();
    } catch (e) {
      print('Error al conectar o publicar: $e');
    }
  }
}
