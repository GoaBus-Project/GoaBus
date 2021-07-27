import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goabus_users/common/color_palette.dart';
import 'package:goabus_users/components/side_drawer.dart';
import 'package:goabus_users/models/buses_model.dart';
import 'package:goabus_users/providers/home_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selected = '';
  Completer<GoogleMapController> _controller = Completer();
  Timer timer = Timer(Duration(), (){});

  @override
  void initState() {
    super.initState();
    Provider.of<HomeProvider>(context, listen: false).init;
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Future<void> fetchBusLocation(Bus bus) async {
    final prov = Provider.of<HomeProvider>(context, listen: false);
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) async {
      bus = await prov.fetchBus(bus);
    });
  }

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
                    zoom: 17.0,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  markers: prov.markers,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      decoration: new InputDecoration(
                          filled: true,
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(50.0),
                            ),
                          ),
                          hintStyle: new TextStyle(color: Colors.grey[800]),
                          hintText: "Search...",
                          fillColor: Colors.white),
                      autofocus: false,
                      onChanged: (value) {
                        prov.destination = value.toLowerCase();
                        prov.finalDestination = value.toLowerCase();
                        // prov.search();
                      },
                      onEditingComplete: () {
                        List<Bus> _buses = [];
                        _buses.addAll(prov.search());
                        if(timer.isActive) timer.cancel();
                        showBarModalBottomSheet(
                          context: context,
                          expand: true,
                          isDismissible: false,
                          builder: (context) => Consumer<HomeProvider>(
                              builder: (BuildContext context, value, _) => prov
                                          .regExp
                                          .firstMatch(prov.destination) ==
                                      null
                                  ? Container(
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
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    const Radius.circular(50.0),
                                                  ),
                                                ),
                                                hintStyle: new TextStyle(
                                                    color: Colors.grey[800]),
                                                hintText: "Source",
                                                fillColor: Colors.white70),
                                            autofocus: true,
                                            onChanged: (source) {
                                              prov.source = source;
                                            },
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          TextField(
                                            decoration: new InputDecoration(
                                                border: new OutlineInputBorder(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    const Radius.circular(50.0),
                                                  ),
                                                ),
                                                hintStyle: new TextStyle(
                                                    color: Colors.grey[800]),
                                                fillColor: Colors.white70),
                                            controller: TextEditingController(
                                                text: prov.destination),
                                            autofocus: false,
                                            onChanged: (finalDestination) {
                                              prov.finalDestination =
                                                  finalDestination
                                                      .toLowerCase();
                                            },
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          ElevatedButton(
                                              onPressed: () {
                                                if (prov.destination !=
                                                    prov.finalDestination) {
                                                  prov.destination =
                                                      prov.finalDestination;
                                                  _buses = prov.search();
                                                }
                                                if (prov.source != '')
                                                  _buses = prov.search();
                                                _buses = prov
                                                    .searchBySourceAndDestination(
                                                        _buses);
                                              },
                                              child: Text("Search")),
                                          _buses.length != 0
                                              ? Container(
                                                  height: 300,
                                                  child: ListView.builder(
                                                      itemCount: _buses.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return ListTile(
                                                            onTap: () async {
                                                              Navigator.pop(context);
                                                              await fetchBusLocation(
                                                                  _buses[index]);
                                                            },
                                                            trailing: Text(
                                                              'Time $index',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .green,
                                                                  fontSize: 15),
                                                            ),
                                                            title: Text(
                                                                "Bus No ${_buses[index].busNo}"));
                                                      }))
                                              : Column(children: [
                                                  ListTile(
                                                    title: Text("No bus found"),
                                                  ),
                                                ])
                                        ],
                                      ))
                                  : Container(
                                      child: _buses.length != 0
                                          ? ListView.builder(
                                              itemCount: _buses.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return ListTile(
                                                    onTap: () async {
                                                      Navigator.pop(context);
                                                      await fetchBusLocation(
                                                          _buses[index]);
                                                    },
                                                    trailing: Text(
                                                      'Time $index',
                                                      style: TextStyle(
                                                          color: Colors.green,
                                                          fontSize: 15),
                                                    ),
                                                    title: Text(
                                                        "Bus No: ${_buses[index].busNo}"));
                                              })
                                          : Column(
                                              children: [
                                                ListTile(
                                                  title: Text("No bus found"),
                                                ),
                                              ],
                                            ),
                                    )),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ));
      },
    );
  }
}
