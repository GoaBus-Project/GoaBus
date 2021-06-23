import 'package:flutter/cupertino.dart';

class HomePageProvider with ChangeNotifier{
  bool clicked = false;

  void startSendingLocation(){
    clicked = true;
    notifyListeners();
  }

  void stopSendingLocation(){
    clicked = false;
    notifyListeners();
  }
}

