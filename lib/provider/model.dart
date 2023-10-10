import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:mqtt_client/mqtt_client.dart';

class Model extends ChangeNotifier {
  late bool estadoConeccion;
  late String estadoLed;

  Model() {}

  void conectar() async {
    final client =
        MqttServerClient.withPort('ws://34.125.227.33/mqtt', 'fluter', 8083);

    // Establece las credenciales si es necesario
    client.useWebSocket = true;

    try {
      await client.connect();
      print("conectado");

      // Suscribirse a un tema
      String subscriptionTopic = 'esp32/test';
      client.subscribe(subscriptionTopic, MqttQos.atLeastOnce);

      // Escuchar mensajes
      client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
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
