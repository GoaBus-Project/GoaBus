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

  @override
  void initState() {
    super.initState();
    Provider.of<HomeProvider>(context, listen: false).init;
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
                    zoom: 10.0,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
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
                        prov.destination = value;
                        // prov.search();
                      },
                      onEditingComplete: () {
                        List<Bus> _bus = [];
                        if(prov.regExp.firstMatch(prov.destination) != null)
                          _bus.addAll(prov.search());
                        /*showModalBottomSheet(
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
                        );*/
                        showBarModalBottomSheet(
                          context: context,
                          expand: true,
                          isDismissible: false,
                          builder: (context) => Consumer<HomeProvider>(
                            builder: (BuildContext context, value, _) => prov
                                        .regExp
                                        .firstMatch(prov.destination.toUpperCase()) ==
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
                                                borderRadius:
                                                    const BorderRadius.all(
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
                                              // prov.search();
                                            },
                                            child: Text("Search")),
                                        prov.showBusList
                                            ? Container(
                                                height: 300,
                                                child: ListView.builder(
                                                    itemCount: 5,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return ListTile(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                            prov.selectBus();
                                                          },
                                                          trailing: Text(
                                                            'Time $index',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .green,
                                                                fontSize: 15),
                                                          ),
                                                          title: Text(
                                                              "City $index"));
                                                    }))
                                            : Container()
                                      ],
                                    ))
                                : Container(
                                    child: _bus.length != 0?
                                    ListView.builder(
                                        itemCount: _bus.length,
                                        itemBuilder:
                                            (BuildContext context,
                                            int index) {
                                          return ListTile(
                                              onTap: () {
                                                Navigator.pop(
                                                    context);
                                                prov.selectBus();
                                              },
                                              trailing: Text(
                                                'Time $index',
                                                style: TextStyle(
                                                    color: Colors
                                                        .green,
                                                    fontSize: 15),
                                              ),
                                              title: Text(
                                                  "Bus No: ${_bus[index].busNo}"));
                                        }):
                                    ListTile(
                                      title: Text("No bus found"),
                                    ),
                                  )
                          ),
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
