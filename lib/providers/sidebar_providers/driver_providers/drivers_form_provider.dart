import 'package:flutter/material.dart';
import 'package:goa_bus/models/drivers_model.dart';
import 'package:goa_bus/repositories/drivers_repository.dart';

class DriversFormProvider with ChangeNotifier {
  Driver driver = Driver();

  bool loading = false;

  void init() {
    driver.image = null;
    driver.contact = "";
    driver.name = "";
    driver.address = "";
  }

  void setProfile(Image image) {
    driver.image = image;
    notifyListeners();
  }

  String checkData() {
    String message = "";
    if(driver.name == "" || driver.name == null)
      message = "Please enter drivers name";
    else if(driver.contact == "" || driver.contact == null)
      message = "Please enter drivers contact number";
    else if(driver.address == "" || driver.address == null)
      message = "Please enter drivers address";
    else
      message = "success";
    return message;
  }

  Future<bool> saveDrivers() async {
    loading = true;
    notifyListeners();
    return await DriversRepository().save(driver).whenComplete(() {
      loading = false;
      notifyListeners();
    });
  }
}