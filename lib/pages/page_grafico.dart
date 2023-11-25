import 'package:emqx/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widget/grafico_temperatura.dart';

class PageGrafico extends StatelessWidget {
  const PageGrafico({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<Model>(context);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            model.listado.isNotEmpty
                      ? GraficoTem(dataTemp: model.listado)
                      : const SizedBox(
                          height: 20,
                        ),
          ],
        ),
      ),
      
    );
  }
}