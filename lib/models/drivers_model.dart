import 'dart:convert';

import 'package:flutter/cupertino.dart';

DriversModel driversModelFromJson(String str) => DriversModel.fromJson(json.decode(str));

String driversModelToJson(DriversModel data) => json.encode(data.toJson());

class DriversModel {
  DriversModel({
    this.drivers,
  });

  List<Driver> drivers;

  factory DriversModel.fromJson(Map<String, dynamic> json) => DriversModel(
    drivers: List<Driver>.from(json["drivers"].map((x) => Driver.fromJson(x)))??[],
  );

  Map<String, dynamic> toJson() => {
    "drivers": List<dynamic>.from(drivers.map((x) => x.toJson()))??[],
  };
}

class Driver {
  Driver({
    this.image,
    this.name,
    this.contact,
    this.address,
  });

  Image image;
  String name;
  String contact;
  String address;

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
    image: json["image"],
    name: json["name"]??"",
    contact: json["contact"]??"",
    address: json["address"]??"",
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "name": name??"",
    "contact": contact??"",
    "address": address??"",
  };
}
