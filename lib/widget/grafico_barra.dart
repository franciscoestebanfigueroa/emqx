

import 'package:emqx/model/model_promedio.dart';
import 'package:emqx/provider/provider.dart';
import 'package:graphic_representation/graphic_representation.dart';  
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class GraficoTem extends StatelessWidget {


   GraficoTem({super.key, required this.dataTemp});

  List<Datos> dataTemp;

  @override
  Widget build(BuildContext context) {
  final model=Provider.of<Model>(context);
  model.listHora(dataTemp).reduce((value, element) {
     
     print("value y element $value $element");
     return value;
     });
    return Container(
      child: DiscreteGraphic(
            size: Size(MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height * 0.35),
              nums:
              // List<double>.generate(dataTemp.length, (int index) => double.parse(dataTemp[index].tem)),
                 model.listTemp(dataTemp),
                 listGradX: const [
              "Lun",
              "Mar",
              "Mer",
              "Jeu",
              "Ven",
              "Sam",
              "Dim",
            ],
            colorAxes: Colors.black,
            colorLine: Colors.blue,
            strokeLine : 2.0,
            colorPoint: Colors.blue,
            radiusPoint: 3.0,
            nbGradY: 9,
            minY: 0,
            maxY:40
            //model.listTemp(dataTemp).reduce((value, element) => value > element ? value : element
            

          ),
    );
  }
}