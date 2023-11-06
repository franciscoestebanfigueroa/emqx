import 'package:emqx/provider/provider.dart';
import 'package:emqx/widget/grafico_barra.dart';
import 'package:emqx/widget/progress.dart';
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
      debugShowCheckedModeBanner: false,
      color: Colors.black,
      home: Scaffold(
        appBar: AppBar(actions: [
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
        ], title: const Text("--- Pancho ---")),
        body: Container(
            color: Colors.black45,
            child: Center(

              child: SingleChildScrollView(
                child: Column(
                  
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: 
                      [Column(
                         children: 
                      
                      List<Widget>.generate(8, (int index)   
                      {
                        if(model.listado.isNotEmpty) 
                        {

                        return Text ("${model.listado[index].tem}°C  ${model.listado[index].hora}",style: const TextStyle(fontSize: 20)  );
                        }

                        else{
                          return const Text("sin data" );
                        }
                      
                       }
                      
                      
                      ),                             
                      
                      ),
                        Text(
                          "Ultimo Dato ${model.hora}",
                          style: const TextStyle(fontSize: 20),
                        ),
                      ]
                      
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TemperatureCircle(valor: model.termica),
                    const SizedBox(
                      height: 50,
                    ),
                    Reloj(valor: model.temperatura),
                    Text(
                      " Temperatura ${model.temperatura}°C",
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Reloj(valor: model.humedad),
                    Text(
                      " Humedad ${model.humedad}%",
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 50,
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
                      height: 20,
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
