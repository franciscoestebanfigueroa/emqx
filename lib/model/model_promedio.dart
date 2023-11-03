// To parse this JSON data, do
//
//     final promedio = promedioFromMap(jsonString);

import 'dart:convert';

Promedio promedioFromMap(String str) => Promedio.fromMap(json.decode(str));

String promedioToMap(Promedio data) => json.encode(data.toMap());

class Promedio {
  final Datos datos;

  Promedio({
    required this.datos,
  });

  factory Promedio.fromMap(Map<String, dynamic> json) => Promedio(
        datos: Datos.fromMap(json["datos"]),
      );

  Map<String, dynamic> toMap() => {
        "datos": datos.toMap(),
      };
}

class Datos {
  final String hum;
  final String tem;
  final String ter;
  final String hora;

  Datos({
    required this.hum,
    required this.tem,
    required this.ter,
    required this.hora,
  });

  factory Datos.fromMap(Map<String, dynamic> json) => Datos(
        hum: json["Hum"],
        tem: json["Tem"],
        ter: json["Ter"],
        hora: json["hora"],
      );

  Map<String, dynamic> toMap() => {
        "Hum": hum,
        "Tem": tem,
        "Ter": ter,
        "hora": hora,
      };
}
