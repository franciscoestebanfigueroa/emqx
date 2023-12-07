import 'package:flutter/material.dart';

class Circulo extends StatefulWidget {
  const Circulo(
      {super.key, this.child, required this.color, this.factor = 200});

  final Widget? child;
  final Color color;
  final double? factor;
  @override
  State<Circulo> createState() => _CirculoState();
}

class _CirculoState extends State<Circulo> with TickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _controller.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        RotationTransition(
          turns: Tween<double>(begin: 0, end: 1).animate(_controller),
          child: Container(
            width: widget.factor,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Colors.red, Colors.blue]),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Container(
          width: widget.factor! * 0.9,
          decoration: BoxDecoration(
            color: widget.color,
            shape: BoxShape.circle,
          ),
        ),
        Center(
          child: widget.child,
        )
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
