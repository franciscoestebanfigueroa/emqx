import 'package:flutter/material.dart';


class Model extends  ChangeNotifier {
 String _mensaje="sin data";
 bool _estado_server=false;


 bool get estado_server => _estado_server;

mensaje(String data){
  _mensaje=data;
  notifyListeners();
}



}
  
