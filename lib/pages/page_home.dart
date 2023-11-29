import 'package:emqx/pages/page_custom.dart';
import 'package:emqx/provider/provider.dart';
import 'package:emqx/widget/grafico_temperatura.dart';
import 'package:emqx/widget/progress.dart';
import 'package:emqx/widget/reloj.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<Model>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          Center(
            child: model.estadoConexion == conexion.on
                ? Text("Ultimo Dato ${model.hora}")
                : const Text("Conectando..."),
          ),
          const SizedBox(
            width: 8,
          ),
          Icon(Icons.adjust_sharp,
              color: model.ping_on ? Colors.red : Colors.blue),
          const SizedBox(
            width: 20,
          ),
          Icon(Icons.signal_cellular_alt,
              color: model.estadoConexion == conexion.on
                  ? const Color.fromARGB(255, 158, 235, 161)
                  : Colors.red),
          const SizedBox(
            width: 20,
          ),
        ],
        title: const Text("Pancho"),
      ),
      body: body(model, context),
    );
  }

  CustomPaint body(Model model, BuildContext context) {
    return CustomPaint(
      painter: MyPainter(),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              model.listado.isNotEmpty
                  ? GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/grafico");
                      },
                      child: GraficoTem(
                        nlineas: 1,
                        dataTemp: model.listado,
                        size: 0.15,
                      ))
                  : const SizedBox(
                      height: 10,
                    ),
              const SizedBox(
                height: 20,
              ),
              TemperatureCircle(valor: model.termica),
              const SizedBox(
                height: 15,
              ),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Reloj(valor: model.temperatura),
                  Text(
                    "Temp ${model.temperatura}°C",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Reloj(valor: model.humedad),
                  Text(
                    " Humedad ${model.humedad}%",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              MaterialButton(
                  color: model.estadoConexion == conexion.off
                      ? Colors.blue
                      : const Color.fromARGB(255, 234, 59, 46),
                  child: model.estadoConexion == conexion.off
                      ? const Text(
                          "Conectar",
                          style: TextStyle(fontSize: 18),
                        )
                      : const Text(
                          "Desconectar",
                          style: TextStyle(fontSize: 18),
                        ),
                  onPressed: () async {
                    model.estadoConexion == conexion.off
                        ? model.init()
                        : model.desconectar();
                  }),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
