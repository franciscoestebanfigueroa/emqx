import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';


class Model extends  ChangeNotifier {

 String _mensaje="sin data";
 bool _estado_server=false;

final MqttServerClient client=




  MqttServerClient('ws://34.125.97.207:8083/mqtt', 'Pancho');
  final MqttConnectMessage connectMessage = MqttConnectMessage()
    //.withClientIdentifier('cliente_flutter')
    .startClean() // Iniciar una nueva sesión limpia
    .withWillQos(MqttQos.atLeastOnce)
    //.keepAliveFor(60) // Intervalo de tiempo de keep-alive en segundos
    .withWillTopic('server')
    .withWillMessage('Mensaje de voluntad')
    .withWillRetain();
    //.authenticateAs('tu_usuario', 'tu_contraseña'); // Si es necesario autenticación

model(){


client.connectionMessage = connectMessage;
print("init");
}


 bool get estado_server => _estado_server;

mensaje(String data){
  _mensaje=data;
  notifyListeners();
}

conectar (){
  client.connect();
/*
client.subscribe('server', MqttQos.atMostOnce);
client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
  
  final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
  final String message =
      MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

  print('Mensaje recibido en ${c[0].topic}: $message');
});

*/

}



enviar(){
  final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
builder.addString('Hola desde Flutter');
client.publishMessage('tu/topic', MqttQos.atMostOnce, builder.payload!  );

}

cerrar(){
  client.disconnect();

}
}
  
