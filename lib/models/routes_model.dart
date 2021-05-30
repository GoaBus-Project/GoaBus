import 'dart:convert';
import 'package:goa_bus/models/trips_model.dart';

RoutesModel routesModelFromJson(String str) => RoutesModel.fromJson(json.decode(str));

String routesModelToJson(RoutesModel data) => json.encode(data.toJson());

class RoutesModel {
  RoutesModel({
    this.busNo,
    this.trips,
  });

  String busNo;
  List<TripsModel> trips;

  factory RoutesModel.fromJson(Map<String, dynamic> json) => RoutesModel(
    busNo: json["busNo"]??'',
    trips: json["trips"]??[],
  );

  Map<String, dynamic> toJson() => {
    "busNo": busNo??'',
    "trips": trips??[],
  };
}

