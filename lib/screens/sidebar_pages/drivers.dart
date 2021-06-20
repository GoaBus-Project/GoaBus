import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goa_bus/components/details/driver_details.dart';
import 'package:goa_bus/components/forms/driver_form.dart';
import 'package:goa_bus/components/table.dart';
import 'package:goa_bus/constants/color_palette.dart';
import 'package:goa_bus/providers/sidebar_providers/driver_providers/drivers_provider.dart';
import 'package:provider/provider.dart';
import 'package:smooth_scroll_web/smooth_scroll_web.dart';

class Drivers extends StatefulWidget {
  @override
  _DriversState createState() => _DriversState();
}

class _DriversState extends State<Drivers> {
  @override
  void initState() {
    Provider.of<DriversProvider>(context, listen: false).init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    return Consumer<DriversProvider>(
      builder: (context, driverProv, _){
        return Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TableHeaderTile(
                  first: "Name",
                  second: "Contact Number",
                  third: "Bus Driving"
              ),
              /*driverProv.loading?
              Padding(
                padding: const EdgeInsets.only(top: 150),
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: Center(
                      child: CircularProgressIndicator(
                        color: Palette.secondary,
                      )
                  ),
                ),
              )
              :ClipOval(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.transparent,
                  child: Image.memory(driverProv.driversModel.drivers[0].image),
                ),
              ),*/
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 50),
                child: Container(
                  height: 400,
                  child: SmoothScrollWeb(
                    controller: _scrollController,
                    child: Scrollbar(
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          controller: _scrollController,
                          scrollDirection: Axis.vertical,
                          itemCount: driverProv.driversModel.drivers.length??0,
                          itemBuilder: (context, index) {
                            return TableBodyTile(
                                first: driverProv.driversModel.drivers[index].name,
                                second: driverProv.driversModel.drivers[index].contact,
                                third: driverProv
                                    .getBusNo(
                                    driverProv.driversModel.drivers[index].name,
                                    driverProv.driversModel.drivers[index].contact)
                                    .busNo,
                                details: DriverDetails(index: index),
                            );
                          }),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 50.0),
                    child: FloatingActionButton.extended(
                      backgroundColor: Palette.buttonColor,
                        onPressed: (){
                          showGeneralDialog(
                              context: context,
                              barrierDismissible: true,
                              barrierLabel: MaterialLocalizations.of(context)
                                  .modalBarrierDismissLabel,
                              barrierColor: Colors.black45,
                              transitionDuration: const Duration(milliseconds: 200),
                              pageBuilder: (BuildContext buildContext,
                                  Animation animation,
                                  Animation secondaryAnimation) {
                                return Center(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width - 1000,
                                    height: MediaQuery.of(context).size.height -  100,
                                    padding: EdgeInsets.all(20),
                                    color: Colors.white,
                                    child: Scaffold(
                                      body: SmoothScrollWeb(
                                          controller: _scrollController,
                                          child: DriverForm()
                                      ),
                                    ),
                                  ),
                                );
                              }
                          );
                        },
                        label: Text("Add Driver"),
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
