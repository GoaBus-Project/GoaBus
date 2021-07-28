import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:goabus_users/common/color_palette.dart';
import 'package:goabus_users/models/buses_model.dart';
import 'package:goabus_users/models/routes_model.dart';
import 'package:goabus_users/models/stops_model.dart';
import 'package:goabus_users/repositories/bus_stops_repository.dart';
import 'package:goabus_users/repositories/buses_repository.dart';
import 'package:goabus_users/repositories/login_repository.dart';
import 'package:goabus_users/repositories/routes_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeProvider with ChangeNotifier {
  String source = '', destination = '', finalDestination = '';
  bool loadingMap = false;
  late BusesModel busesModel = BusesModel(buses: []);
  late RoutesModel routesModel = RoutesModel(routes: []);
  late BusStopsModel busStopsModel = BusStopsModel(busStops: []);
  late LatLng destinationBusStop = LatLng(0.0, 0.0);
  List<LatLng> startEndPoints = [];
  final Set<Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  Set<Marker> markers = {};
  String googleAPiKey = "AIzaSyBTtqCB1nD9ow0zcZJBrCiHsG3DF3Jh8yU";

  RegExp regExp = new RegExp(
    r"ga\s*[0-9]{2}\s*[a-z]{0,2}\s*[0-9]{0,4}",
    caseSensitive: false,
    multiLine: false,
  );


  void get init async {
    busesModel = BusesModel(buses: []);
    routesModel = RoutesModel(routes: []);
    busStopsModel = BusStopsModel(busStops: []);
    markers.clear();
    startEndPoints.clear();
    polylines.clear();

    busesModel = await BusRepository().fetchBuses();
    routesModel = await RoutesRepository().fetchRoutes();
    busStopsModel = await BusStopsRepository().fetchBusStops();
  }

  void _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Palette.secondary, points: polylineCoordinates);
    polylines.add(polyline);
    loadingMap = false;
    notifyListeners();
  }

  Future<void> getPolyline() async {
    loadingMap = true;
    notifyListeners();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(startEndPoints[1].latitude, startEndPoints[1].longitude),
      PointLatLng(startEndPoints[0].latitude, startEndPoints[0].longitude),
      travelMode: TravelMode.driving,
      // wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")]
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
    notifyListeners();
  }

  bool routeExists(BusRoute route) {
    bool exists = false;
    exists = route.end.stopName
        .toString()
        .toLowerCase()
        .replaceAll(' ', '')
        .contains(destination.toString().toLowerCase().replaceAll(' ', ''));
    if (exists) {
      destinationBusStop =
          LatLng(double.parse(route.end.lat), double.parse(route.end.lng));
      markers.add(Marker(
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          infoWindow: InfoWindow(
              title: route.end.stopName,
              snippet: destinationBusStop.toString()),
          markerId: MarkerId(destinationBusStop.toString()),
          position: destinationBusStop));
    } else {
      route.intermediate.stop.forEach((stop) {
        exists = stop.stopName.toLowerCase().contains(destination);
        if (exists) {
          destinationBusStop =
              LatLng(double.parse(stop.lat), double.parse(stop.lng));
          markers.add(Marker(
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueGreen),
              infoWindow: InfoWindow(
                  title: stop.stopName, snippet: destinationBusStop.toString()),
              markerId: MarkerId(destinationBusStop.toString()),
              position: destinationBusStop));
        }
      });
    }
    notifyListeners();
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

  bool sourceExists(List<Trip> trips) {
    bool exists = false;

    BusRoute _busRoute = BusRoute(
        start: BusStop(lat: '', lng: '', stopName: ''),
        end: BusStop(lat: '', lng: '', stopName: ''),
        intermediate: Intermediate(stop: []),
        name: '');

    routesModel.routes.forEach((route) {
      trips.forEach((trip) {
        _busRoute = routesModel.routes.firstWhere((routeFromModel) =>
            routeFromModel.name.toString().replaceAll(' ', '').toLowerCase() ==
            trip.routeName.toString().replaceAll(' ', '').toLowerCase());
        if (_busRoute.name != '') {
          exists = _busRoute.start.stopName
              .toString()
              .toLowerCase()
              .contains(source);
          if (!exists) {
            _busRoute.intermediate.stop.forEach((stop) {
              exists = stop.stopName.toLowerCase().contains(source);
            });
          }
        }
      });
    });
    return exists;
  }

  List<Bus> search() {
    loadingMap = true;
    List<Bus> bus = [];
    markers.clear();
    startEndPoints.clear();
    polylines.clear();
    notifyListeners();
    if (regExp.firstMatch(destination) != null) {
      bus.addAll(busesModel.buses.where((bus) => bus.busNo
          .replaceAll('-', '')
          .toLowerCase()
          .toString()
          .contains(destination.toString().toLowerCase().replaceAll(' ', ''))));
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

  List<Bus> searchBySourceAndDestination(List<Bus> foundBuses) {
    List<Bus> buses = [];
    buses.addAll(foundBuses.where((bus) => sourceExists(bus.trips)));
    notifyListeners();
    return buses;
  }

  Future<Bus> fetchBus(Bus bus) async {
    markers.removeWhere((element) => element.markerId == MarkerId(bus.busNo));
    Bus updatedBus = await BusRepository().fetchBusLocation(bus);
    markers.add(Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
        infoWindow: InfoWindow(title: bus.busNo, snippet: bus.driver),
        markerId: MarkerId(bus.busNo),
        position: LatLng(bus.lat, bus.lng)));
    notifyListeners();
    return updatedBus;
  }

  String get getEmail => LoginRepository().getEmail.toString();
}
