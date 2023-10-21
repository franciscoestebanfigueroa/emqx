import 'package:emqx/provider/provider.dart';
import 'package:emqx/widget/reloj.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
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
    Future<MqttServerClient> client;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.black,
      home: Scaffold(
        appBar: AppBar(actions: [
          Icon(Icons.signal_cellular_alt,
              color: model.estadoConexion == conexion.on
                  ? const Color.fromARGB(255, 158, 235, 161)
                  : Colors.red),
          const SizedBox(
            width: 20,
          ),
        ], title: const Text("EMQTX --- Pancho ---")),
        body: Container(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Reloj(valor: model.temperatura),
              Text(
                " Temperatura ${model.temperatura}°C",
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 30,
              ),
              Reloj(valor: model.humedad),
              Text(
                " Humedad ${model.humedad}%",
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 30,
              ),
              MaterialButton(
                  color: Colors.blue,
                  child: const Text("conectar"),
                  onPressed: () async {
                    client = model.conectar();
                  }),
              MaterialButton(
                  color: Colors.red,
                  child: const Text("Desconectar"),
                  onPressed: () async {
                    model.temperatura = "0";
                    model.humedad = "0";

                    model.desconectar();
                  }),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        )),
      ),
    );
  }
}
