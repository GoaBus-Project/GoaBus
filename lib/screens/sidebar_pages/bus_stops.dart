import 'package:flutter/material.dart';
import 'package:goa_bus/components/table.dart';
import 'package:goa_bus/constants/color_palette.dart';
import 'package:goa_bus/providers/sidebar_providers/bus_stop_provider.dart';
import 'package:provider/provider.dart';
import 'package:smooth_scroll_web/smooth_scroll_web.dart';

class BusStops extends StatefulWidget {
  @override
  _BusStopsState createState() => _BusStopsState();
}

class _BusStopsState extends State<BusStops> {
  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    return Consumer<BusStopProvider>(
      builder: (context, driverProv, _){
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
                          itemCount: 20,
                          itemBuilder: (context, index) {
                            return TableBodyTile(
                                first: "Dynamic Stop Name",
                                second: "",
                                third: ""
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
                        onPressed: (){},
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
