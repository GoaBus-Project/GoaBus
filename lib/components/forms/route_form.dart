import 'package:flutter/material.dart';
import 'package:goa_bus/common/alert_dialog_screen.dart';
import 'package:goa_bus/constants/color_palette.dart';
import 'package:goa_bus/constants/constants.dart';
import 'package:goa_bus/providers/sidebar_providers/route_providers/routes_form_provider.dart';
import 'package:goa_bus/providers/sidebar_providers/route_providers/routes_provider.dart';
import 'package:provider/provider.dart';
import 'package:smooth_scroll_web/smooth_scroll_web.dart';

class RouteForm extends StatefulWidget {
  @override
  _RouteFormState createState() => _RouteFormState();
}

class _RouteFormState extends State<RouteForm> {
  List<String> intermediateStops = [];

  @override
  void initState() {
    final prov = Provider.of<RoutesFormProvider>(context, listen: false);
    prov.init();
    prov.getStops();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    return Consumer<RoutesFormProvider>(
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
                    onChanged: (value) {
                      routesProv.route.name = value;
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
                      routesProv.busStops.isEmpty?
                      Container()
                      :DropdownButton<String>(
                        hint: Text("Start Bus Stop"),
                        value: routesProv.route.start.stopName,
                        onChanged: (String value) {
                          routesProv.setStartStop(value);
                        },
                        items: routesProv.busStops.map((String route) {
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
                          routesProv.busStops.isEmpty?
                          Text("No saved stops",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: Constants.alertFontSize
                              ))
                          :DropdownButton<String>(
                            hint: Text("Intermediate Bus Stops"),
                            value: routesProv.selectedIntermediateStop,
                            onChanged: (String value) {
                              routesProv.setIntermediateStop(value);
                            },
                            items: routesProv.busStops.map((String route) {
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

                          Visibility(
                            visible: routesProv.selectedIntermediateStop != null,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Palette.secondary),
                              ),
                              onPressed: () {
                                routesProv.addIntermediateStop();
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
                          ),
                        ],
                      ),
                      Container(
                        height: MediaQuery.of(context).copyWith().size.height / 3,
                        width: MediaQuery.of(context).copyWith().size.width-1000,
                        child: SmoothScrollWeb(
                          controller: _scrollController,
                          child: Scrollbar(
                            child: routesProv.route.intermediate.stop == null?
                            Container()
                            :ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                controller: _scrollController,
                                scrollDirection: Axis.vertical,
                                itemCount: routesProv.route.intermediate.stop.length??0,
                                itemBuilder: (context, index) {
                                  return Container(
                                    child: Card(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10.0),
                                            child: Text(
                                              routesProv.route.intermediate.stop[index].stopName,
                                              style: TextStyle(fontSize: 20.0),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:10.0),
                                            child: IconButton(
                                                icon: Icon(Icons.delete),
                                                onPressed: (){
                                                  routesProv.removeIntermediateStop(index);
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
                      routesProv.busStops.isEmpty?
                      Container()
                      :DropdownButton<String>(
                        hint: Text("End Bus Stop"),
                        value: routesProv.route.end.stopName,
                        onChanged: (String value) {
                          routesProv.setEndStop(value);
                        },
                        items: routesProv.busStops.map((String route) {
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Palette.secondary),
                        ),
                        onPressed: () async {
                          String checkData = routesProv.checkData();
                          if(checkData == 'success' || checkData == '') {
                            if (await routesProv.saveRoutesData()) {
                              await Provider.of<RoutesProvider>(context, listen: false).fetchRoutes();
                              routesProv.loading = false;
                              Navigator.pop(context);
                              return SnackBar(
                                content: Text('Data saved'),
                                backgroundColor: Palette.secondary,
                              );
                            } else {
                              routesProv.loading = false;
                              return showAlertDialog(
                                  context: context,
                                  title: 'Save Failed',
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
                      routesProv.loading?
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
