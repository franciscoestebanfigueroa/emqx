import 'package:emqx/pages/page_custom.dart';
import 'package:emqx/provider/provider.dart';
import 'package:emqx/provider/provider_drawer.dart';
import 'package:emqx/widget/my_drawer.dart';
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
    final model = Provider.of<Myprivider>(context);
    final modelDrawer = Provider.of<ProviderDrawer>(context);

    return Scaffold(
      // key: modelDrawer.globalKey,
      drawer: const MyDrawer(),
      appBar: AppBar(
        actions: [
          Center(
            child: model.estadoConexion == Conexion.on
                ? Text(" ${model.hora}")
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
              color: model.estadoConexion == Conexion.on
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

  CustomPaint body(Myprivider model, BuildContext context) {
    return CustomPaint(
      painter: MyPainter(),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              model.listTemp().length >= 2
                  ? GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/grafico");
                      },
                      child: GraficoTem(
                        nlineas: 1,
                        dataTemp: model.listado,
                        size: 0.15,
                      ),
                    )
                  : const SizedBox(),
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
                  color: model.estadoConexion == Conexion.off
                      ? Colors.blue
                      : const Color.fromARGB(255, 234, 59, 46),
                  child: model.estadoConexion == Conexion.off
                      ? const Text(
                          "Conectar",
                          style: TextStyle(fontSize: 18),
                        )
                      : const Text(
                          "Desconectar",
                          style: TextStyle(fontSize: 18),
                        ),
                  onPressed: () async {
                    model.estadoConexion == Conexion.off
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
