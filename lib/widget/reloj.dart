import 'package:gauge_indicator/gauge_indicator.dart';
import 'package:flutter/material.dart';

class Reloj extends StatelessWidget {
  const Reloj({required this.valor, Key? key}) : super(key: key);
  final String valor;

  /// Build method of your widget.
  @override
  Widget build(BuildContext context) {
    String numeroEnString = valor;
    double? numeroEntero = double.tryParse(numeroEnString);

    if (numeroEntero != null) {
      // La conversión se realizó con éxito.
     // print("Número entero: $numeroEntero");
    } else {
      numeroEntero = 0;
      // La conversión no pudo realizarse.
     // print("No es un número entero válido.");
    }

    // Create animated radial gauge.
    // All arguments changes will be automatically animated.
    return AnimatedRadialGauge(
      /// The animation duration.
      duration: const Duration(seconds: 5),
      curve: Curves.elasticOut,

      /// Define the radius.
      /// If you omit this value, the parent size will be used, if possible.
      radius: 100,

      /// Gauge value.
      value: numeroEntero,

      /// Optionally, you can configure your gauge, providing additional
      /// styles and transformers.
      axis: const GaugeAxis(

          /// Provide the [min] and [max] value for the [value] argument.
          min: 0,
          max: 80,

          /// Render the gauge as a 180-degree arc.
          degrees: 220,

          /// Set the background color and axis thickness.
          style: GaugeAxisStyle(
            thickness: 25,
            background: Color.fromARGB(0, 247, 247, 248),
            segmentSpacing: 10,
          ),

          /// Define the pointer that will indicate the progress (optional).
          pointer: GaugePointer.needle(
            borderRadius: 10,
            color: Color.fromARGB(255, 0, 1, 1),
            width: 10,
            height: 90,
          ),

          /// Define the progress bar (optional).
          progressBar: GaugeProgressBar.basic(
            color: Color.fromARGB(255, 4, 247, 32),
          ),

          /// Define axis segments (optional).
          segments: [
            GaugeSegment(
              from: 0,
              to: 33.3,
              color: Color.fromARGB(255, 19, 111, 30),
              cornerRadius: Radius.zero,
            ),
            GaugeSegment(
              from: 33.3,
              to: 66.6,
              color: Color.fromARGB(255, 247, 174, 28),
              cornerRadius: Radius.zero,
            ),
            GaugeSegment(
              from: 66.6,
              to: 100,
              color: Color.fromARGB(255, 242, 45, 14),
              cornerRadius: Radius.zero,
            ),
          ]

          /// You can also, define the child builder.
          /// You will build a value label in the following way, but you can use the widget of your choice.
          ///
          /// For non-value related widgets, take a look at the [child] parameter.
          /// ```
          /// builder: (context, child, value) => RadialGaugeLabel(
          ///  value: value,
          ///  style: const TextStyle(
          ///    color: Colors.black,
          ///    fontSize: 46,
          ///    fontWeight: FontWeight.bold,
          //  ),
          ),
      ///// ```
    );
  }
}
