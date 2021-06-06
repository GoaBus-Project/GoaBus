import 'dart:async';

import 'package:flutter/material.dart';
import 'package:goa_bus/constants/color_palette.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smooth_scroll_web/smooth_scroll_web.dart';

class StopForm extends StatefulWidget {
  @override
  _StopFormState createState() => _StopFormState();
}

class _StopFormState extends State<StopForm> {
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> marker=[];
  LatLng markedPoint;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 450,
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(15.485121538731942, 73.82125134810553),
              zoom: 10.0,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              },
            markers: Set.from(marker),
            onTap: (LatLng tappedPoint){
              setState(() {
                marker=[];
                marker.add(Marker(
                  markerId: MarkerId(tappedPoint.toString()),
                  position: tappedPoint
                ));
                markedPoint=tappedPoint;
              });
            },
          ),
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Container(
              width: 400,
              child: TextFormField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Stop Name",
                ),
                onChanged: (number) {
                },
              ),
            ),
            SizedBox(width: 30),
            markedPoint==null?Text("Select a Bus Stop from the map",style: TextStyle(fontSize: 20))
                :Text(markedPoint.toString(), style: TextStyle(fontSize: 20),)
          ],
        ),
        SizedBox(height: 50),
        ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Palette.secondary),
            ),
            onPressed: (){},
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
