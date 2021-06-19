import 'package:flutter/material.dart';
import 'package:goa_bus/constants/color_palette.dart';

class DriverDetails extends StatefulWidget {
  @override
  _DriverDetailsState createState() => _DriverDetailsState();
}

class _DriverDetailsState extends State<DriverDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Driver's image"),
        Padding(
          padding: const EdgeInsets.only(top: 15, left: 50),
          child: Text(
            "Driver Name",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Palette.fontColor.withOpacity(0.6)
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15, left: 50),
          child: Text(
            "Phone Number",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Palette.fontColor.withOpacity(0.6)
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15, left: 50),
          child: Text(
            "Address",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Palette.fontColor.withOpacity(0.6)
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15, left: 50),
          child: Text(
            "Bus Driving",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Palette.fontColor.withOpacity(0.6)
            ),
          ),
        ),
      ],
    );
  }
}
