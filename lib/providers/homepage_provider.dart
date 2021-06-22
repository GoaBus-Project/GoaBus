import 'package:flutter/cupertino.dart';

class HomepageProvider with ChangeNotifier{
  bool clicked = false;
  String selected = '';
  List<String> items = ['One' ,'Two' ,'Three' ,'Four' ,'Five' ,'Six' ,'Seven' ,'Eight' ,'Nine' ,'Ten' ,];

  void startSendingLocation(){
    clicked = true;
    notifyListeners();
  }

  void stopSendingLocation(){
    clicked = false;
    notifyListeners();
  }
}