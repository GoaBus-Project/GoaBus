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
}