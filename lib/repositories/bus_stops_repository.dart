import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:goabus_users/common/constants.dart';
import 'package:goabus_users/models/stops_model.dart';

class BusStopsRepository {
  /// Get data from firestore db
  Future<BusStopsModel> fetchBusStops() async {
    BusStopsModel busStops = BusStopsModel(busStops: []);
    busStops.busStops = [];

    await FirebaseFirestore.instance
        .collection(Constants.BUS_STOPS_COLLECTION)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        BusStop busStop = BusStop(lat: '', lng: '', stopName: '');
        busStop.stopName = doc.id.toString();
        busStop.lat = doc["lat"].toString();
        busStop.lng = doc["lng"].toString();
        busStops.busStops.add(busStop);
      });
    });
    return busStops;
  }
}