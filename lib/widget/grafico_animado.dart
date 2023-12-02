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
  late AnimationController _controller;
  

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this);
  _controller.forward();
  
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<Myprivider>(context);
    print("controler en widget animado ${_controller.value}");
    return 
      AnimatedOpacity(
        duration:const  Duration(milliseconds: 500),
        opacity:_controller.value,
        child: GraficoTem(dataTemp: model.listado, size: 0.5, nlineas: 2),);
    
  }
  
}