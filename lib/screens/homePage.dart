import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goabus_users/components/sideDrawer.dart';
import 'package:goabus_users/constants/color_palette.dart';
import 'package:goabus_users/providers/home_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selected = '';
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, prov, _) {
        return Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text("GoaBus"),
                  SizedBox(
                    width: 50,
                  ),
                ],
              ),
              backgroundColor: Palette.secondary,
            ),
            drawer: Drawer(
              child: SideDrawer(),
            ),
            body: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(15.401100, 74.011803),
                    zoom: 10.0,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
                Column(
                  children: [
                    SizedBox(height: 10,),
                    TextField(
                      decoration: new InputDecoration(
                          filled: true,
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(50.0),
                            ),
                          ),
                          hintStyle: new TextStyle(color: Colors.grey[800]),
                          hintText: "Destination",
                          fillColor: Colors.white),
                      autofocus: false,
                      onChanged: (value) {
                        prov.destination = value;
                      },
                      onEditingComplete: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (_) {
                            return Container(
                                height: MediaQuery.of(context).size.height * 0.75,
                                decoration: new BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: new BorderRadius.only(
                                    topLeft: const Radius.circular(25.0),
                                    topRight: const Radius.circular(25.0),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextField(
                                      decoration: new InputDecoration(
                                          border: new OutlineInputBorder(
                                            borderRadius: const BorderRadius.all(
                                              const Radius.circular(50.0),
                                            ),
                                          ),
                                          hintStyle: new TextStyle(
                                              color: Colors.grey[800]),
                                          hintText: "Source",
                                          fillColor: Colors.white70),
                                      autofocus: false,
                                      onChanged: (value) {
                                        prov.source = value;
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextField(
                                      decoration: new InputDecoration(
                                          border: new OutlineInputBorder(
                                            borderRadius: const BorderRadius.all(
                                              const Radius.circular(50.0),
                                            ),
                                          ),
                                          hintStyle: new TextStyle(
                                              color: Colors.grey[800]),
                                          hintText: prov.destination,
                                          fillColor: Colors.white70),
                                      autofocus: false,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          prov.enableDisableBusList();
                                        },
                                        child: Text("Search")),
                                    prov.showBusList
                                        ? Container(
                                        height: 300,
                                        child: ListView.builder(
                                            itemCount: 5,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return ListTile(
                                                  onTap: () {
                                                    prov.enableDisableBusList();
                                                    Navigator.pop(context);
                                                  },
                                                  trailing: Text(
                                                    'Time $index',
                                                    style: TextStyle(
                                                        color: Colors.green,
                                                        fontSize: 15),
                                                  ),
                                                  title: Text("City $index"));
                                            }))
                                        : Container()
                                  ],
                                ));
                          },
                        );
                      },
                    ),
                  ],
                )
              ],
            ));
      },
    );
  }
}