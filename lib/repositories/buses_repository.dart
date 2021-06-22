import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:goa_bus/constants/constants.dart';
import 'package:goa_bus/models/buses_model.dart';

class BusesRepository {
  Future<bool> save(Bus bus) async {
    bool success = false;

    /// Create a DocumentReference called Buses that references the firestore collection
    DocumentReference routes =
    FirebaseFirestore.instance
        .collection(Constants.BUSES_COLLECTION)
        .doc(bus.busNo);

    /// Create trips string which is comma separated to upload
    String trips = '';
    if(bus.trips.isNotEmpty) {
      /// Add first trip
      trips = bus.trips[0].routeName.toString() + ';'
          + bus.trips[0].startTime.hour.toString()
          + ":" + bus.trips[0].startTime.minute.toString() + ';'
          + bus.trips[0].endTime.hour.toString()
          + ":" + bus.trips[0].endTime.minute.toString();
      // TODO Context to be added
      /*trips = bus.trips[0].routeName.toString() + ';'
          + bus.trips[0].startTime.toString() + ';'
          + bus.trips[0].endTime.toString();*/

      /// Add remaining trips, skipping first trip
      bool firstloop = true;
      bus.trips.forEach((element) {
        if(!firstloop) {
          trips =
              trips + ',' + element.routeName.toString() + ';'
                  + element.startTime.hour.toString()
                  + ":" + element.startTime.minute.toString() + ';'
                  + element.endTime.hour.toString()
                  + ":" + element.endTime.minute.toString();
        } else firstloop = false;
        /*if(trips != element.routeName)
          trips = trips + ',' + element.routeName.toString() + ';'
                  + element.startTime.toString() + ';'
                  + element.endTime.toString();*/
      });
    }

    /// Upload to server
    await routes.set({
      'driver': bus.driver.toString(),
      'trips': trips,
    })
        .whenComplete(() => {
          success = true, 
          print('Bus added'),
        })
        .catchError((error) => {
          print("Failed to save bus: $error"),
        });
    return success;
  }

  /// Fetch data
  Future<BusesModel> fetchBuses() async {
    BusesModel buses = BusesModel();
    buses.buses = [];

    await FirebaseFirestore.instance
        .collection(Constants.BUSES_COLLECTION)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Bus bus = Bus();
        bus.trips = [];

        bus.busNo = doc.id.toString();
        bus.driver = doc["driver"].toString();

        /// Form trips object
        List<String> tripDataWithTime =
            doc["trips"].toString().split(",")??[];

        tripDataWithTime.forEach((element) {
          Trip trip = Trip();
          trip.startTime = null;
          trip.endTime = null;
          trip.routeName = "";

          /// Separate time and route name
          List<String> tripData = element.split(";")??[];

          trip.routeName = tripData[0].toString();
          /*trip.startTime = tripData[1] as TimeOfDay;
          trip.endTime = tripData[2] as TimeOfDay;*/
          int hour = int.parse(tripData[1].split(":").first);
          int min = int.parse(tripData[1].split(":").last);
          trip.startTime = TimeOfDay(hour: hour, minute: min);
          hour = int.parse(tripData[2].split(":").first);
          min = int.parse(tripData[2].split(":").last);
          trip.endTime = TimeOfDay(hour: hour, minute: min);

          bus.trips.add(trip);
        });
        buses.buses.add(bus);
      });
    });
    return buses;
  }

  /// Delete bus
  Future<bool> deleteBus(String busNumber) async {
    bool success = false;
    /// Delete driver data from drivers collection
    await FirebaseFirestore.instance
        .collection(Constants.BUSES_COLLECTION)
        .doc(busNumber)
        .delete()
        .whenComplete(() => success = true)
        .onError((error, stackTrace) => print(error));
    return success;
  }

  /// Delete trip
  Future<bool> deleteTrip(Bus bus) async {
    bool success = false;
    String updatedTrips = '';
    /// Delete trip data from drivers collection
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

    await FirebaseFirestore.instance
        .collection(Constants.BUSES_COLLECTION)
        .doc(bus.busNo)
        .update({"trips": updatedTrips})
        .whenComplete(() => success = true)
        .onError((error, stackTrace) {
      success = false;
      print(error);
    });
    return success;
  }
}