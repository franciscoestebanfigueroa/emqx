import 'package:emqx/model/model.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:mqtt_client/mqtt_client.dart';

enum conexion { on, off }

class Model extends ChangeNotifier {
  String _temperatura = "0";
  String _humedad = "0";

  conexion estadoConexion = conexion.off;
  late String estadoLed;
  late Esp32 esp32;

  set temperatura(String data) {
    _temperatura = data;
    print(" payload temp $data");
    notifyListeners();
  }

  set humedad(String data) {
    _humedad = data;
    print(" payload hum $data");
    notifyListeners();
  }

  String get temperatura => _temperatura;
  String get humedad => _humedad;

  Model() {
    init();
  }

  void init() async {
    temperatura = "100";
    await Future.delayed(const Duration(seconds: 2));
    temperatura = "0";
    humedad = "100";
    await Future.delayed(const Duration(seconds: 2));
    humedad = "0";

    conectar();
  }

  Future<MqttServerClient> conectar() async {
    MqttServerClient client =
        MqttServerClient.withPort('34.125.227.33', 'flutter_client', 1883);
    client.logging(on: true);
    client.onConnected = () {
      print("Conectado......");
      client.subscribe("esp32/test", MqttQos.atLeastOnce);
      estadoConexion = conexion.on;
      notifyListeners();
    };
    client.onDisconnected = () {
      print("Desconectado........................................");
      estadoConexion = conexion.off;
      notifyListeners();
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
      esp32 = esp32FromMap(payload.trim());

      _temperatura = esp32.temperatura;
      _humedad = esp32.humedad;
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
