// To parse this JSON data, do
//
//     final esp32 = esp32FromMap(jsonString);

import 'dart:convert';

Esp32 esp32FromMap(String str) => Esp32.fromMap(json.decode(str));

String esp32ToMap(Esp32 data) => json.encode(data.toMap());

class Esp32 {
  final String temperatura;
  final String humedad;
  final String termica;
  Esp32({
    required this.termica,
    required this.temperatura,
    required this.humedad,
  });

  factory Esp32.fromMap(Map<String, dynamic> json) => Esp32(
        temperatura: json["temperatura"],
        humedad: json["humedad"],
        termica: json["termica"],
      );

  Map<String, dynamic> toMap() =>
      {"temperatura": temperatura, "humedad": humedad, "termica": termica};
}
