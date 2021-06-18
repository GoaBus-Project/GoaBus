import 'dart:convert';

BusStopsModel busStopsModelFromJson(String str) => BusStopsModel.fromJson(json.decode(str));

String busStopsModelToJson(BusStopsModel data) => json.encode(data.toJson());

class BusStopsModel {
  BusStopsModel({
    this.busStops,
  });

  List<BusStop> busStops;

  factory BusStopsModel.fromJson(Map<String, dynamic> json) => BusStopsModel(
    busStops:
    List<BusStop>.from(json["busStops"].map((x) => BusStop.fromJson(x))) ??[],
  );

  Map<String, dynamic> toJson() => {
    "busStops": List<dynamic>.from(busStops.map((x) => x.toJson()))??[],
  };
}

class BusStop {
  BusStop({
    this.stopName,
    this.lat,
    this.lng,
  });

  String stopName;
  String lat;
  String lng;

  factory BusStop.fromJson(Map<String, dynamic> json) => BusStop(
    stopName: json["stopName"],
    lat: json["lat"]??"",
    lng: json["lng"]??"",
  );

  Map<String, dynamic> toJson() => {
    "stopName": stopName,
    "lat": lat??"",
    "lng": lng??"",
  };
}