import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BusLocationDetails extends StatefulWidget {
  final int index;

  const BusLocationDetails({Key key, @required this.index}) : assert(index != null);
  @override
  _BusLocationDetailsState createState() => _BusLocationDetailsState();
}

class _BusLocationDetailsState extends State<BusLocationDetails> {
  Completer<GoogleMapController> _controller = Completer();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(15.401100,74.011803),
          zoom: 10.0,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        // markers: Set<Marker>.from(),
      ),
    );
  }
}
