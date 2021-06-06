import 'package:flutter/material.dart';
import 'package:goa_bus/common/alert_dialog_screen.dart';
import 'package:goa_bus/constants/color_palette.dart';
import 'package:goa_bus/providers/sidebar_providers/routes_provider.dart';
import 'package:provider/provider.dart';
import 'package:smooth_scroll_web/smooth_scroll_web.dart';

class RouteForm extends StatefulWidget {
  @override
  _RouteFormState createState() => _RouteFormState();
}

class _RouteFormState extends State<RouteForm> {
  List<String> example=["stop1","stop2","stop3"];
  List<String> intermediateStops = [];
  @override
  Widget build(BuildContext context) {
    String selectedStartStop;
    String selectedIntermediateStop;
    String selectedEndStop;
    final ScrollController _scrollController = ScrollController();
    return Consumer<RoutesProvider>(
      builder: (context, routesProv, _) {
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
                      labelText: "Route Name (Start-End)",
                    ),
                    onChanged: (number) {
                      // routesProv.routesData.busNo = number;
                    },
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Create Routes",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                  SizedBox(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      DropdownButton<String>(
                        hint: Text("Start Bus Stop"),
                        value: selectedStartStop,
                        onChanged: (String value) {
                          // busesProv.setRoute(value);
                          setState(() {
                            selectedStartStop = value;
                          });
                        },
                        items: example.map((String route) {
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
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DropdownButton<String>(
                            hint: Text("Intermediate Bus Stops"),
                            value: selectedIntermediateStop,
                            onChanged: (String value) {
                              // busesProv.setRoute(value);

                                selectedIntermediateStop = value;

                            },
                            items: example.map((String route) {
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

                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Palette.secondary),
                            ),
                            onPressed: () {
                              // if(busesProv.tripsData.route != ""
                              //     && busesProv.tripsData.route != null)
                              //   busesProv.addRoute();
                              // else
                              //   showAlertDialog(
                              //       context: context,
                              //       title: "Alert",
                              //       message: "Please select route"
                              //   );

                              setState(() {
                                intermediateStops.add(selectedIntermediateStop);
                              });

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
                      Container(
                        height: MediaQuery.of(context).copyWith().size.height / 3,
                        width: MediaQuery.of(context).copyWith().size.width-1000,
                        child: SmoothScrollWeb(
                          controller: _scrollController,
                          child: Scrollbar(
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                controller: _scrollController,
                                scrollDirection: Axis.vertical,
                                itemCount: intermediateStops.length,
                                itemBuilder: (context, index) {
                                  return intermediateStops.length==0?Text("Select Intermediate Stops"):Container(
                                    child: Card(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10.0),
                                            child: Text(
                                              intermediateStops[index],
                                              style: TextStyle(fontSize: 20.0),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:10.0),
                                            child: IconButton(
                                                icon: Icon(Icons.delete),
                                                onPressed: (){

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
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      DropdownButton<String>(
                        hint: Text("End Bus Stop"),
                        value: selectedEndStop,
                        onChanged: (String value) {
                          // busesProv.setRoute(value);
                          setState(() {
                            selectedEndStop = value;
                          });
                        },
                        items: example.map((String route) {
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
                  SizedBox(height: 30),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Palette.secondary),
                    ),
                    onPressed: () async {
                      // String checkData = busesProv.checkData();
                      // if(checkData == '') {
                      //   if (await busesProv.saveRoutesData()) {
                      //     busesProv.loading = false;
                      //     Navigator.pop(context);
                      //     return SnackBar(
                      //       content: Text('Data saved'),
                      //       backgroundColor: Palette.secondary,
                      //     );
                      //   } else {
                      //     busesProv.loading = false;
                      //     return showAlertDialog(
                      //         context: context,
                      //         title: 'Please try again',
                      //         message: 'There was some problem while saving data'
                      //     );
                      //   }
                      // } else {
                      //   return showAlertDialog(
                      //       context: context,
                      //       title: 'Missing Data',
                      //       message: checkData
                      //   );
                      // }
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
                  SizedBox(height: 10),
                  // busesProv.loading?
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     SizedBox(
                  //         height: 15,
                  //         width: 15,
                  //         child: CircularProgressIndicator(backgroundColor: Palette.secondary)
                  //     ),
                  //     SizedBox(width: 10),
                  //     Text(
                  //       'Saving data..',
                  //       style: TextStyle(
                  //           color: Colors.green
                  //       ),
                  //     ),
                  //   ],
                  // ):Container(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
