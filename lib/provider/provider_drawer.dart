import 'package:flutter/material.dart';

//enum  MyTema{ ThemeData.dark() ,light()}
class ProviderDrawer extends ChangeNotifier{
bool _estadoTema=true; 

ProviderDrawer(){}

 bool get estadoTema=>_estadoTema;

 set estadoTema(bool x){
  _estadoTema=x;
  notifyListeners();  
 }

 

}