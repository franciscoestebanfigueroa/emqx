import 'package:emqx/provider/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: 
    [
      ChangeNotifierProvider(
        builder: (context, child) => app(),
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
      color: Colors.black,           
      home: Scaffold(
        appBar: AppBar(title: Text("EMQT")),
        body: Container(
          
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                
                MaterialButton(
                  color: Colors.red,
                  child: Text("Conectar"),
                  onPressed: (){}),
                  SizedBox(
                    height: 40,
                  ),
                MaterialButton(
                  color: Colors.blue,
                  child: Text("Led"),
                  onPressed: (){}),
              ],
            ),
          )

        ),
        
      ),
      
    );
 
  }
}