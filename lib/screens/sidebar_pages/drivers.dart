import 'package:flutter/material.dart';
import 'package:goa_bus/components/table.dart';
import 'package:goa_bus/constants/color_palette.dart';
import 'package:goa_bus/providers/sidebar_providers/drivers_provider.dart';
import 'package:provider/provider.dart';
import 'package:smooth_scroll_web/smooth_scroll_web.dart';

class Drivers extends StatefulWidget {
  @override
  _DriversState createState() => _DriversState();
}

class _DriversState extends State<Drivers> {
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
                                first: "Dynamic Driver Name",
                                second: "Dynamic Driver Number",
                                third: "Dynamic bus name"
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
