import 'dart:convert';

import 'package:goa_bus/models/stops_model.dart';

RoutesModel routesModelFromJson(String str) => RoutesModel.fromJson(json.decode(str));

String routesModelToJson(RoutesModel data) => json.encode(data.toJson());

class RoutesModel {
  RoutesModel({
    this.routes,
  });

  List<Route> routes;

  factory RoutesModel.fromJson(Map<String, dynamic> json) => RoutesModel(
    routes: List<Route>.from(json["routes"].map((x) => Route.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "routes": List<dynamic>.from(routes.map((x) => x.toJson())),
  };
}

class Route {
  Route({
    this.name,
    this.start,
    this.end,
    this.intermediate,
  });

  String name;
  BusStop start;
  BusStop end;
  List<Intermediate> intermediate;

  factory Route.fromJson(Map<String, dynamic> json) => Route(
    name: json["name"],
    start: json["start"],
    end: json["end"],
    intermediate:
      List<Intermediate>.from(json["intermediate"].map((x) => Intermediate.fromJson(x)))??[],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "start": start,
    "end": end,
    "intermediate": List<dynamic>.from(intermediate.map((x) => x.toJson()))??[],
  };
}

class Intermediate {
  Intermediate({
    this.stop,
  });

  List<BusStop> stop;

  factory Intermediate.fromJson(Map<String, dynamic> json) => Intermediate(
    stop:
      List<BusStop>.from(json["stop"].map((x) => Intermediate.fromJson(x)))??[],
  );

  Map<String, dynamic> toJson() => {
    "stop": List<dynamic>.from(stop.map((x) => x.toJson()))??[],
  };
}
