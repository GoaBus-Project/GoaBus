import 'dart:async';

import 'package:flutter/material.dart';
import 'package:goa_bus/common/alert_dialog_screen.dart';
import 'package:goa_bus/constants/color_palette.dart';
import 'package:goa_bus/providers/sidebar_providers/bus_stop_providers/bus_stop_form_provider.dart';
import 'package:goa_bus/providers/sidebar_providers/bus_stop_providers/bus_stop_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class StopForm extends StatefulWidget {
  @override
  _StopFormState createState() => _StopFormState();
}

class _StopFormState extends State<StopForm> {
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> marker = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<BusStopFormProvider>(
      builder: (BuildContext context, prov, _) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 5,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(15.485121538731942, 73.82125134810553),
                  zoom: 10.0,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                markers: Set<Marker>.from(marker),
                onTap: (LatLng tappedPoint) {
                  marker = [];
                  prov.setLatLng(tappedPoint);
                  marker.add(Marker(
                      markerId: MarkerId(prov.getLatLng().toString()),
                      position: prov.getLatLng()
                  ));
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Container(
                    width: 400,
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: "Stop Name",
                      ),
                      onChanged: (value) {
                        prov.busStop.stopName = value;
                      },
                    ),
                  ),
                  SizedBox(width: 30),
                  prov.getLatLng() == null?
                  Text("Select a Bus Stop from the map",style: TextStyle(fontSize: 20))
                      :Text(prov.getLatLng().toString(), style: TextStyle(fontSize: 20))
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Palette.secondary),
                    ),
                    onPressed: () async {
                      String checkData = prov.checkData();
                      if(checkData == '' || checkData == 'success') {
                        await prov.saveBusStop().then((success) async {
                          if(success) {
                            await Provider.of<BusStopProvider>(context, listen: false).getData();
                            prov.loading = false;
                            Navigator.pop(context);
                          } else {
                            prov.loading = false;
                            showAlertDialog(
                                context: context,
                                title: "Save Failed",
                                message: "Couldn't add bus stop, please try again"
                            );
                          }
                        });
                      } else {
                        prov.loading = false;
                        return showAlertDialog(
                            context: context,
                            title: 'Missing Data',
                            message: checkData
                        );
                      }

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
                  SizedBox(width: 40),
                  prov.loading?
                  CircularProgressIndicator(color: Palette.secondary)
                      : Container(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
