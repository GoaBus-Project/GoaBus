import 'package:flutter/material.dart';
import 'package:goa_bus/models/routes_model.dart';
import 'package:goa_bus/repositories/routes_repository.dart';

class BusesProvider with ChangeNotifier{
  RoutesModel routesData = RoutesModel();

  BusRoute route = BusRoute();

  bool loading = false;

  String busNo = '';

  List<String> routes = <String>[
    "Route 1",
    "route 2",
    "Route 3",
    "route 4",
  ];

  /*void init() {
    routes.startTime = TimeOfDay(hour: 12, minute: 00);
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
    loading = true;
    notifyListeners();
    return await RoutesRepository().saveRoutes(routesData).whenComplete(() {
      loading = false;
      notifyListeners();
    });
  }*/

}
