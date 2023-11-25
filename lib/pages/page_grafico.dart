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
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        
        appBar: AppBar(
          title: const Text("Grafico"),
          
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 50),
                    color: Colors.black45,

          child: Column(

            children: [
              model.listado.isNotEmpty
                        ? GraficoTem(dataTemp: model.listado,size: 0.5)
                        : const SizedBox(
                            height: 20,
                          ),
            ],
          ),
        ),
      ),
      
    );
  }
}