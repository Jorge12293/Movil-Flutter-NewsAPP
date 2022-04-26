import 'package:flutter/material.dart';

class WifiService with ChangeNotifier{
  
  String _wifiProvider = '';
  bool _wifiProviderBool = false;
  
  String get wifiProvider => _wifiProvider;
  set wifiProvider(String value){
    _wifiProvider=value;
    notifyListeners();
  }

  bool get wifiProviderBool => _wifiProviderBool;
  set wifiProviderBool(bool value){
    _wifiProviderBool=value;
    notifyListeners();
  }

}