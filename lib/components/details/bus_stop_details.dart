import 'dart:async';

import 'package:flutter/material.dart';
import 'package:goa_bus/constants/color_palette.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BusStopDetails extends StatefulWidget {
  @override
  _BusStopDetailsState createState() => _BusStopDetailsState();
}

class _BusStopDetailsState extends State<BusStopDetails> {
  Completer<GoogleMapController> _controller = Completer();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(top: 15, left: 50),
            child: Text(
              "Stop Name",
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Palette.fontColor.withOpacity(0.6)
              ),
            ),
          ),
        ),
        Expanded(
          flex: 7,
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(15.485121538731942, 73.82125134810553),
              zoom: 10.0,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            // markers: Set<Marker>.from(marker),
          ),
        ),
      ],
    );
  }
}
