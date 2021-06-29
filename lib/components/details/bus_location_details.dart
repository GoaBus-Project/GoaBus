import 'dart:async';

import 'package:flutter/material.dart';
import 'package:goa_bus/providers/sidebar_providers/bus_providers/buses_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class BusLocationDetails extends StatefulWidget {
  final int index;

  const BusLocationDetails({Key key, @required this.index})
      : assert(index != null);

  @override
  _BusLocationDetailsState createState() => _BusLocationDetailsState();
}

class _BusLocationDetailsState extends State<BusLocationDetails> {
  Completer<GoogleMapController> _controller = Completer();
  Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
        Duration(seconds: 5),
        (Timer t) => Provider.of<BusesProvider>(context, listen: false)
            .fetchLocation(widget.index));
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BusesProvider>(
      builder: (context, prov, _) {
        print(prov.busesModel.buses[widget.index]?.lat);
        print(prov.busesModel.buses[widget.index]?.lng);
        prov.markers.clear();
        prov.markers.add(Marker(
            markerId: MarkerId(prov.busesModel.buses[widget.index].busNo),
            position: LatLng(prov.busesModel.buses[widget.index]?.lat ?? 15.496777,
                prov.busesModel.buses[widget.index]?.lng ?? 73.827827)));
        return Container(
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(15.401100, 74.011803),
              zoom: 10.0,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: Set<Marker>.from(prov.markers),
          ),
        );
      },
    );
  }
}
