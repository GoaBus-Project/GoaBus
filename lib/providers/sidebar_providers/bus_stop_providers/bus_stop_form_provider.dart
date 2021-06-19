import 'package:flutter/material.dart';
import 'package:goa_bus/models/stops_model.dart';
import 'package:goa_bus/repositories/bus_stops_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BusStopFormProvider with ChangeNotifier {
  BusStop busStop = BusStop();

  bool loading = false;

  init() {
    busStop.stopName = "";
    busStop.lat = null;
    busStop.lng = null;
  }

  void setLatLng(LatLng latLng) {
    busStop.lat = latLng.latitude.toString();
    busStop.lng = latLng.longitude.toString();
    notifyListeners();
  }

  LatLng getLatLng() {
    return busStop.lat == null || busStop.lng == null ?
        null : LatLng(double.parse(busStop.lat), double.parse(busStop.lng));
  }

  String checkData() {
    String message = '';
    if(busStop.stopName == "")
      message = "Please enter stop name";
    else if(busStop.lat == null
        || busStop.lng == null)
      message = "Please select location";
    else
      message = "success";
    return message;
  }

  Future<bool> saveBusStop() async {
    loading = true;
    notifyListeners();
    return await BusStopsRepository().save(busStop).whenComplete(() {
      loading = false;
      notifyListeners();
    });
  }
}
