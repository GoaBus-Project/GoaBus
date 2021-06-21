import 'package:flutter/material.dart';
import 'package:goa_bus/constants/color_palette.dart';
import 'package:goa_bus/providers/sidebar_providers/driver_providers/drivers_provider.dart';
import 'package:provider/provider.dart';

class DriverDetails extends StatefulWidget {
  final int index;

  const DriverDetails({Key key, @required this.index}) : assert(index != null);
  @override
  _DriverDetailsState createState() => _DriverDetailsState();
}

class _DriverDetailsState extends State<DriverDetails> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DriversProvider>(
      builder: (context, prov, _) =>
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
                Table(
                  columnWidths: {
                    0: FlexColumnWidth(3),
                    1: FlexColumnWidth(4),
                  },
                  children: [
                    TableRow(
                        children: [
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15, left: 50),
                              child: Text(
                                "Name:",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Palette.fontColor
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15, left: 50),
                              child: Text(
                                prov.driversModel.drivers[widget.index].name,
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Palette.fontColor.withOpacity(0.6)
                                ),
                              ),
                            ),
                          )
                        ]
                    ),
                    TableRow(
                        children: [
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15, left: 50),
                              child: Text(
                                "Phone Number:",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Palette.fontColor
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15, left: 50),
                              child: Text(
                                prov.driversModel.drivers[widget.index].contact,
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Palette.fontColor.withOpacity(0.6)
                                ),
                              ),
                            ),
                          )
                        ]
                    ),
                    TableRow(
                        children: [
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15, left: 50),
                              child: Text(
                                "Address:",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Palette.fontColor
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15, left: 50),
                              child: Text(
                                prov.driversModel.drivers[widget.index].address,
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Palette.fontColor.withOpacity(0.6)
                                ),
                              ),
                            ),
                          )
                        ]
                    ),
                    TableRow(
                        children: [
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15, left: 50),
                              child: Text(
                                "Bus Driving:",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Palette.fontColor
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15, left: 50),
                              child: Text(
                                prov.getBusNo(
                                  prov.driversModel.drivers[widget.index].name,
                                  prov.driversModel.drivers[widget.index].contact,
                                ).busNo,
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Palette.fontColor.withOpacity(0.6)
                                ),
                              ),
                            ),
                          )
                        ]
                    )
                  ],
                )
              ],
            ),
          )
    );
  }
}
