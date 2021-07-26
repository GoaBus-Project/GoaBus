import 'package:flutter/material.dart';
import 'package:goabus_users/models/buses_model.dart';
import 'package:goabus_users/models/routes_model.dart';
import 'package:goabus_users/models/stops_model.dart';
import 'package:goabus_users/repositories/bus_stops_repository.dart';
import 'package:goabus_users/repositories/buses_repository.dart';
import 'package:goabus_users/repositories/routes_repository.dart';

class HomeProvider with ChangeNotifier {
  String source = '', destination = '';
  bool showBusList = false;
  late BusesModel busesModel = BusesModel(buses: []);
  late RoutesModel routesModel = RoutesModel(routes: []);
  late BusStopsModel busStopsModel = BusStopsModel(busStops: []);

  void get init async {
    busesModel = BusesModel(buses: []);
    routesModel = RoutesModel(routes: []);
    busStopsModel = BusStopsModel(busStops: []);

    busesModel = await BusRepository().fetchBuses();
    routesModel = await RoutesRepository().fetchRoutes();
    busStopsModel = await BusStopsRepository().fetchBusStops();
  }

  void enableDisableBusList() {
    showBusList = true;
    notifyListeners();
  }
}
