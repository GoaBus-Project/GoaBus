import 'dart:convert';

import 'package:goa_bus/models/stops_model.dart';

RoutesModel routesModelFromJson(String str) =>
    RoutesModel.fromJson(json.decode(str));

String routesModelToJson(RoutesModel data) => json.encode(data.toJson());

class RoutesModel {
  RoutesModel({
    this.routes,
  });

  List<BusRoute> routes;

  factory RoutesModel.fromJson(Map<String, dynamic> json) => RoutesModel(
        routes: List<BusRoute>.from(
            json["routes"].map((x) => BusRoute.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "routes": List<dynamic>.from(routes.map((x) => x.toJson())),
      };
}

class BusRoute {
  BusRoute({
    this.name,
    this.start,
    this.end,
    this.intermediate,
  });

  String name;
  BusStop start;
  BusStop end;
  Intermediate intermediate;

  factory BusRoute.fromJson(Map<String, dynamic> json) => BusRoute(
        name: json["name"],
        start: json["start"],
        end: json["end"],
        intermediate: json["intermediate"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "start": start,
        "end": end,
        "intermediate": intermediate,
      };
}

class Intermediate {
  Intermediate({
    this.stop,
  });

  List<BusStop> stop;

  factory Intermediate.fromJson(Map<String, dynamic> json) => Intermediate(
        stop: List<BusStop>.from(
                json["stop"].map((x) => Intermediate.fromJson(x))) ??
            [],
      );

  Map<String, dynamic> toJson() => {
        "stop": List<dynamic>.from(stop.map((x) => x.toJson())) ?? [],
      };
}
