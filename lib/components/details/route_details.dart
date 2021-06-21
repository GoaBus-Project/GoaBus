import 'dart:async';

import 'package:flutter/material.dart';
import 'package:goa_bus/constants/color_palette.dart';
import 'package:goa_bus/providers/sidebar_providers/route_providers/routes_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class RouteDetails extends StatefulWidget {
  final int index;

  const RouteDetails({Key key, @required this.index}) : assert(index != null);
  @override
  _RouteDetailsState createState() => _RouteDetailsState();
}

class _RouteDetailsState extends State<RouteDetails> {
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> markers = <Marker>[];

  @override
  void initState() {
    final prov = Provider.of<RoutesProvider>(context, listen: false);
    /// add start point marker
    markers.add(Marker(
        markerId: MarkerId(LatLng(double.parse(prov.routesModel.routes[widget.index].start.lat),
            double.parse(prov.routesModel.routes[widget.index].start.lng)).toString()),
        position: LatLng(double.parse(prov.routesModel.routes[widget.index].start.lat),
            double.parse(prov.routesModel.routes[widget.index].start.lng))
    ));
    /// add intermediate points markers
    prov.routesModel.routes[widget.index].intermediate.stop.forEach((element) {
      markers.add(Marker(
          markerId: MarkerId(
              LatLng(double.parse(element.lat),
              double.parse(element.lng)).toString()),
          position: LatLng(double.parse(element.lat), double.parse(element.lng))
      ));
    });
    /// add end point marker
    markers.add(Marker(
        markerId: MarkerId(LatLng(double.parse(prov.routesModel.routes[widget.index].end.lat),
            double.parse(prov.routesModel.routes[widget.index].end.lng)).toString()),
        position: LatLng(double.parse(prov.routesModel.routes[widget.index].end.lat),
            double.parse(prov.routesModel.routes[widget.index].end.lng))
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RoutesProvider>(
      builder: (context, prov, _) => Column(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(top: 15, left: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    prov.routesModel.routes[widget.index].name,
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
                    double.parse(prov.routesModel.routes[widget.index].start.lat),
                    double.parse(prov.routesModel.routes[widget.index].start.lng)),
                zoom: 10.0,
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: Set<Marker>.from(markers),
            ),
          ),
        ],
      ),
    );
  }
}
