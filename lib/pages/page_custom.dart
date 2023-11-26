import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [
          Color.fromARGB(255, 137, 235, 242),
          Colors.blue.shade700
        ], // Cambia los colores aquí
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0,
        size.height * .6); // Puedes ajustar la posición y altura de las ondas
    path.quadraticBezierTo(size.width * .25, size.height * .55,
        size.width * 0.5, size.height * .6);
    path.quadraticBezierTo(
        size.width * 0.85, size.height * 0.69, size.width, size.height * 0.6);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
