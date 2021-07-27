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
    r"ga\s*[0-9]{2}\s*[a-z]{0,2}\s*[0-9]{0,4}",
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

  bool routeExists(BusRoute route) {
    bool exists = false;
    exists = route.end.stopName.toString().toLowerCase().contains(destination);

    if (!exists) {
      route.intermediate.stop.forEach((stop) {
        exists = stop.stopName.toLowerCase().contains(destination);
      });
    }
    return exists;
  }

  bool busExists(List<Trip> trips, List<String> routes) {
    bool exists = false;
    trips.forEach((trip) {
      exists = routes.contains(
          trip.routeName.toString().toLowerCase().replaceAll(' ', ''));
    });
    return exists;
  }

  List<Bus> search() {
    List<Bus> bus = [];
    showBusList = true;
    if (regExp.firstMatch(destination) != null) {
      bus.addAll(busesModel.buses.where((bus) => bus.busNo
          .replaceAll('-', ' ')
          .toLowerCase()
          .toString()
          .contains(destination)));
    } else {
      List<String> _routes = <String>[];
      routesModel.routes.forEach((route) {
        if (routeExists(route)) _routes.add(route.name.toLowerCase());
      });
      bus.addAll(
          busesModel.buses.where((bus) => busExists(bus.trips, _routes)));

    }
    notifyListeners();
    return bus;
  }

  void selectBus() {
    showBusList = false;
    notifyListeners();
  }
}
