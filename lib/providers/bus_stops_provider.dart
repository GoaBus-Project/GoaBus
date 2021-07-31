import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:goabus_users/models/stops_model.dart';
import 'package:goabus_users/repositories/bus_stops_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BusStopsProvider with ChangeNotifier {
  LatLng latLng = LatLng(15.401100, 74.011803);
  Set<Marker> markers = {};
  late BusStopsModel busStopsModel = BusStopsModel(busStops: []);

  void get init async => await fetchStops;

  void setLatLng(LatLng _latLng) {
    markers.clear();
    latLng = _latLng;
    notifyListeners();
  }

  double calculateDistance(double lat, double lng) {
    var p = 0.017453292519943295;
    var a = 0.5 - cos((lat - latLng.latitude) * p)/2 +
        cos(latLng.latitude * p) * cos(lat * p) *
            (1 - cos((lng - latLng.longitude) * p))/2;
    return 12742 * asin(sqrt(a));
  }

  Future<void> get fetchStops async =>
    busStopsModel = await BusStopsRepository().fetchBusStops();

  void fetchStopsWithinRadius() {
    busStopsModel.busStops.forEach((stop) {
      if(calculateDistance(double.parse(stop.lat), double.parse(stop.lng)) <= 2) {
        /// Add stops markers
        markers.add(Marker(
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueBlue),
            infoWindow: InfoWindow(title: stop.stopName.toString()),
            markerId: MarkerId(LatLng(double.parse(stop.lat),
                double.parse(stop.lng))
                .toString()),
            position: LatLng(double.parse(stop.lat),
                double.parse(stop.lng))));

      }
    });
  }

}