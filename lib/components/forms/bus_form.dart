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
  List<String> routeList = <String>[];
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
    final ScrollController _scrollController = ScrollController();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          SizedBox(height: 15),
          TextFormField(
            decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: "Enter Bus Number",
            ),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  "Create Trips",
                  style: TextStyle(fontSize: 20.0),
              ),
            ],
          ),
          SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              // SizedBox(width: 100.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Start Time: ${_time.format(context)}'.toUpperCase(),
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
              // SizedBox(width: 100.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'End Time: ${_time.format(context)}'.toUpperCase(),
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
              // SizedBox(width: 100.0),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Palette.secondary),
                ),
                onPressed: (){
                  if(selectedRoute!=null)
                  setState(() {
                    routeList.add(selectedRoute);
                  });
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
          SizedBox(height:30.0),
          Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            width: MediaQuery.of(context).copyWith().size.width,
            child: SmoothScrollWeb(
              controller: _scrollController,
              child: Scrollbar(
                child: routeList.length==0?Center(
                  child: Text(
                    "Select Routes And Save",
                    style: TextStyle(fontSize: 20.0),
                  ),
                )
                    :ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _scrollController,
                    scrollDirection: Axis.vertical,
                    itemCount: routeList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Card(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left:10.0),
                                child: Text(
                                  routeList[index],
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              ),
                              Text("start time"),
                              Text("end time"),
                              Padding(
                                padding: const EdgeInsets.only(right:10.0),
                                child: IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: (){
                                      setState(() {
                                        routeList.removeAt(index);
                                      });
                                    }
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ),
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
      ),
    );
  }
}
