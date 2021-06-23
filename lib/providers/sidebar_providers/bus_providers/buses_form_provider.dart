import 'package:flutter/material.dart';
import 'package:goa_bus/models/buses_model.dart';
import 'package:goa_bus/models/drivers_model.dart';
import 'package:goa_bus/models/routes_model.dart';
import 'package:goa_bus/repositories/buses_repository.dart';
import 'package:goa_bus/repositories/drivers_repository.dart';
import 'package:goa_bus/repositories/routes_repository.dart';

class BusesFormProvider with ChangeNotifier {
  Bus busData = Bus();

  Trip trip = Trip();

  RoutesModel routesModelData = RoutesModel();

  DriversModel _driversModel = DriversModel();

  bool loading = false, routesLoading = false, driversLoading = false;

  List<String> routes = [];


  void init() async {
    busData.trips = <Trip>[];
    routes = [];
    busData.busNo = null;
    busData.driver = null;
    trip.routeName = null;
    trip.startTime = TimeOfDay(hour: 12, minute: 00);
    trip.endTime = TimeOfDay(hour: 12, minute: 00);
    driversLoading = true;
    await getRoutes();
    _driversModel = await DriversRepository().fetchDrivers()
        .whenComplete(() {
          driversLoading = false;
          notifyListeners();
        });
  }

  List<String> getDrivers() {
    List<String> drivers = [];
    _driversModel.drivers.forEach((element) {
      drivers.add(element.name + " - " + element.contact);
    });
    return drivers;
  }

  Future<void> getRoutes() async {
    routesLoading = true;
    routesModelData = await RoutesRepository().fetchRoutes().whenComplete(() {
      routesLoading = false;
    });
    routesModelData.routes.forEach((element) {
      routes.add(element.name.toString());
    });
    notifyListeners();
  }

  void setRoute(String routeName) {
    trip.routeName = routeName;
    notifyListeners();
  }

  void setDriver(String driverName) {
    busData.driver = driverName;
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
      message = 'Enter bus number';
    else if(busData.driver == '' || busData.driver == null)
      message = 'Please select driver';
    else if(busData.trips.length == 0)
      message = 'Please select at least one route';
    else
      message = 'success';
    return message;
  }

  Future<bool> saveBusesData() async {
    loading = true;
    notifyListeners();
    return await BusesRepository().save(busData).whenComplete(() {
      loading = false;
      notifyListeners();
    });
  }

}