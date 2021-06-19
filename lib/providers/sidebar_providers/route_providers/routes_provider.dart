import 'package:flutter/material.dart';
import 'package:goa_bus/models/routes_model.dart';
import 'package:goa_bus/repositories/routes_repository.dart';

class RoutesProvider with ChangeNotifier {
  RoutesModel routesModel = RoutesModel();

  bool loading = false;

  init() async {
    routesModel.routes = [];
    loading = true;
    await getData();
  }

  Future<void> getData() async {
    loading = true;
    routesModel = await RoutesRepository().fetchRoutes().whenComplete(()
      => loading = false);
    notifyListeners();
  }
}