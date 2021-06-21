import 'dart:async';

import 'package:flutter/material.dart';
import 'package:goa_bus/constants/color_palette.dart';
import 'package:goa_bus/providers/sidebar_providers/bus_stop_providers/bus_stop_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class BusStopDetails extends StatefulWidget {
  final int index;

  const BusStopDetails({Key key, @required this.index}) : assert(index != null);
  @override
  _BusStopDetailsState createState() => _BusStopDetailsState();
}

class _BusStopDetailsState extends State<BusStopDetails> {
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> markers = <Marker>[];

  @override
  void initState() {
    final prov = Provider.of<BusStopProvider>(context, listen: false);
    markers.add(Marker(
        markerId: MarkerId(LatLng(double.parse(prov.busStopsModel.busStops[widget.index].lat),
            double.parse(prov.busStopsModel.busStops[widget.index].lng)).toString()),
        position: LatLng(double.parse(prov.busStopsModel.busStops[widget.index].lat),
            double.parse(prov.busStopsModel.busStops[widget.index].lng))
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BusStopProvider>(
      builder: (context, prov, _) =>
          Column(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, left: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        prov.busStopsModel.busStops[widget.index].stopName,
                        style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Palette.fontColor.withOpacity(0.6)
                        ),
                      ),
                      Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: IconButton(
                                tooltip: "Delete",
                                iconSize: 30,
                                icon: Icon(Icons.delete),
                                onPressed: (){
                                }
                            ),
                          )
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                        double.parse(prov.busStopsModel.busStops[widget.index].lat),
                        double.parse(prov.busStopsModel.busStops[widget.index].lng)),
                    zoom: 10.0,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  markers: Set<Marker>.from(markers),
                ),
              ),
            ],
          )
    );
  }
}
