import 'package:flutter/material.dart';
import 'package:goa_bus/models/buses_model.dart';
import 'package:goa_bus/models/drivers_model.dart';
import 'package:goa_bus/repositories/buses_repository.dart';
import 'package:goa_bus/repositories/drivers_repository.dart';

class DriversProvider with ChangeNotifier {
  DriversModel driversModel = DriversModel();
  BusesModel busesModel = BusesModel();

  bool loading = false;

  void init() async {
    driversModel.drivers = [];
    busesModel.buses = [];
    await getData();
  }

  Bus getBusNo(String name, String contact) {
    return busesModel.buses.firstWhere(
        (buses) => buses.driver == name + " - " + contact,
        orElse: () => Bus(busNo: "No Bus Assigned"));
  }

  Future<void> getData() async {
    loading = true;
    driversModel = await DriversRepository()
        .fetchDrivers()
        .whenComplete(() => loading = false);
    busesModel = await BusesRepository().fetchBuses();
    notifyListeners();
  }

  Future<bool> delete(int index) async {
    String driverID = driversModel.drivers[index].name +
        " - " +
        driversModel.drivers[index].contact;

    /// Delete from model to update listview
    int busIndex = busesModel.buses
        .indexWhere((element) => element.driver.trim() == driverID.trim());
    if (busIndex != -1) busesModel.buses.removeAt(busIndex);
    driversModel.drivers.removeAt(index);
    notifyListeners();

    return await DriversRepository().deleteDriver(driverID);
  }
}
