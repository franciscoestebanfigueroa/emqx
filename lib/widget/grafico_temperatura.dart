import 'package:emqx/model/model_promedio.dart';
import 'package:emqx/provider/provider.dart';
import 'package:graphic_representation/graphic_representation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GraficoTem extends StatelessWidget {
  const GraficoTem(
      {super.key,
      required this.dataTemp,
      required this.size,
      required this.nlineas});
  final double size;
  final List<Datos> dataTemp;

  final int nlineas;

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<Myprivider>(context);
    model.maximoMinimo();

    Set<double> setTemp = model.listTemp().toSet();
      
    

    // print("set temperatura $set_temp");
     print("max ${model.tempOrdenadasHoras[0]}");
     print("min ${model.listTempOrdenado[model.listTempOrdenado.length-1]}}");
    return DiscreteGraphic(
      size: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height * size),
      nums: model.listTemp(),
      listGradX: model.listHora(dataTemp),
      colorAxes: Colors.black,
      colorLine: const Color.fromARGB(255, 10, 44, 194),
      strokeLine: 2.5,
      colorPoint: const Color.fromARGB(255, 216, 40, 17),
      radiusPoint: 4.0,
      nbGradY: setTemp.length * nlineas,
      maxY: model.listTempOrdenado[0],
      minY: model.listTempOrdenado[model.listTempOrdenado.length-1],
    );
  }
}


