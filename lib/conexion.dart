import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

Future<MqttServerClient> conectar() async {
  MqttServerClient client =
      MqttServerClient.withPort('192.168.0.12', 'flutter_client', 1883);
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
    final MqttPublishMessage message = c[0].payload as MqttPublishMessage;
    final payload =
        MqttPublishPayload.bytesToStringAsString(message.payload.message);

    print('mensaje :$payload del topic: ${c[0].topic}>');
  });

  return client;
}
