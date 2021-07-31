import 'dart:async';

import 'package:flutter/material.dart';
import 'package:goabus_users/common/color_palette.dart';
import 'package:goabus_users/providers/bus_stops_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class BusStopsScreen extends StatefulWidget {
  const BusStopsScreen({Key? key}) : super(key: key);

  @override
  _BusStopsScreenState createState() => _BusStopsScreenState();
}

class _BusStopsScreenState extends State<BusStopsScreen> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    Provider.of<BusStopsProvider>(context, listen: false).init;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BusStopsProvider>(
      builder: (context, prov, _) {
        Set<Circle> circles = Set.from([Circle(
          strokeColor: Palette.primary,
          fillColor: Palette.primary,
          strokeWidth: 2,
          circleId: CircleId(prov.latLng.toString()),
          center: prov.latLng,
          radius: 2000,
        )]);

        return Container(
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(15.401100, 74.011803),
              zoom: 13.0,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            onCameraMove: (cameraPosition) {
              prov.setLatLng(cameraPosition.target);
              prov.fetchStopsWithinRadius();
            },
            markers: prov.markers,
            myLocationEnabled: true,
            tiltGesturesEnabled: true,
            compassEnabled: true,
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            circles: circles,
          ),
        );
      },
    );
  }
}
