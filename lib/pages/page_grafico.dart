import 'package:emqx/pages/page_custom.dart';
import 'package:emqx/provider/provider.dart';
import 'package:emqx/provider/provider_drawer.dart';
import 'package:emqx/widget/circulo.dart';
import 'package:emqx/widget/grafico_temperatura.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageGrafico extends StatelessWidget {
  const PageGrafico({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<Myprivider>(context);
    final model2 = Provider.of<ProviderDrawer>(context);
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
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 30),
                Expanded(
                    flex: 3,
                    child: GraficoTem(
                        nlineas: 2, dataTemp: model.listado, size: 0.5)),
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Circulo(
                        factor: 100,
                        color: model2.estadoTema ? Colors.white : Colors.black,
                        child: Text(
                            "Min ${model.maximoMinimo()[model.maximoMinimo().length - 1]}"),
                      ),
                      Circulo(
                        factor: 130,
                        color: model2.estadoTema ? Colors.white : Colors.black,
                        child: Text(" Max ${model.maximoMinimo()[0]}"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
