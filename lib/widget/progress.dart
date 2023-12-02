import 'package:flutter/material.dart';
import 'dart:math';

class TemperatureCircle extends StatelessWidget {
  final String valor; // Temperatura en grados Celsius
  final double maxTemperature; // Temperatura máxima (puedes ajustarla)
  final double circleRadius; // Radio del círculo
  final double lineWidth; // Grosor de la línea del círculo

  const TemperatureCircle({
    super.key,
    required this.valor,
    this.maxTemperature = 100.0,
    this.circleRadius = 100.0,
    this.lineWidth = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    // Calcula el porcentaje de progreso basado en la temperatura
    String numeroEnString = valor;
    double? temperature = double.tryParse(numeroEnString);
    final progress = min(temperature! / maxTemperature, 1.0);
    Gradient gradient1 = const LinearGradient(colors: [
      Colors.red,
      Colors.blue,
    ]);
    Gradient gradient2 = const LinearGradient(colors: [
      Color.fromARGB(255, 57, 219, 57),
      Color.fromARGB(255, 202, 37, 15),
    ]);
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 400),
      builder: (context, value, child) => AnimatedScale(
        scale: value,
        duration: const Duration(milliseconds: 400),
        child: Stack(
          children: [
            SizedBox(
              width: circleRadius * 2,
              height: circleRadius * 1.5,
              child: CustomPaint(
                foregroundPainter:
                    CircleProgressPainter(100, lineWidth, gradient1),
                //child: Text(),
              ),
            ),
            SizedBox(
              width: circleRadius * 2,
              height: circleRadius * 1.5,
              child: CustomPaint(
                foregroundPainter:
                    CircleProgressPainter(progress, lineWidth, gradient2),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$temperature°C',
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "Sensación",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "Térmica",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CircleProgressPainter extends CustomPainter {
  final double progress; // Porcentaje de progreso (0.0 a 1.0)
  final double lineWidth; // Grosor de la línea

  final Gradient gradient;
  final Rect rect = Rect.fromCircle(center: const Offset(0, 0), radius: 180);

  CircleProgressPainter(this.progress, this.lineWidth, this.gradient);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);
    final paint = Paint()
      ..shader = gradient.createShader(rect)
      //..color = color // Color de la línea del círculo
      ..style = PaintingStyle.stroke
      ..strokeWidth = lineWidth;

    // Dibuja el círculo progresivo
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2, // Ángulo de inicio (desde arriba)
      2 * pi * progress, // Ángulo de final
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
