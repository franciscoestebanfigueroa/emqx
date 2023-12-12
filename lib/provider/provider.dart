import 'dart:convert';
import 'dart:ffi';

import 'package:emqx/model/model.dart';
import 'package:emqx/model/model_promedio.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:mqtt_client/mqtt_client.dart';

enum Conexion { on, off }



class Myprivider extends ChangeNotifier {
  String _temperatura = "0";
  String _humedad = "0";
  String _termica = "0";
  String _hora = "";
  bool _ping = false;
  List<Map<String, dynamic>> tempOrdenadasHoras = [];
  List<double> _listTempOrdenado = [];
  late MqttServerClient client;

  Conexion estadoConexion = Conexion.off;
  late String estadoLed;
  late Esp32 esp32;
  late final List<Datos> _listdatos = [];

  String get hora => _hora;

  set hora(String data) {
    _hora = data;
    notifyListeners();
  }

  List<Datos> get listado => _listdatos;

  set termica(String data) {
    _termica = data;
    print(" payload temp $data");
    notifyListeners();
  }

  String get termica => _termica;

  set temperatura(String data) {
    _temperatura = data;
    // print(" payload temp $data");
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
    await Future.delayed(const Duration(milliseconds: 300));
    _ping = false;
    //await Future.delayed(Duration(milliseconds: 100));
    notifyListeners();
  }

  bool get ping_on => _ping;

  String get temperatura => _temperatura;
  String get humedad => _humedad;

  Myprivider() {
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
      client.subscribe("esp32/settemp", MqttQos.atLeastOnce);
      estadoConexion = Conexion.on;
      final builder = MqttClientPayloadBuilder();
    builder.addString('{"estado":"set","min":"4","max":"8"}');
     
      client.publishMessage('topic/flutter', MqttQos.exactlyOnce, builder.payload! );
      notifyListeners();
    };
    client.onDisconnected = () {
      print("Desconectado........................................");
      estadoConexion = Conexion.off;
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

        try {
        dynamic jsonz = json.decode(payload);
        print("jsonz -> $jsonz");

        _listdatos.clear();
        tempOrdenadasHoras.clear();

        for (int x = 1; x <= jsonz.length; x++) {
          tempOrdenadasHoras.add(jsonz[x.toString()]);
        }


        } catch (e) {
          print("Json promedio"); 
        }
        //print(jsonz.length);
        try {
          tempOrdenadasHoras.sort(
            (a, b) {
              return a["H"].compareTo(b["H"]);
            },
          );
        } catch (e) {
          print(" no se pudo ordenar lista por error en hora $e");
        }
        for (var x in tempOrdenadasHoras) {
          _listdatos.add(Datos.fromMap(x));
          //   print(" en povider _listado ${x["H"]}");
          notifyListeners();
        }

        //print('mensaje :${payload.trim()} del topic: ${c[0].topic}>');
      }
    });

    return client;
  }

  // int compararHoras(Map<String, dynamic> a, Map<String, dynamic> b) {
  //   return b["H"].compareTo(a["H"]); // Orden de mayor a menor
  // }

  //int compararTemp(Map<String, dynamic> a, Map<String, dynamic> b) {
  //  return b["T"].compareTo(a["T"]); // Orden de mayor a menor
  //}

  void desconectar() {
    try {
      client.disconnect();
    } catch (e) {
      print('Error al desconectar: $e');
    }
  }

  List<double> listTemp() {
    List<double> listTemp = [];

    for (var value in listado) {
      try {
        listTemp.add(double.parse(value.tem));
      } catch (e) {
        print("no se puede convertir");
        listTemp.add(0.0);
      }
    }

    return listTemp;
  }

  List<double>maximoMinimo() {
    _listTempOrdenado = listTemp();
    _listTempOrdenado.sort((a, b) {
      return b.compareTo(a);
    });
    print("listado ordenado $_listTempOrdenado");
    return _listTempOrdenado;
  }

  List<String> listHora(List<Datos> datos) {
    List<String> listhora = [];
    for (var value in datos) {
      try {
        listhora.add(value.hora);
      } catch (e) {
        print("no se puede convertir");
        listhora.add("sin hora..");
      }
    }
    return listhora;
  }
}
