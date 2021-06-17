import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:goa_bus/constants/constants.dart';
import 'package:goa_bus/models/routes_model.dart';

class RoutesRepository {
  /// Save data to firestore db
  Future<bool> saveRoutes(BusRoute routesData) async {
    bool success = false;
    /// Create a DocumentReference called routes that references the firestore collection
    DocumentReference routes =
      FirebaseFirestore.instance
          .collection(Constants.ROUTES_COLLECTION)
          .doc(routesData.name);

    CollectionReference intermediateStops =
      FirebaseFirestore.instance
          .collection(Constants.INTERMEDIATE_STOPS_COLLECTION);

    await routes.set({
      'start': routesData.start.stopName.toString(),
      // 'intermediate': routesData.intermediate.stop
      /*routesData.intermediate.stop.forEach((element) {
        intermediateStops.doc(element.stopName).set({
          "lat": element.lat,
          "lng": element.lng,
        });
      }),*/
      'end': routesData.end.stopName.toString(),
    })
        .whenComplete(() => {
          success = true,
          print('Route added'),
        })
        .catchError((error) => {
          print("Failed to add route: $error"),
        });
    return success;
  }

  /*/// Fetch data
  Future<List<RoutesModel>> fetchRoutes() async {
    List<RoutesModel> routesData = [];
    FirebaseFirestore.instance
        .collection(Constants.ROUTES_COLLECTION)
        .get()
        .then((QuerySnapshot querySnapshot) {
          RoutesModel route = RoutesModel();
          querySnapshot.docs.forEach((doc) {
            route.busNo = doc.toString();;
            trip.route = doc["route"];
            trip.startTime = doc["startTime"] as TimeOfDay;
            trip.endTime = doc["endTime"] as TimeOfDay;
            route.trips.add(trip);
            routesData.add(route);
          });
        });
    return routesData;
  }*/
}