import 'package:flutter/material.dart';
import 'package:goa_bus/constants/color_palette.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomForm extends StatefulWidget {
  @override
  _CustomFormState createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 15),
        TextFormField(
          decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter Bus Number'
          ),
        ),
        SizedBox(height: 15),
        TextFormField(
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Select Start and End Stops',
          ),
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 350.0,
              width: 550.0,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target:LatLng(15.496777,73.827827),
                  zoom: 12,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 30),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Palette.secondary),
          ),
          onPressed: (){
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
            child: Text(
              "Save".toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Palette.fontColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
