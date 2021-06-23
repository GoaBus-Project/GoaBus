import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:goa_bus/constants/constants.dart';
import 'package:goa_bus/models/buses_model.dart';
import 'package:goa_bus/models/routes_model.dart';
import 'package:goa_bus/models/stops_model.dart';

import 'bus_stops_repository.dart';
import 'buses_repository.dart';

class RoutesRepository {
  /// Save data to firestore db
  Future<bool> save(BusRoute routesData) async {
    bool success = false;
    /// Create a DocumentReference called Routes that references the firestore collection
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
            busRoute.intermediate.stop = [];
            busRoute.start = BusStop();
            busRoute.end = BusStop();

            List<String> intermediateStops =
                doc["intermediate"].toString().split(",")??[];

            busRoute.name = doc.id.toString();
            busRoute.start.stopName = doc["start"].toString();
            busRoute.end.stopName = doc["end"].toString();

            /// assign lat lng to start and stop route
            busStopsModel.busStops.forEach((busStopData) {
              if(busStopData.stopName == busRoute.start.stopName) {
                busRoute.start.lat = busStopData.lat;
                busRoute.start.lng = busStopData.lng;
              }
              if(busStopData.stopName == busRoute.end.stopName) {
                busRoute.end.lat = busStopData.lat;
                busRoute.end.lng = busStopData.lng;
              }
            });

        if(intermediateStops.isNotEmpty) {
              /// If there are intermediate points add to model class
              /// For each retrieved route
              intermediateStops.forEach((stopName) {
                BusStop busStop = BusStop();
                busStop.lat = "";
                busStop.lng = "";
                busStop.stopName = stopName.toString();
                /// assign lat lng to intermediate routes
                busStopsModel.busStops.forEach((busStopData) {
                  if(busStopData.stopName == stopName.toString()) {
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

  /// Delete route
  Future<bool> deleteRoute(String routeName) async {
    BusesModel busesModel = BusesModel();
    List<String> busNumbers = <String>[];
    bool success = false;
    String updatedTrips = '';

    /// Delete from buses
    busesModel = await BusesRepository().fetchBuses();
    /// Get bus numbers which contains the route
    busesModel.buses.forEach((buses) {
      buses.trips.forEach((trips) {
        if(trips.routeName.trim() == routeName) {
          busNumbers.add(buses.busNo.toString());
        }
      });
    });
    /// Delete route from trip
    busesModel.buses.forEach((element) {
      element.trips.removeWhere((element) => element.routeName == routeName);
    });

    ///Form new Trips string to upload
    /// Create trips string which is comma separated to upload
    busesModel.buses.forEach((bus) {
      if (bus.trips.isNotEmpty) {
        /// Add first trip
        updatedTrips = bus.trips[0].routeName.toString() + ';'
            + bus.trips[0].startTime.hour.toString()
            + ":" + bus.trips[0].startTime.minute.toString() + ';'
            + bus.trips[0].endTime.hour.toString()
            + ":" + bus.trips[0].endTime.minute.toString();

        /// Add remaining trips, skipping first trip
        bool firstloop = true;
        bus.trips.forEach((element) {
          if (!firstloop) {
            updatedTrips = updatedTrips + ',' + element.routeName.toString() + ';'
                + element.startTime.hour.toString()
                + ":" + element.startTime.minute.toString() + ';'
                + element.endTime.hour.toString()
                + ":" + element.endTime.minute.toString();
          } else firstloop = false;
        });
      }
    });

    busNumbers.forEach((element) {
      print(element);
    });

    if(busNumbers.isNotEmpty) {
      busNumbers.forEach((bus) async {
        await FirebaseFirestore.instance
            .collection(Constants.BUSES_COLLECTION)
            .doc(bus)
            .update({"trips": updatedTrips})
            .whenComplete(() => success = true)
            .onError((error, stackTrace) {
          success = false;
          print(error);
        });
      });
    }

    /// Delete route data from Routes collection
    await FirebaseFirestore.instance
        .collection(Constants.ROUTES_COLLECTION)
        .doc(routeName)
        .delete()
        .whenComplete(() => success = true)
        .onError((error, stackTrace) => print(error));
    return success;
  }
}