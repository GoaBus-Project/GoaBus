import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goa_bus/constants/color_palette.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smooth_scroll_web/smooth_scroll_web.dart';

class BusForm extends StatefulWidget {
  @override
  _BusFormState createState() => _BusFormState();
}

class _BusFormState extends State<BusForm> {
  String selectedRoute;
  List<String> routes = <String>[
    "Route 1",
    "route 2",
    "Route 3",
    "route 4",
  ];

  TimeOfDay _time = TimeOfDay(hour: 12, minute: 00);

  void _selectTime() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int _count=1;
    final ScrollController _scrollController = ScrollController();
    void _addNewRoute(){
      setState(() {
        _count=_count+1;
      });
    }
    return Column(
      children: [
        SizedBox(height: 15),
        TextFormField(
          decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: "Enter Bus Number"
          ),
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Select Trips"),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Palette.secondary),
              ),
              onPressed: (){
                _addNewRoute();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
                child: Text(
                  "Add",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Palette.fontColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(),
        Container(
          height: MediaQuery.of(context).copyWith().size.height / 4,
          width: MediaQuery.of(context).copyWith().size.width,
          child: SmoothScrollWeb(
            controller: _scrollController,
            child: Scrollbar(
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _scrollController,
                  scrollDirection: Axis.vertical,
                  itemCount: _count,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        DropdownButton<String>(
                          hint: Text("Select Route"),
                          value: selectedRoute,
                          onChanged: (String Value) {
                            setState(() {
                              selectedRoute = Value;
                            });
                          },
                          items: routes.map((String route) {
                            return DropdownMenuItem<String>(
                              value: route,
                              child: Row(
                                children: <Widget>[
                                  SizedBox(width: 10,),
                                  Text(
                                    route,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(width: 100.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'START TIME: ${_time.format(context)}',
                              style: TextStyle(fontSize: 15.0),
                            ),
                            SizedBox(width: 8),
                            IconButton(
                              padding: new EdgeInsets.all(0.0),
                              icon: Icon(Icons.access_time),
                              onPressed: _selectTime,
                            ),
                          ],
                        ),
                        SizedBox(width: 100.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'END TIME: ${_time.format(context)}',
                              style: TextStyle(fontSize: 15.0),
                            ),
                            SizedBox(width: 8),
                            IconButton(
                              padding: new EdgeInsets.all(0.0),
                              icon: Icon(Icons.access_time),
                              onPressed: _selectTime,
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
            ),
          ),
        ),
        SizedBox(height: 15),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: [
        //     Container(
        //       height: 350.0,
        //       width: 550.0,
        //       child: GoogleMap(
        //         mapType: MapType.normal,
        //         initialCameraPosition: CameraPosition(
        //           target:LatLng(15.496777,73.827827),
        //           zoom: 12,
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        SizedBox(height: 30),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Palette.secondary),
          ),
          onPressed: (){
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
            child: Text(
              "SAVE",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Palette.fontColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
