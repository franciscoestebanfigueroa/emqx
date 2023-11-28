import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    final paint = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color(0xFF16868C),
          Color(0xFF168C43),
          Color(0xFF163C8C)
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

    canvas.save();
    
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
