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
    
    return MaterialApp(
      
      routes: {
       "/":(BuildContext context) => const Home(),
       "/grafico":(context) => const PageGrafico() 
      },
      initialRoute: "/",
      debugShowCheckedModeBanner: false,
      color: Colors.black,
      
      
    );
  }
}
