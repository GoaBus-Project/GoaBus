import 'package:flutter/material.dart';
import 'package:goa_bus/models/routes_model.dart';
import 'package:goa_bus/models/trips_model.dart';

class BusesProvider with ChangeNotifier{
  RoutesModel routesData = RoutesModel();
  List<TripsModel> tripsDataList = [];
  TripsModel tripsData = TripsModel();
  String busNo = '';

  List<String> routes = <String>[
    "Route 1",
    "route 2",
    "Route 3",
    "route 4",
  ];

  void init() {
    tripsDataList = [];
    tripsData.startTime = TimeOfDay(hour: 12, minute: 00);
    tripsData.endTime = TimeOfDay(hour: 12, minute: 00);
  }

  void setRoute(String route) {
    tripsData.route = route;
    notifyListeners();
  }

  void setStartTime(TimeOfDay time) {
    tripsData.startTime = time;
    notifyListeners();
  }

  void setEndTime(TimeOfDay time) {
    tripsData.endTime = time;
    notifyListeners();
  }

  void addRoute() {
    tripsDataList.add(tripsData);
    tripsData = TripsModel();
    tripsData.startTime = TimeOfDay(hour: 12, minute: 00);
    tripsData.endTime = TimeOfDay(hour: 12, minute: 00);
    tripsData.route = null;
    notifyListeners();
  }

  void removeRoute(int index) {
    tripsDataList.removeAt(index);
    notifyListeners();
  }

  String checkData() {
    String message = '';
    routesData.trips = List<TripsModel>.from(tripsDataList);
    if(routesData.busNo == '' || routesData.busNo == null)
      return 'Enter bus number';
    else if(routesData.trips.length == 0)
      return 'Please select at least one route';
    return message;
  }

  Future<bool> saveRoutesData() async {
    bool success = false;
    return success;
  }

}
