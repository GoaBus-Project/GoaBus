import 'package:flutter/material.dart';

class TripsModel {
  TripsModel({
    this.route,
    this.startTime,
    this.endTime,
  });

  String route;
  TimeOfDay startTime;
  TimeOfDay endTime;

  factory TripsModel.fromJson(Map<String, dynamic> json) => TripsModel(
    route: json["route"]??"",
    startTime: json["startTime"]??null,
    endTime: json["endTime"]??null,
  );

  Map<String, dynamic> toJson() => {
    "route": route,
    "startTime": startTime,
    "endTime": endTime,
  };
}