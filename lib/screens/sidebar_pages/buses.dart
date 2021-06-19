import 'package:flutter/material.dart';
import 'package:goa_bus/components/details/bus_details.dart';
import 'package:goa_bus/components/forms/bus_form.dart';
import 'package:goa_bus/components/table.dart';
import 'package:goa_bus/constants/color_palette.dart';
import 'package:goa_bus/providers/sidebar_providers/bus_providers/buses_form_provider.dart';
import 'package:provider/provider.dart';
import 'package:smooth_scroll_web/smooth_scroll_web.dart';

class Buses extends StatefulWidget {
  @override
  _BusesState createState() => _BusesState();
}

class _BusesState extends State<Buses> {
  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    return Consumer<BusesFormProvider>(
      builder: (context, busProv, _){
        return Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TableHeaderTile(
                  first: "Number",
                  second: "Start",
                  third: "End"
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 50),
                child: Container(
                  height: MediaQuery.of(context).copyWith().size.height / 2,
                  width: MediaQuery.of(context).copyWith().size.width,
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
                                first: "Dynamic Bus number",
                                second: "Start Location",
                                third: "End Location",
                                details: BusDetails(),
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
                                    height: MediaQuery.of(context).size.height -  100,
                                    padding: EdgeInsets.all(20),
                                    color: Colors.white,
                                    child: Scaffold(
                                      body: BusForm(),
                                    ),
                                  ),
                                );
                              });
                        },
                        label: Text("Add Bus")
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
