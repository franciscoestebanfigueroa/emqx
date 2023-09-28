

import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class Model extends ChangeNotifier {
  final client = MqttServerClient('ws://35.219.178.129:8083/mqtt', 'pancho');
  //final client = MqttServerClient('test.mosquitto.org', '');


 conectar() {
  print("funcion conectar");
   client.setProtocolV311();
  client.websocketProtocols=["mqtt"] ;   
  client.connect();
  print("estado de conexion ${client.connectionStatus}");
    
  }

void connectToEMQX() async {
  final client = MqttServerClient('ws://your_emqx_server_ip:your_emqx_server_port', '');
  client.logging(on: true);

  // Establece las credenciales (nombre de usuario y contraseña) si es necesario
  client.onBadCertificate = (dynamic cert) => true;
  client.setProtocolV311();

  // Conecta al servidor MQTT
  try {
    await client.connect('your_client_id', 'your_username', 'your_password');
  } catch (e) {
    print('Error de conexión: $e');
  }

  if (client.connectionStatus == MqttConnectionState.connected) {
    print('Conectado al servidor EMQ X');

    // Suscríbete a un tema MQTT
    client.subscribe('your_topic', MqttQos.atMostOnce);

    // Escucha los mensajes entrantes
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> event) {
      final MqttPublishMessage recMess = event[0].payload;
      final String message =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      print('Mensaje recibido en el tema ${recMess.variableHeader.topicName}: $message');
    });
  }
}


  enviar() {  
  }

  cerrar() {
    client.disconnect();
  }
}
