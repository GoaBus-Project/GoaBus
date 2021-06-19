import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:goa_bus/constants/constants.dart';
import 'package:goa_bus/models/routes_model.dart';
import 'package:goa_bus/models/stops_model.dart';

import 'bus_stops_repository.dart';

class RoutesRepository {
  /// Save data to firestore db
  Future<bool> save(BusRoute routesData) async {
    bool success = false;
    /// Create a DocumentReference called routes that references the firestore collection
    DocumentReference routes =
      FirebaseFirestore.instance
          .collection(Constants.ROUTES_COLLECTION)
          .doc(routesData.name);

    /// Create intermediate comma separated string to upload
    String intermediateStops = '';
    if(routesData.intermediate.stop.isNotEmpty) {
      intermediateStops = routesData.intermediate.stop[0].stopName.toString();
      routesData.intermediate.stop.forEach((element) {
        if(intermediateStops != element.stopName)
          intermediateStops =
              intermediateStops + ',' + element.stopName.toString();
      });
    }

    /// Upload to server
    await routes.set({
      'start': routesData.start.stopName.toString(),
      'intermediate': intermediateStops,
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

  /// Fetch data
  Future<RoutesModel> fetchRoutes() async {
    RoutesModel routes = RoutesModel();
    routes.routes = [];
    BusStopsModel busStopsModel = BusStopsModel();

    /// Fetch bus stops for lat lng
    busStopsModel = await BusStopsRepository().fetchBusStops();

    await FirebaseFirestore.instance
        .collection(Constants.ROUTES_COLLECTION)
        .get()
        .then((QuerySnapshot querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            BusRoute busRoute = BusRoute();
            busRoute.intermediate = Intermediate();
            busRoute.intermediate.stop = [];
            busRoute.start = BusStop();
            busRoute.end = BusStop();

            List<String> intermediateStops =
                doc["intermediate"].toString().split(",")??[];

            busRoute.name = doc.id.toString();
            busRoute.start.stopName = doc["start"].toString();
            busRoute.end.stopName = doc["end"].toString();

            /// For each retrieved route
            intermediateStops.forEach((stopName) {
              BusStop busStop = BusStop();
              busStop.stopName = stopName.toString();
              /// assign lat lng
              busStopsModel.busStops.forEach((busStopData) {
                if(busStopData.stopName == stopName.toString()) {
                  busStop.lat = busStopData.lat;
                  busStop.lng = busStopData.lng;
                }
              });
              busRoute.intermediate.stop.add(busStop);
            });
            routes.routes.add(busRoute);
          });
        });
    return routes;
  }
}