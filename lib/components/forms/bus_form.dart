import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goa_bus/constants/color_palette.dart';
import 'package:goa_bus/constants/constants.dart';
import 'package:goa_bus/providers/sidebar_providers/bus_providers/buses_form_provider.dart';
import 'package:goa_bus/common/alert_dialog_screen.dart';
import 'package:goa_bus/providers/sidebar_providers/bus_providers/buses_provider.dart';
import 'package:provider/provider.dart';
import 'package:smooth_scroll_web/smooth_scroll_web.dart';

class BusForm extends StatefulWidget {
  @override
  _BusFormState createState() => _BusFormState();
}

class _BusFormState extends State<BusForm> {
  @override
  void initState() {
    Provider.of<BusesFormProvider>(context, listen: false).init();
    super.initState();
  }

  Future<void> _selectTime(bool startTime, BusesFormProvider prov) async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: startTime ?
      prov.trip.startTime : prov.trip.endTime,
    );
    if (newTime != null) {
      startTime?
      prov.setStartTime(newTime) : prov.setEndTime(newTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    return Consumer<BusesFormProvider>(
      builder: (context, busesProv, _) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 15),
                  TextFormField(
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: "Enter Bus Number",
                    ),
                    onChanged: (number) {
                      busesProv.busData.busNo = number;
                    },
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      busesProv.driversLoading?
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, top: 15),
                          child: CircularProgressIndicator(
                              color: Palette.secondary
                          ),
                        ),
                      )
                      :busesProv.getDrivers().length == 0?
                      Text("No saved drivers",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: Constants.alertFontSize
                          ))
                      :DropdownButton<String>(
                        hint: Text("Select Driver"),
                        value: busesProv.busData.driver,
                        onChanged: (String value) {
                          busesProv.setDriver(value);
                        },
                        items: busesProv.getDrivers().map((String route) {
                          return DropdownMenuItem<String>(
                            value: route,
                            child: Row(
                              children: <Widget>[
                                SizedBox(width: 10),
                                Text(
                                  route,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
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
                      busesProv.routesLoading?
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, top: 15),
                          child: CircularProgressIndicator(
                              color: Palette.secondary
                          ),
                        ),
                      )
                      :busesProv.routes.length == 0?
                      Text("No saved routes",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: Constants.alertFontSize
                      ))
                      :DropdownButton<String>(
                        hint: Text("Select Route"),
                        value: busesProv.trip.routeName,
                        onChanged: (String value) {
                          busesProv.setRoute(value);
                        },
                        items: busesProv.routes.map((String route) {
                          return DropdownMenuItem<String>(
                            value: route,
                            child: Row(
                              children: <Widget>[
                                SizedBox(width: 10),
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
                            'Start Time: '
                                '${busesProv.trip.startTime.format(context)}'
                                .toUpperCase(),
                            style: TextStyle(fontSize: 15.0),
                          ),
                          SizedBox(width: 8),
                          IconButton(
                            padding: new EdgeInsets.all(0.0),
                            icon: Icon(Icons.access_time),
                            onPressed: () async {
                              await _selectTime(true, busesProv);
                            },
                          ),
                        ],
                      ),
                      // SizedBox(width: 100.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'End Time: '
                                '${busesProv.trip.endTime.format(context)}'
                                .toUpperCase(),
                            style: TextStyle(fontSize: 15.0),
                          ),
                          SizedBox(width: 8),
                          IconButton(
                            padding: new EdgeInsets.all(0.0),
                            icon: Icon(Icons.access_time),
                            onPressed: () async {
                              await _selectTime(false, busesProv);
                            },
                          ),
                        ],
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Palette.secondary),
                        ),
                        onPressed: () {
                          if(busesProv.trip.routeName != ""
                              && busesProv.trip.routeName != null)
                            busesProv.addRoute();
                          else
                            showAlertDialog(
                                context: context,
                                title: "Alert",
                                message: "Please select route"
                            );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
                          child: Text(
                            "Add".toUpperCase(),
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
                        child: busesProv.busData.trips.length == 0?
                        Center(
                          child: Text(
                            "Select Routes And Save",
                            style: TextStyle(fontSize: 20.0),
                          ),
                        )
                      :ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          controller: _scrollController,
                          scrollDirection: Axis.vertical,
                          itemCount: busesProv.busData.trips.length??0,
                          itemBuilder: (context, index) {
                            return Container(
                              child: Card(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        busesProv.busData.trips[index].routeName,
                                        style: TextStyle(fontSize: 20.0),
                                      ),
                                    ),
                                    Text(busesProv.busData.trips[index].startTime
                                        .format(context)),
                                    Text(busesProv.busData.trips[index].endTime
                                        .format(context)),
                                    Padding(
                                      padding: const EdgeInsets.only(right:10.0),
                                      child: IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: (){
                                            busesProv.removeRoute(index);
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Palette.secondary),
                        ),
                        onPressed: () async {
                          String checkData = busesProv.checkData();
                          if(checkData == '' || checkData == 'success') {
                            if (await busesProv.saveBusesData()) {
                              await Provider.of<BusesProvider>(context, listen: false).getData();
                              busesProv.loading = false;
                              Navigator.pop(context);
                            } else {
                              busesProv.loading = false;
                              return showAlertDialog(
                                  context: context,
                                  title: 'Please try again',
                                  message: 'There was some problem while saving data'
                              );
                            }
                          } else {
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
                      busesProv.loading?
                      CircularProgressIndicator(color: Palette.secondary)
                          : Container(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
