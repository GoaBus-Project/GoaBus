import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:goa_bus/constants/constants.dart';
import 'package:goa_bus/models/routes_model.dart';
import 'package:goa_bus/models/trips_model.dart';

class RoutesRepository {
  /// Save data to firestore db
  Future<bool> saveRoutes(RoutesModel routesData) async {
    bool success = true;
    /// Create a DocumentReference called routes that references the firestore collection
    DocumentReference routes =
      FirebaseFirestore.instance
          .collection(Constants.ROUTES_COLLECTION)
          .doc(routesData.busNo);

    routesData.trips.forEach((element) async {
      await routes.collection(element.route).add({
        'startTime': element.startTime.toString(),
        'endTime': element.endTime.toString(),
      })
          .then((value) => {
            print('Route added'),
          })
          .catchError((error) => {
            print("Failed to add route: $error"),
            success = false,
          });
    });
    print(success);
    return success;
  }

  /// Fetch data
  Future<List<RoutesModel>> fetchRoutes() async {
    List<RoutesModel> routesData = [];
    FirebaseFirestore.instance
        .collection(Constants.ROUTES_COLLECTION)
        .get()
        .then((QuerySnapshot querySnapshot) {
          RoutesModel route = RoutesModel();
          querySnapshot.docs.forEach((doc) {
            route.busNo = doc.toString();
            TripsModel trip = TripsModel();
            trip.route = doc["route"];
            trip.startTime = doc["startTime"] as TimeOfDay;
            trip.endTime = doc["endTime"] as TimeOfDay;
            route.trips.add(trip);
            routesData.add(route);
          });
        });
    return routesData;
  }
}