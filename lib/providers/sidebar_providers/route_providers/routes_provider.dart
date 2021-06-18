import 'package:flutter/material.dart';
import 'package:goa_bus/models/routes_model.dart';
import 'package:goa_bus/repositories/routes_repository.dart';

class RoutesProvider with ChangeNotifier {
  RoutesModel routesModel = RoutesModel();

  bool loading = false;

  Future<void> fetchRoutes() async {
    loading = true;
    routesModel = await RoutesRepository().fetchRoutes().whenComplete(() {
      loading = false;
      notifyListeners();
    });
  }
}