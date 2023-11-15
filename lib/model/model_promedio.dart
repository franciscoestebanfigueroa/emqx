// To parse this JSON data, do
//
//     final promedio = promedioFromMap(jsonString);

import 'dart:convert';

List<Map<String, dynamic>> promedioJson(String str) {
  return json.decode(str);
}

class Datos {
  final String tem;
  final String hora;

  Datos({required this.tem, required this.hora});

  factory Datos.fromMap(Map<String, dynamic> json) => Datos(
        tem: json["T"] ?? "0",
        hora: json["H"] ?? "0:0",
      );


   //Map<String,dynamic> Datos.toMap()=>    
}
