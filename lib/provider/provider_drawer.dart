import 'package:flutter/material.dart';

//enum  MyTema{ ThemeData.dark() ,light()}
class ProviderDrawer extends ChangeNotifier {
  bool _estadoTema = true;
  TextEditingController setMax=TextEditingController();
  TextEditingController setMin=TextEditingController();

  ProviderDrawer() {
  print("provider drawer");
  print(setMax);
  print(setMin);

    init();
  }


  bool get estadoTema => _estadoTema;

  set estadoTema(bool x) {
    _estadoTema = x;
    notifyListeners();
  }

  void init() {}
}
