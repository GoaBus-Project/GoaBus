import 'package:flutter/material.dart';
import 'package:goa_bus/common/alert_dialog_screen.dart';
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
  void showConfirmationDialog(DriversProvider prov) {
    /// set up Yes button
    Widget yesButton = MaterialButton(
        child: Text(
          'Yes'.toUpperCase(),
          style: TextStyle(
              color: Colors.white
          ),
        ),
        splashColor: Colors.redAccent,
        color: Colors.red,
        onPressed: () async {
          Navigator.pop(context);
          if(!await prov.delete(widget.index).whenComplete(() =>
              Navigator.pop(context))) {
            return showAlertDialog(
              context: context,
              title: 'Error',
              message: 'Deletion failed, please try again',
            );
          }
        }
    );
    /// set up No button
    Widget noButton = MaterialButton(
        child: Text(
          'No'.toUpperCase(),
          style: TextStyle(
              color: Colors.white
          ),
        ),
        splashColor: Palette.primary,
        color: Palette.secondary,
        onPressed: () {Navigator.pop(context);}
    );
    /// show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete'),
          content: Text('Are you sure?'),
          actions: [
            yesButton,
            noButton
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DriversProvider>(
      builder: (context, prov, _) => Center(
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
                              onPressed: () {
                                showConfirmationDialog(prov);
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
