import 'dart:convert';

import 'package:emqx/model/model.dart';
import 'package:emqx/model/model_promedio.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:mqtt_client/mqtt_client.dart';

enum conexion { on, off }

class Model extends ChangeNotifier {
  String _temperatura = "0";
  String _humedad = "0";
  String _termica = "0";
  String _hora = "";
  bool _ping = false;
  late MqttServerClient client;

  conexion estadoConexion = conexion.off;
  late String estadoLed;
  late Esp32 esp32;
  late List<Datos> _listdatos = [];

  String get hora => _hora;

  set hora(String data) {
    _hora = data;
    notifyListeners();
  }
List<Datos> get listado =>_listdatos;

  set termica(String data) {
    _termica = data;
    print(" payload temp $data");
    notifyListeners();
  }

  String get termica => _termica;

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

  Future ping() async {
    _ping = true;
    notifyListeners();
    await Future.delayed(Duration(milliseconds: 300));
    _ping = false;
    //await Future.delayed(Duration(milliseconds: 100));
    notifyListeners();
  }

  bool get ping_on => _ping;

  String get temperatura => _temperatura;
  String get humedad => _humedad;

  Model() {
    client = MqttServerClient.withPort('34.125.227.33', 'flutter_client', 1883);
    init();
  }

  void init() async {
    _ping = false;
    temperatura = "100";
    await Future.delayed(const Duration(seconds: 2));
    temperatura = "0";
    humedad = "100";
    await Future.delayed(const Duration(seconds: 2));
    humedad = "0";
    await conectar();
  }

  Future<MqttServerClient> conectar() async {
    //client.logging(on: true);

    client.onConnected = () {
      print("Conectado......");
      client.subscribe("esp32/test", MqttQos.atLeastOnce);
      client.subscribe("esp32/promedio", MqttQos.atLeastOnce);
      estadoConexion = conexion.on;
      notifyListeners();
    };
    client.onDisconnected = () {
      print("Desconectado........................................");
      estadoConexion = conexion.off;
      _humedad = "0";
      _temperatura = "0";
      notifyListeners();
    };
    client.onUnsubscribed = (x) {
      print("funcion onUnsubscribed");
    };
    client.onSubscribed = (x) {
      print("suscripto a topico $x");
    };
    client.onSubscribeFail = (x) {
      print("suscripcion error");
    };
    client.pongCallback = () {
      print("pong Callbacj");
    };

    final connMessage = MqttConnectMessage()
        .authenticateAs('prueba', 'pancho@esteban')
        .keepAliveFor(60)
        .withWillTopic('no se')
        .withWillMessage('Mensaje desde flutter')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);

    client.connectionMessage = connMessage;

    try {
      await client.connect();
    } catch (e) {
      print('Exception: $e');
      client.disconnect();
    }

    client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      MqttPublishMessage message = c[0].payload as MqttPublishMessage;
      String payload =
          MqttPublishPayload.bytesToStringAsString(message.payload.message);

      if (c[0].topic == "esp32/test") {
        print("TEST");
        esp32 = esp32FromMap(payload.trim());

        _temperatura = esp32.temperatura;
        _humedad = esp32.humedad;
        _termica = esp32.termica;
        _hora = esp32.hora;
        ping();

        notifyListeners();
      }
      if (c[0].topic == "esp32/promedio") {
        print("PROMEDIO  ");

        dynamic jsonz = json.decode(payload);
        print(jsonz.length);
        print(jsonz);

        _listdatos=[];
        for (int i = 1; i <= jsonz.length; i++) {
          _listdatos.add(Datos.fromMap(jsonz[i.toString()]));
          print(_listdatos[i - 1].tem);
        notifyListeners();
        }

        //print('mensaje :${payload.trim()} del topic: ${c[0].topic}>');
      }
    });

    return client;
  }

  void desconectar() {
    try {
      client.disconnect();
    } catch (e) {
      print('Error al desconectar: $e');
    }
  }
}
