import 'package:flutter/material.dart';
import 'package:goa_bus/constants/color_palette.dart';

class DriverDetails extends StatefulWidget {
  @override
  _DriverDetailsState createState() => _DriverDetailsState();
}

class _DriverDetailsState extends State<DriverDetails> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Driver's image"),
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
                        "Display name",
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
                          "Display Number",
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
                          "Display address",
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
                          "Display bus number",
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
    );
  }
}
