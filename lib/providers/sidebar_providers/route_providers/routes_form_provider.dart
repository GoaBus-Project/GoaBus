import 'package:flutter/material.dart';
import 'package:goa_bus/models/routes_model.dart';
import 'package:goa_bus/models/stops_model.dart';
import 'package:goa_bus/repositories/bus_stops_repository.dart';
import 'package:goa_bus/repositories/routes_repository.dart';

class RoutesFormProvider with ChangeNotifier {
  BusRoute route = BusRoute();

  BusStopsModel busStopsModel = BusStopsModel();

  List<String> busStops = [];

  String selectedIntermediateStop;

  bool loading = false;

  init() {
    busStops = [];
    route.name = "";
    route.start = BusStop();
    route.intermediate = Intermediate();
    route.intermediate.stop = [];
    route.end = BusStop();
  }

  Future<void> getStops() async {
    busStopsModel = await BusStopsRepository().fetchBusStops();
    busStopsModel.busStops.forEach((element) {
      busStops.add(element.stopName);
    });
    notifyListeners();
  }

  void setStartStop(String startStop) {
    route.start = busStopsModel.busStops.firstWhere((element) =>
      element.stopName == startStop);
    notifyListeners();
  }

  void setIntermediateStop(String intermediateStop) {
    selectedIntermediateStop = intermediateStop;
    notifyListeners();
  }

  void addIntermediateStop() {
    route.intermediate.stop.add(busStopsModel.busStops.firstWhere((element) =>
      element.stopName == selectedIntermediateStop));
    selectedIntermediateStop = null;
    notifyListeners();
  }

  void removeIntermediateStop(int index) {
    route.intermediate.stop.removeAt(index);
    notifyListeners();
  }

  void setEndStop(String endStop) {
    route.end = busStopsModel.busStops.firstWhere((element) =>
    element.stopName == endStop);
    notifyListeners();
  }

  String checkData() {
    String message = "";
    if(route.name == "") {
      message = "Please enter route name";
    } else if(route.start == null || route.end == null) {
      message = "Please select start/end stop";
    } else {
      message = "success";
    }
    return message;
  }

  Future<bool> saveRoutesData() async {
    loading = true;
    notifyListeners();
    return await RoutesRepository().saveRoutes(route).whenComplete(() {
      loading = false;
      notifyListeners();
    });
  }

}
