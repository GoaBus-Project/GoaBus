import 'package:flutter/material.dart';

enum DisplayedPage { DASHBOARD, BUSES, DRIVERS, ROUTES, BUSSTOPS, SETTINGS }

class SideBarProvider with ChangeNotifier {
  DisplayedPage currentPage;
  String activeHeading = '';

  List<String> navBarHeadings = [
    'Dashboard',
    'Buses',
    'Drivers',
    'Routes',
    'Bus Stops',
    'Settings'
  ];

  void init() {
    currentPage = DisplayedPage.DASHBOARD;
    activeHeading = navBarHeadings[0];
  }

  void changeCurrentPage(DisplayedPage newPage) {
    currentPage = newPage;
    activeHeading = navBarHeadings[newPage.index];
    notifyListeners();
  }
}
