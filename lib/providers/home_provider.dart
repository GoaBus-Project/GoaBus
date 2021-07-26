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
  RegExp regExp = new RegExp(
    r"GA\s*[0-9]{2}\s*[A-Z]{1,2}\s*[0-9]{4}",
    caseSensitive: false,
    multiLine: false,
  );

  void get init async {
    busesModel = BusesModel(buses: []);
    routesModel = RoutesModel(routes: []);
    busStopsModel = BusStopsModel(busStops: []);

    busesModel = await BusRepository().fetchBuses();
    routesModel = await RoutesRepository().fetchRoutes();
    busStopsModel = await BusStopsRepository().fetchBusStops();
  }

  Bus search() {
    Bus bus =
        Bus(lat: 0, lng: 0, driver: '', driverEmail: '', busNo: '', trips: []);
    showBusList = true;
    notifyListeners();
    if (regExp.firstMatch(destination) != null)
      bus = busesModel.buses.firstWhere(
          (bus) => bus.busNo.replaceAll('-', ' ').toString() == destination,
          orElse: () => Bus(
              lat: 0,
              lng: 0,
              driver: '',
              driverEmail: '',
              busNo: '',
              trips: []));
    return bus;
  }

  void selectBus() {
    showBusList = false;
    notifyListeners();
  }
}
