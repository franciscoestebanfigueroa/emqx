import 'package:emqx/pages/page_custom.dart';
import 'package:emqx/provider/provider.dart';
import 'package:emqx/widget/grafico_animado.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//import '../widget/grafico_temperatura.dart';

class PageGrafico extends StatelessWidget {
  const PageGrafico({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<Myprivider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context)
                .pop(); // Acción al presionar el botón de regreso
          },
        ),
        title: const Text("Grafico"),
      ),
      body: SafeArea(
        child: CustomPaint(
          painter: MyPainter(),
          child: Container(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Text(
                      "Min ${model.listTempOrdenado[model.listTempOrdenado.length - 1]} / Max ${model.listTempOrdenado[0]}"),
                  //GraficoTem(nlineas: 2, dataTemp: model.listado, size: 0.5),
                  const GraficoAnimado(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
