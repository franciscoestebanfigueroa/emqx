import 'package:flutter/material.dart';

//enum  MyTema{ ThemeData.dark() ,light()}
class ProviderDrawer extends ChangeNotifier {
  bool _estadoTema = true;
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  ProviderDrawer() {
    init();
  }

  bool get estadoTema => _estadoTema;

  set estadoTema(bool x) {
    _estadoTema = x;
    notifyListeners();
  }

  void init() {
    globalKey.currentState!.openDrawer();

    //print("drawer ${globalKey.currentState!.isDrawerOpen}");
  }
}

void _drawerListener(DragEndDetails details) {
  if (details.primaryVelocity! > 0) {
    // Drawer se abrió
    print('El drawer se abrió');
    // Realiza las acciones que desees cuando el drawer se abra
  } else if (details.primaryVelocity! < 0) {
    // Drawer se cerró
    print('El drawer se cerró');
    // Realiza las acciones que desees cuando el drawer se cierre
  }
}
