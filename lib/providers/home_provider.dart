import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier{
  String source = '';
  String destination = '';
  bool showBusList = false;

  void enableDisableBusList(){
    showBusList = true;
    notifyListeners();
  }
}