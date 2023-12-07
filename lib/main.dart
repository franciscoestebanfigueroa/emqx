import 'package:emqx/pages/page_grafico.dart';
import 'package:emqx/pages/page_home.dart';
import 'package:emqx/provider/provider.dart';
import 'package:emqx/provider/provider_drawer.dart';

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
      ChangeNotifierProvider(create: (context) => ProviderDrawer()),
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
    final model = Provider.of<ProviderDrawer>(context);
    return MaterialApp(
        theme: model.estadoTema ? ThemeData.light(
        useMaterial3: true
      ) : ThemeData.dark(
        useMaterial3: true
      ),
      
      routes: {
        "/": (BuildContext context) => const Home(),
        "/grafico": (context) => const PageGrafico()
      },
      initialRoute: "/",
      debugShowCheckedModeBanner: false,
    );
  }
}
