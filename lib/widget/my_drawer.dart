import 'dart:math';

import 'package:emqx/provider/provider.dart';
import 'package:emqx/provider/provider_drawer.dart';
import 'package:emqx/widget/circulo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/page_set_temperature.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mode = Provider.of<Myprivider>(context);
    final modelDwer = Provider.of<ProviderDrawer>(context);
    return Drawer(
      //backgroundColor: Colors.indigo,
      semanticLabel: "Drawer",
      //surfaceTintColor: Colors.orange,
      elevation: 20,
      //width: 100,
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: CircleAvatar(
              //radius: MediaQuery.of(context).size.width*.2,
              maxRadius: 100,
              child: Circulo(
                color: modelDwer.estadoTema ? Colors.white : Colors.black,
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 500),
                  style: mode.ping_on
                      ? const TextStyle(fontSize: 30, color: Colors.blue)
                      : const TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 152, 198, 236)),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Monitoreo",
                      ),
                      Text("de"),
                      Text("Temperatura"),
                    ],
                  ),
                ),
              ),
              // radius:MediaQuery.of(context).size.width*.2,
            ),
          ),
          const Expanded(flex: 6, child: SetTemperature()),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                modelDwer.estadoTema
                    ? const Text("Estilo Noche")
                    : const Text(
                        "Estilo Dia",
                        style: TextStyle(color: Colors.white),
                      ),
                Switch.adaptive(
                  value: modelDwer.estadoTema,
                  onChanged: (bool x) {
                    modelDwer.estadoTema = !modelDwer.estadoTema;
                    print(x);
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
