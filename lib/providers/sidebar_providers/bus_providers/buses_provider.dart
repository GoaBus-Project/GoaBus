import 'package:flutter/material.dart';
import 'package:goa_bus/models/buses_model.dart';
import 'package:goa_bus/repositories/buses_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BusesProvider with ChangeNotifier {
  BusesModel busesModel = BusesModel();

  Set<Marker> markers = {};

  bool loading = false;

  init() async {
    busesModel.buses = [];
    loading = true;
    await getData();
  }

  Future<void> fetchLocation(int index) async {
    busesModel.buses[index] =
        await BusesRepository().fetchBusLocation(busesModel.buses[index]);
    markers.clear();
    markers.add(Marker(
        infoWindow: InfoWindow(
            title: busesModel.buses[index].busNo,
            snippet: busesModel.buses[index].driver),
        markerId: MarkerId(busesModel.buses[index].busNo),
        position: LatLng(busesModel.buses[index].lat,
            busesModel.buses[index].lng)));
    loading = false;
    notifyListeners();
  }

  Future<void> getData() async {
    loading = true;
    busesModel = await BusesRepository()
        .fetchBuses()
        .whenComplete(() => loading = false);
    notifyListeners();
  }

  Future<bool> deleteBus(int index) async {
    String busNo = busesModel.buses[index].busNo;

    /// Delete from model to update listview
    busesModel.buses.removeAt(index);
    notifyListeners();
    return await BusesRepository().deleteBus(busNo);
  }

  Future<bool> deleteTrip(int busIndex, int tripIndex) async {
    /// Delete from model to update listview
    busesModel.buses[busIndex].trips.removeAt(tripIndex);
    notifyListeners();
    return await BusesRepository().deleteTrip(busesModel.buses[busIndex]);
  }
}
