import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:goa_bus/constants/constants.dart';
import 'package:goa_bus/models/stops_model.dart';

class BusStopsRepository {
  /// Save data to firestore db
  Future<bool> save(BusStop busStop) async {
    bool success = false;
    /// Create a CollectionReference called 'Bus Stops' that references the firestore collection
    CollectionReference busStops =
    FirebaseFirestore.instance
        .collection(Constants.BUS_STOPS_COLLECTION);

    await busStops.doc(busStop.stopName).set({
      'lat': busStop.lat.toString(),
      'lng': busStop.lng.toString(),
    })
        .whenComplete(() {
          print("Stop added");
          success = true;
        })
        .onError((error, stackTrace) {
          print("Failed to add stop: $error");
        });
    return success;
  }

  /// Get data from firestore db
  Future<BusStopsModel> fetchBusStops() async {
    BusStopsModel busStops = BusStopsModel();
    busStops.busStops = [];

    await FirebaseFirestore.instance
        .collection(Constants.BUS_STOPS_COLLECTION)
        .get()
        .then((QuerySnapshot querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            BusStop busStop = BusStop();
            busStop.stopName = doc.id.toString();
            busStop.lat = doc["lat"].toString();
            busStop.lng = doc["lng"].toString();
            busStops.busStops.add(busStop);
          });
        });
    return busStops;
  }

}