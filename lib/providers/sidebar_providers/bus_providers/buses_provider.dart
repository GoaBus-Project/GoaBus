import 'package:flutter/material.dart';
import 'package:goa_bus/models/buses_model.dart';
import 'package:goa_bus/repositories/buses_repository.dart';

class BusesProvider with ChangeNotifier {
  BusesModel busesModel = BusesModel();

  bool loading = false;

  init() async {
    busesModel.buses = [];
    loading = true;
    await getData();
  }

  Future<void> getData() async {
    loading = true;
    busesModel = await BusesRepository().fetchBuses()
        .whenComplete(() => loading = false);
    notifyListeners();
  }

  Future<bool> delete(int index) async {
    bool success = false;
    String busNo = busesModel.buses[index].busNo;
    /// Delete from model to update listview
    busesModel.buses.removeAt(index);
    notifyListeners();
    success = await BusesRepository().deleteBus(busNo);
    return success;
  }
}