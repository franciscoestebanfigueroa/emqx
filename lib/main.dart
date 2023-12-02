import 'package:emqx/pages/page_grafico.dart';
import 'package:emqx/pages/page_home.dart';
import 'package:emqx/provider/provider.dart';
import 'package:emqx/widget/grafico_animado.dart';
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
        create: (_) => Myprivider(),
      ),
      ChangeNotifierProvider(
        builder: (context, child) => const App(),
        create: (context) => Myprivider(),
      )
    ]);
  }
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //theme: ThemeData(useMaterial3: false),
      //theme: ThemeData.dark(),
      theme: ThemeData.light(
        useMaterial3: true,
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routes: {
        "/": (BuildContext context) => const Home(),
        "/grafico": (context) => const PageGrafico()
        //"/grafico": (context) => const GraficoAnimado()
      },
      initialRoute: "/",
      debugShowCheckedModeBanner: false,
    );
  }
}
