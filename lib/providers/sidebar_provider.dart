import 'package:flutter/material.dart';

enum DisplayedPage {DASHBOARD, BUSES, DRIVERS, LOCATION, SETTINGS}

class SideBarProvider with ChangeNotifier {
  DisplayedPage currentPage;

  SideBarProvider.init(){
    changeCurrentPage(DisplayedPage.DASHBOARD);
  }

  changeCurrentPage(DisplayedPage newPage){
    currentPage = newPage;
    notifyListeners();
  }
}