import 'package:emqx/conexion.dart';
import 'package:emqx/provider/model.dart';
import 'package:emqx/widget/reloj.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => Model(),
      ),
      ChangeNotifierProvider(
        builder: (context, child) => const app(),
        create: (context) => Model(),
      )
    ]);
  }
}

class app extends StatelessWidget {
  const app({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<Model>(context);

    return MaterialApp(
      color: Colors.black,
      home: Scaffold(
        appBar: AppBar(title: const Text("EMQT")),
        body: Container(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Reloj(),
              Text(
                " Temperatura ${model.temperatura}°C",
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 30,
              ),
              MaterialButton(
                  color: Colors.red,
                  child: const Text("Cero"),
                  onPressed: () {
                    model.temperatura = "0";
                    // model.temperatura = "55";
                    //model.conectar();
                  }),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                  color: Colors.blue,
                  child: const Text("conectar"),
                  onPressed: () {
                    model.conectar();
                  }),
            ],
          ),
        )),
      ),
    );
  }
}
