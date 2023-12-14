import 'package:emqx/model/model.dart';
import 'package:emqx/provider/provider.dart';
import 'package:emqx/widget/circulo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/provider_drawer.dart';

class SetTemperature extends StatelessWidget {
  const SetTemperature({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final modelDw = Provider.of<ProviderDrawer>(context);
    final model = Provider.of<Myprivider>(context);
    return Container(
//     color:Colors.red,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          const Text("Rango de Temperatura"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              children: [
                TextField(
                  controller: modelDw.setMax,
                  maxLength: 2,
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: modelDw.setMin,
                  maxLength: 2,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: model.estadoConexion == Conexion.off ||
                    model.estadoBotonData == EstadoBotonData.set
                ? null
                : () {
                    DataSeteo dataSeteo = DataSeteo(
                        min: modelDw.setMin.text.toString(),
                        max: modelDw.setMax.text.toString(),
                        estado: "set");
                    model.setTemperatura(dataSeteo);
                  },
            icon: Icon(
              Icons.swap_vert_circle_outlined,
              size: 50,
              color: model.estadoBotonData == EstadoBotonData.set
                  ? Colors.red
                  : Colors.green,
            ),
          ),
          Container(
            height: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Circulo(
                    factor: 70, color: Colors.white, child: Text(model.setMax)),
                Circulo(
                  factor: 60,
                  color: Colors.white,
                  child: Text(model.setMin),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
