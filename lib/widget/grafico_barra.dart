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
    final model = Provider.of<Model>(context);
    Set<double> nn = model.listTemp(dataTemp).toSet();
    print("set $nn");
    double maxtemperature = model.listTemp(dataTemp).reduce((value, element) {
      if (element > value) {
        value = element;
      }
      //print("value y element $value $element");
      return value;
    });

    double mintemperature = model
        .listTemp(dataTemp)
        .reduce((value, element) => value > element ? value = element : value);
    return Container(
      child: DiscreteGraphic(
          size: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height * 0.35),
          nums: model.listTemp(dataTemp),
          listGradX: model.listHora(dataTemp),
          colorAxes: Colors.black,
          colorLine: Colors.blue,
          strokeLine: 4.0,
          colorPoint: Color.fromARGB(255, 216, 70, 17),
          radiusPoint: 4.0,
          nbGradY: nn.length,
          minY: mintemperature,
          maxY: maxtemperature
          //model.listTemp(dataTemp).reduce((value, element) => value > element ? value : element

          ),
    );
  }
}
