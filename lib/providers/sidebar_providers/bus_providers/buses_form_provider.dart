import 'package:flutter/material.dart';
import 'package:goa_bus/models/buses_model.dart';
import 'package:goa_bus/models/routes_model.dart';
import 'package:goa_bus/repositories/buses_repository.dart';
import 'package:goa_bus/repositories/routes_repository.dart';

class BusesFormProvider with ChangeNotifier {
  Bus busData = Bus();

  Trip trip = Trip();

  RoutesModel routesModelData = RoutesModel();

  bool loading = false, routesLoading = false;

  List<String> routes = [];


  void init() async {
    busData.trips = <Trip>[];
    trip.startTime = TimeOfDay(hour: 12, minute: 00);
    trip.endTime = TimeOfDay(hour: 12, minute: 00);
    await getRoutes();
  }

  Future<void> getRoutes() async {
    routesLoading = true;
    notifyListeners();
    routesModelData = await RoutesRepository().fetchRoutes().whenComplete(() {
      routesLoading = false;
      notifyListeners();
    });
    routesModelData.routes.forEach((element) {
      routes.add(element.name.toString());
    });
    return routes;
  }

  void setRoute(String routeName) {
    trip.routeName = routeName;
    notifyListeners();
  }

  void setStartTime(TimeOfDay time) {
    trip.startTime = time;
    notifyListeners();
  }

  void setEndTime(TimeOfDay time) {
    trip.endTime = time;
    notifyListeners();
  }

  void addRoute() {
    busData.trips.add(trip);
    trip = Trip();
    trip.routeName = null;
    trip.startTime = TimeOfDay(hour: 12, minute: 00);
    trip.endTime = TimeOfDay(hour: 12, minute: 00);
    notifyListeners();
  }

  void removeRoute(int index) {
    busData.trips.removeAt(index);
    notifyListeners();
  }

  String checkData() {
    String message = '';
    if(busData.busNo == '' || busData.busNo == null)
      return 'Enter bus number';
    else if(busData.trips.length == 0)
      return 'Please select at least one route';
    return message;
  }

  Future<bool> saveRoutesData() async {
    loading = true;
    notifyListeners();
    return await BusesRepository().save(busData).whenComplete(() {
      loading = false;
      notifyListeners();
    });
  }

}
