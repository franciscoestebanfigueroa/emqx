import 'package:emqx/provider/provider.dart';
import 'package:emqx/widget/grafico_temperatura.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyControler extends StatefulWidget {
  const MyControler({super.key});

  @override
  State<MyControler> createState() => _MyControlerState();
}

class _MyControlerState extends State<MyControler>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
     // duration: const Duration(seconds: 5),
      vsync: this);

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<Myprivider>(context);
    print(_controller.value);
    return Scaffold(
      body: Container(
        child: AnimatedOpacity(
          duration:const  Duration(seconds: 5),
          opacity:1- _controller.value,
          child: GraficoTem(dataTemp: model.listado, size: 1, nlineas: 2)),
      ),
    );
  }
}