



import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class Model extends ChangeNotifier {
  //final client = MqttServerClient('test.mosquitto.org', '');


 conectar() {
  print("funcion conectar");
  
  final client = MqttServerClient('ws://ws://34.125.227.33/mqtt', '');
   client.setProtocolV311();
  client.onBadCertificate = (dynamic cert) => true;
  client.logging(on: true);
  client.port=8083; 
  client.connect("","");
  print("estado de conexion ${client.connectionStatus}");
    
  }

void connectToEMQX() async {
  final client = MqttServerClient('ws://ws://34.125.227.33/mqtt', '');
  client.logging(on: true);
  client.useWebSocket=true;

  // Establece las credenciales (nombre de usuario y contraseña) si es necesario
  client.onBadCertificate = (dynamic cert) => true;
  client.setProtocolV311();

  // Conecta al servidor MQTT
  try {
    await client.connect();
  } catch (e) {
    print('Error de conexión: $e');
  }

  if (client.connectionStatus == MqttConnectionState.connected) {
    print('Conectado al servidor EMQ X');

    // Suscríbete a un tema MQTT
    client.subscribe('your_topic', MqttQos.atMostOnce);

    // Escucha los mensajes entrantes
   /* client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> event) {
      final MqttMessage recMess = event[0].payload;
      final String message =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      print('Mensaje recibido en el tema ${recMess.variableHeader.topicName}: $message');
    });
    */
  }
}


  enviar() {  
  }

  cerrar() {
   // client.disconnect();
  }
}
