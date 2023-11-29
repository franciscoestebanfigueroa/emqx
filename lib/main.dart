import 'package:emqx/pages/page_grafico.dart';
import 'package:emqx/pages/page_home.dart';
import 'package:emqx/provider/provider.dart';
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
        builder: (context, child) => const App(),
        create: (context) => Model(),
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
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      routes: {
        "/": (BuildContext context) => const Home(),
        "/grafico": (context) => const PageGrafico()
      },
      initialRoute: "/",
      debugShowCheckedModeBanner: false,
    );
  }
}
