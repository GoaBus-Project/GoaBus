import 'package:flutter/material.dart';
import 'package:goa_bus/components/details/bus_details.dart';
import 'package:goa_bus/components/forms/bus_form.dart';
import 'package:goa_bus/components/table.dart';
import 'package:goa_bus/constants/color_palette.dart';
import 'package:goa_bus/providers/sidebar_providers/bus_providers/buses_provider.dart';
import 'package:provider/provider.dart';
import 'package:smooth_scroll_web/smooth_scroll_web.dart';

class Buses extends StatefulWidget {
  @override
  _BusesState createState() => _BusesState();
}

class _BusesState extends State<Buses> {
  @override
  void initState() {
    Provider.of<BusesProvider>(context, listen: false).init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    return Consumer<BusesProvider>(
      builder: (context, busProv, _){
        return Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TableHeaderTile(
                  first: "Number",
                  second: "Driver",
                  third: ""
              ),
              busProv.loading?
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
                  height: MediaQuery.of(context).copyWith().size.height / 2,
                  width: MediaQuery.of(context).copyWith().size.width,
                  child: SmoothScrollWeb(
                    controller: _scrollController,
                    child: Scrollbar(
                      child: busProv.busesModel.buses.length==0?
                          Center(
                            child: Text(
                              "No Bus Data Available",
                              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                            ),
                          )
                      :ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          controller: _scrollController,
                          scrollDirection: Axis.vertical,
                          itemCount: busProv.busesModel.buses.length??0,
                          itemBuilder: (context, index) {
                            return TableBodyTile(
                              first: busProv.busesModel.buses[index].busNo,
                              second: busProv.busesModel.buses[index].driver,
                              third: "",
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
                                    height: MediaQuery.of(context).size.height - 100,
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
