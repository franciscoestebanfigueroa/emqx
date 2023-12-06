import 'dart:math';

import 'package:emqx/provider/provider.dart';
import 'package:emqx/provider/provider_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model2 = Provider.of<Myprivider>(context);
    final model = Provider.of<ProviderDrawer>(context);
    return Drawer(
      //backgroundColor: Colors.indigo,
      semanticLabel: "Drawer",
      //surfaceTintColor: Colors.orange,
      elevation: 20,
      //width: 100,
      child: Column(
        children: [
          Expanded(
            child: CircleAvatar(
              //radius: MediaQuery.of(context).size.width*.2,
              maxRadius: 100,
              child: Circulo(
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 500),
                  style: model2.ping_on
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
          Expanded(child: Circulo()),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                model.estadoTema
                    ? const Text("Estilo Noche")
                    : const Text(
                        "Estilo Dia",
                        style: TextStyle(color: Colors.white),
                      ),
                Switch.adaptive(
                  value: model.estadoTema,
                  onChanged: (bool x) {
                    model.estadoTema = !model.estadoTema;
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

class Circulo extends StatelessWidget {
  const Circulo({super.key, this.child});

  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedRotation(
          duration: const Duration(seconds: 1000),
          turns: 1000,
          child: Container(
            width: 200,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Colors.red, Colors.blue]),
              //color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Container(
          width: 180,
          decoration: const BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
          child: child,
        ),
      ],
    );
  }
}
