import 'package:emqx/widget/circulo.dart';
import 'package:flutter/material.dart';

import '../provider/provider_drawer.dart';

class SetTemperature extends StatelessWidget {
  const SetTemperature({
    super.key,
    required this.model,
  });

  final ProviderDrawer model;

  @override
  Widget build(BuildContext context) {
    return Container(
      
//     color:Colors.red,
      child:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:[
            const Text("Rango de Temperatura"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                
                children: [
                  TextField(
                    
                    controller: model.setMax,
                    maxLength: 2,
                    keyboardType: TextInputType.number,
                  ),
              TextField(
                keyboardType: TextInputType.number,
                controller: model.setMin,
                maxLength: 2,
              ),
                ],
              ),
            ),
            IconButton(onPressed: (){}, icon: Icon(Icons.swap_vert_circle_outlined,size: 50),),
            Container(                       
              height: 220,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Circulo(
                    factor: 70,
                    color: Colors.white,
                    child: Text("hola")),
                    Circulo(
                    factor: 60,
                    color: Colors.white,
                    child: Text("hola"),
                    
                    ),
                ],
              ),
            )
          ]
        ),
      ),
    );
  }
}
