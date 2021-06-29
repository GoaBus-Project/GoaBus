import 'dart:convert';

import 'package:flutter/material.dart';

BusesModel busesModelFromJson(String str) =>
    BusesModel.fromJson(json.decode(str));

String busesModelToJson(BusesModel data) => json.encode(data.toJson());

class BusesModel {
  BusesModel({
    this.buses,
  });

  List<Bus> buses;

  factory BusesModel.fromJson(Map<String, dynamic> json) => BusesModel(
        buses: List<Bus>.from(json["buses"].map((x) => Bus.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "buses": List<dynamic>.from(buses.map((x) => x.toJson())),
      };
}

class Bus {
  Bus({
    this.lat,
    this.lng,
    this.driver,
    this.driverEmail,
    this.busNo,
    this.trips,
  });

  double lat;
  double lng;
  String driver;
  String driverEmail;
  String busNo;
  List<Trip> trips;

  factory Bus.fromJson(Map<String, dynamic> json) => Bus(
        /// set default location to panjim
        lat: json["lat"],
        lng: json["lng"],
        driver: json["driver"] ?? "",
        driverEmail: json["driverEmail"] ?? "",
        busNo: json["busNo"] ?? "",
        trips:
            List<Trip>.from(json["trips"].map((x) => Trip.fromJson(x))) ?? [],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
        "driver": driver ?? "",
        "driverEmail": driverEmail ?? "",
        "busNo": busNo ?? "",
        "trips": List<dynamic>.from(trips.map((x) => x.toJson())) ?? [],
      };
}

class Trip {
  Trip({
    this.routeName,
    this.startTime,
    this.endTime,
  });

  String routeName;
  TimeOfDay startTime;
  TimeOfDay endTime;

  factory Trip.fromJson(Map<String, dynamic> json) => Trip(
        routeName: json["routeName"] ?? "",
        startTime: json["startTime"],
        endTime: json["endTime"],
      );

  Map<String, dynamic> toJson() => {
        "routeName": routeName ?? "",
        "startTime": startTime,
        "endTime": endTime,
      };
}
