import 'package:flutter/material.dart';
import 'package:goa_bus/components/details/bus_stop_details.dart';
import 'package:goa_bus/components/forms/stop_form.dart';
import 'package:goa_bus/components/forms/time_table_form.dart';
import 'package:goa_bus/components/table.dart';
import 'package:goa_bus/constants/color_palette.dart';
import 'package:goa_bus/providers/sidebar_providers/bus_stop_providers/bus_stop_provider.dart';
import 'package:provider/provider.dart';
import 'package:smooth_scroll_web/smooth_scroll_web.dart';

class BusStops extends StatefulWidget {
  @override
  _BusStopsState createState() => _BusStopsState();
}

class _BusStopsState extends State<BusStops> {
  @override
  void initState() {
    Provider.of<BusStopProvider>(context, listen: false).init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    return Consumer<BusStopProvider>(
      builder: (context, prov, _) {
        return Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TableHeaderTile(
                  first: "Name",
                  second: "",
                  third: ""
              ),
              prov.loading?
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
              :Padding(
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
                          itemCount: prov.busStopsModel.busStops?.length??0,
                          itemBuilder: (context, index) {
                            return TableBodyTile(
                                first: prov.busStopsModel.busStops[index].stopName,
                                second: "",
                                third: "",
                                details: BusStopDetails(),
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
                                    width: MediaQuery.of(context).size.width - 500,
                                    height: MediaQuery.of(context).size.height - 100,
                                    padding: EdgeInsets.all(20),
                                    color: Colors.white,
                                    child: Scaffold(
                                      body: SmoothScrollWeb(
                                          controller: _scrollController,
                                          child: TimeTableForm()
                                      ),
                                    ),
                                  ),
                                );
                              }
                          );
                        },
                        label: Text("Create Time Table")
                    ),
                  ),
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
                                    width: MediaQuery.of(context).size.width - 500,
                                    height: MediaQuery.of(context).size.height -  100,
                                    padding: EdgeInsets.all(20),
                                    color: Colors.white,
                                    child: Scaffold(
                                      body: SmoothScrollWeb(
                                          controller: _scrollController,
                                          child: StopForm()
                                      ),
                                    ),
                                  ),
                                );
                              }
                          );
                        },
                        label: Text("Add Stops")
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
