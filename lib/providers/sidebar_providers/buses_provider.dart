import 'package:flutter/material.dart';
import 'package:goa_bus/models/routes_model.dart';
import 'package:goa_bus/models/trips_model.dart';

class BusesProvider with ChangeNotifier{
  RoutesModel routesData;
  List<TripsModel> tripsDataList = [];
  TripsModel tripsData = TripsModel();

  void init() {
    tripsDataList = [];
    tripsData.route = null;
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

}
