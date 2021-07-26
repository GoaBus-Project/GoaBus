import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:goabus_users/common/constants.dart';
import 'package:goabus_users/models/routes_model.dart';
import 'package:goabus_users/models/stops_model.dart';

import 'bus_stops_repository.dart';

class RoutesRepository {
  /// Fetch data
  Future<RoutesModel> fetchRoutes() async {
    RoutesModel routes = RoutesModel(routes: []);
    routes.routes = [];
    BusStopsModel busStopsModel = BusStopsModel(busStops: []);

    /// Fetch bus stops for lat lng
    busStopsModel = await BusStopsRepository().fetchBusStops();

    await FirebaseFirestore.instance
        .collection(Constants.ROUTES_COLLECTION)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        BusRoute busRoute = BusRoute(
            start: BusStop(lat: '', lng: '', stopName: ''),
            end: BusStop(lat: '', lng: '', stopName: ''),
            intermediate: Intermediate(stop: []),
            name: '');

        List<String> intermediateStops =
            doc["intermediate"].toString().isNotEmpty
                ? doc["intermediate"].toString().split(",")
                : [];

        busRoute.name = doc.id.toString();
        busRoute.start.stopName = doc["start"].toString();
        busRoute.end.stopName = doc["end"].toString();

        /// assign lat lng to start and stop route
        busStopsModel.busStops.forEach((busStopData) {
          if (busStopData.stopName == busRoute.start.stopName) {
            busRoute.start.lat = busStopData.lat;
            busRoute.start.lng = busStopData.lng;
          }
          if (busStopData.stopName == busRoute.end.stopName) {
            busRoute.end.lat = busStopData.lat;
            busRoute.end.lng = busStopData.lng;
          }
        });

        if (intermediateStops.isNotEmpty) {
          /// If there are intermediate points add to model class
          /// For each retrieved route
          intermediateStops.forEach((stopName) {
            BusStop busStop = BusStop(
              lng: '',
              lat: '',
              stopName: '',
            );
            busStop.lat = "";
            busStop.lng = "";
            busStop.stopName = stopName.toString();

            /// assign lat lng to intermediate routes
            busStopsModel.busStops.forEach((busStopData) {
              if (busStopData.stopName == stopName.toString()) {
                busStop.lat = busStopData.lat;
                busStop.lng = busStopData.lng;
              }
            });
            busRoute.intermediate.stop.add(busStop);
          });
        }
        routes.routes.add(busRoute);
      });
    });
    return routes;
  }
}
