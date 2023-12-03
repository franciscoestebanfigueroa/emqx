import 'package:emqx/provider/provider_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model=Provider.of<ProviderDrawer>(context);
    return Drawer(
      backgroundColor: Colors.indigo,
      semanticLabel: "Drawer",
      surfaceTintColor: Colors.orange,
      elevation: 20,
      //width: 100,
      child: Column(
        children: [
         
          const Expanded(
            child: CircleAvatar(
              // radius:MediaQuery.of(context).size.width*.2,
            ),
          ),

            Expanded(child: Container(color: Colors.red,)),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                model.estadoTema?const Text("Estilo Noche"):
          const Text("Estilo Dia",style: TextStyle(color: Colors.white),),
          Switch.adaptive(
            
            value: model.estadoTema,
            onChanged: (bool x) {
              model.estadoTema=!model.estadoTema;
              print(x);
            },
          )
              ],
            ),
            ),
          
        ],
      ),
    );
  }
}
