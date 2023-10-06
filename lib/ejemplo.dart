import 'package:mqtt_client/mqtt_client.dart';

import 'dart:typed_data' as typed;



import 'package:mqtt_client/mqtt_server_client.dart';

void ejemploconectar() async {
  final client = MqttServerClient.withPort('ws://34.125.227.33/mqtt', 'fluter', 8083);

  // Establece las credenciales si es necesario
  client.useWebSocket = true;

  try {
    print("conectado");
    await client.connect();

    // Suscribirse a un tema
    final subscriptionTopic = 'mitopico';
    client.subscribe(subscriptionTopic, MqttQos.atLeastOnce);

    // Escuchar mensajes
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage message = c[0].payload as MqttPublishMessage;
      final payload = MqttPublishPayload.bytesToStringAsString(
          message.payload.message);

      print('Recibido mensaje en el tema $subscriptionTopic: $payload');
    });

    // Publicar un mensaje
    final topic = 'mitopico';
    final builder = MqttClientPayloadBuilder();
    builder.addString('Hola desde Flutter');
    client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);

    // Desconectar
    //await client.disconnect();
  } catch (e) {
    print('Error al conectar o publicar: $e');
  }
}
