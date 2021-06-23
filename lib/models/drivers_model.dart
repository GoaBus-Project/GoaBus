import 'dart:convert';
import 'dart:typed_data';

DriversModel driversModelFromJson(String str) =>
    DriversModel.fromJson(json.decode(str));

String driversModelToJson(DriversModel data) => json.encode(data.toJson());

class DriversModel {
  DriversModel({
    this.drivers,
  });

  List<Driver> drivers;

  factory DriversModel.fromJson(Map<String, dynamic> json) => DriversModel(
        drivers:
            List<Driver>.from(json["drivers"].map((x) => Driver.fromJson(x))) ??
                [],
      );

  Map<String, dynamic> toJson() => {
        "drivers": List<dynamic>.from(drivers.map((x) => x.toJson())) ?? [],
      };
}

class Driver {
  Driver({
    this.image,
    this.imagePath,
    this.name,
    this.contact,
    this.address,
  });

  Uint8List image;
  String imagePath;
  String name;
  String contact;
  String address;

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        image: json["image"],
        imagePath: json["imagePath"] ?? "",
        name: json["name"] ?? "",
        contact: json["contact"] ?? "",
        address: json["address"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "imagePath": imagePath ?? "",
        "name": name ?? "",
        "contact": contact ?? "",
        "address": address ?? "",
      };
}
