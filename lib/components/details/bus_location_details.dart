import 'dart:async';

import 'package:flutter/material.dart';
import 'package:goa_bus/constants/color_palette.dart';
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
    final prov = Provider.of<BusesProvider>(context, listen: false);
    prov.loading = true;
    prov.fetchLocation(widget.index);
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
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          timer = Timer.periodic(Duration(seconds: 3), (Timer t) {
            prov.fetchLocation(widget.index);
            print(prov.busesModel.buses[widget.index].lat);
            print(prov.busesModel.buses[widget.index].lng);
          });
        });
        return prov.loading
            ? Center(
                child: CircularProgressIndicator(
                color: Palette.secondary,
              ))
            : Container(
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(prov.busesModel.buses[widget.index].lat,
                        prov.busesModel.buses[widget.index].lng),
                    zoom: 16.0,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  markers: prov.markers,
                ),
              );
      },
    );
  }
}
