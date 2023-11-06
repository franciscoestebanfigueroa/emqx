// To parse this JSON data, do
//
//     final esp32 = esp32FromMap(jsonString);

import 'dart:convert';

List<Esp32> listEsp32(String str) {
  List<Esp32> listado = [];
  Map<String, dynamic> data = json.decode(str);

  print(data.length);
  //print(data["2"]["Temperatura"] ?? "nada");
  for (int i = 1; i <= data.length; i++) {
    listado.add(Esp32(
      hora: data[i.toString()]["hora"] ?? "",
      termica: data[i.toString()]["Termica"] ?? "nada",
      temperatura: data[i.toString()]["Temperatura"] ?? "nada",
      humedad: data[i.toString()]["Tumedad"] ?? "nada",
    ));
  }

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
        temperatura: json["temperatura"] ?? "nada",
        humedad: json["humedad"] ?? "nada",
        termica: json["termica"] ?? "nada",
        hora: json["hora"] ?? "nada",
      );

  Map<String, dynamic> toMap() => {
        "temperatura": temperatura,
        "humedad": humedad,
        "termica": termica,
        "hora": hora
      };
}
