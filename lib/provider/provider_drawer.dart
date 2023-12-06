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

  void init() {}
}
