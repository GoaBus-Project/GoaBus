import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:goabus_users/common/constants.dart';
import 'package:goabus_users/models/buses_model.dart';

class BusRepository {
  /// Fetch data
  Future<BusesModel> fetchBuses() async {
    BusesModel buses = BusesModel(buses: []);
    buses.buses = [];

    await FirebaseFirestore.instance
        .collection(Constants.BUSES_COLLECTION)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Bus bus = Bus(
            busNo: '', lat: 0, lng: 0, driverEmail: '', trips: [], driver: '');
        bus.trips = [];

        bus.busNo = doc.id.toString();
        bus.driver = doc["driver"].toString();

        if (doc["trips"] != "") {
          /// Form trips object
          List<String> tripDataWithTime = doc["trips"].toString().isNotEmpty
              ? doc["trips"].toString().split(",")
              : [];

          tripDataWithTime.forEach((element) {
            Trip trip = Trip(
                startTime: TimeOfDay(hour: 0, minute: 0),
                routeName: '',
                endTime: TimeOfDay(hour: 0, minute: 0));

            /// Separate time and route name
            List<String> tripData =
            element.isNotEmpty ? element.split(";") : [];

            if (tripData.isNotEmpty) {
              trip.routeName = tripData[0].toString();

              /// For start time
              int hour = int.parse(tripData[1].split(":").first);
              int min = int.parse(tripData[1].split(":").last);
              trip.startTime = TimeOfDay(hour: hour, minute: min);

              /// For end time
              hour = int.parse(tripData[2].split(":").first);
              min = int.parse(tripData[2].split(":").last);
              trip.endTime = TimeOfDay(hour: hour, minute: min);
              bus.trips.add(trip);
            }
          });
        }
        buses.buses.add(bus);
      });
    });
    return buses;
  }
}