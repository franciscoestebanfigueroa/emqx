import 'package:emqx/provider/provider.dart';
import 'package:emqx/widget/grafico_temperatura.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GraficoAnimado extends StatefulWidget {
  const GraficoAnimado({super.key});

  @override
  State<GraficoAnimado> createState() => _GraficoAnimadoState();
}

class _GraficoAnimadoState extends State<GraficoAnimado>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<Myprivider>(context);
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 600),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, value, child) => AnimatedOpacity(
        duration: const Duration(milliseconds: 600),
        opacity: value,
        child: GraficoTem(dataTemp: model.listado, size: 0.5, nlineas: 2),
      ),
    );
  }
}
