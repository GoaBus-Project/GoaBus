import 'package:flutter/material.dart';

enum DisplayedPage {DASHBOARD, BUSES, DRIVERS, ROUTES, BUSSTOPS, SETTINGS}

class SideBarProvider with ChangeNotifier {
  DisplayedPage currentPage;
  List<String> navBarHeadings = ['Dashboard', 'Buses', 'Drivers', 'Routes', 'Bus Stops', 'Settings'];
  String activeHeading = '';

  init(){
    currentPage = DisplayedPage.DASHBOARD;
    activeHeading = navBarHeadings[0];
  }

  changeCurrentPage(DisplayedPage newPage){
    currentPage = newPage;
    activeHeading = navBarHeadings[newPage.index];
    notifyListeners();
  }
}