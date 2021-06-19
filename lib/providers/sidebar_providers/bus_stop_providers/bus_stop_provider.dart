import 'package:flutter/cupertino.dart';
import 'package:goa_bus/models/stops_model.dart';
import 'package:goa_bus/repositories/bus_stops_repository.dart';

class BusStopProvider with ChangeNotifier {
  BusStopsModel busStopsModel = BusStopsModel();

  bool loading = false;

  void init() async {
    busStopsModel.busStops = [];
    await getData();
  }

  Future<void> getData() async {
    loading = true;
    busStopsModel = await BusStopsRepository().fetchBusStops()
        .whenComplete(() => loading = false);
    notifyListeners();
  }
}