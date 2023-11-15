// To parse this JSON data, do
//
//     final esp32 = esp32FromMap(jsonString);

import 'dart:convert';

List<Esp32> listEsp32(String str) {
  List<Esp32> listado = [];
  Map<String, dynamic> data = json.decode(str);

 // print(data.length);
  for (int i = 1; i <= data.length; i++) {
    listado.add(Esp32(
      hora: data[i.toString()]["hora"] ?? "0",
      termica: data[i.toString()]["Termica"] ?? "0",
      temperatura: data[i.toString()]["Temperatura"] ?? "0",
      humedad: data[i.toString()]["Tumedad"] ?? "0",
    ));
  }

  print(listado);
  return listado;
}

Esp32 esp32FromMap(String str) => Esp32.fromMap(json.decode(str));

String esp32ToMap(Esp32 data) => json.encode(data.toMap());

class Esp32 {
  final String temperatura;
  final String humedad;
  final String termica;
  final String hora;

  Esp32({
    required this.hora,
    required this.termica,
    required this.temperatura,
    required this.humedad,
  });

  factory Esp32.fromMap(Map<String, dynamic> json) => Esp32(
        temperatura: json["temperatura"] ?? "0",
        humedad: json["humedad"] ?? "0",
        termica: json["termica"] ?? "0",
        hora: json["hora"] ?? "0:0",
      );

  Map<String, dynamic> toMap() => {
        "temperatura": temperatura,
        "humedad": humedad,
        "termica": termica,
        "hora": hora
      };



}
