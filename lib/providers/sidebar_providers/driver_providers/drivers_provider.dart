import 'package:flutter/material.dart';
import 'package:goa_bus/models/drivers_model.dart';
import 'package:goa_bus/repositories/drivers_repository.dart';

class DriversProvider with ChangeNotifier {
  DriversModel driversModel = DriversModel();

  bool loading = false;

  void init() async {
    driversModel.drivers = [];
    await getData();
  }

  Future<void> getData() async {
    loading = true;
    driversModel = await DriversRepository().fetchDrivers()
        .whenComplete(() => loading = false);
    notifyListeners();
  }
}
