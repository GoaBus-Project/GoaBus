import 'package:flutter/material.dart';
import 'package:goa_bus/components/details/route_details.dart';
import 'package:goa_bus/components/forms/route_form.dart';
import 'package:goa_bus/components/table.dart';
import 'package:goa_bus/constants/color_palette.dart';
import 'package:goa_bus/providers/sidebar_providers/route_providers/routes_provider.dart';
import 'package:provider/provider.dart';
import 'package:smooth_scroll_web/smooth_scroll_web.dart';

class Routes extends StatefulWidget {
  @override
  _RoutesState createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  @override
  void initState() {
    Provider.of<RoutesProvider>(context, listen: false).init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    return Consumer<RoutesProvider>(
      builder: (context, routeProv, _){
        return Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TableHeaderTile(
                  first: "Start",
                  second: "End",
                  third: ""
              ),
              routeProv.loading?
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
                      child: routeProv.routesModel.routes.length==0?
                      Center(
                        child: Text(
                          "No Routes Data Available",
                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                        ),
                      )
                      :ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          controller: _scrollController,
                          scrollDirection: Axis.vertical,
                          itemCount: routeProv.routesModel.routes.length??0,
                          itemBuilder: (context, index) {
                            return TableBodyTile(
                                first: routeProv.routesModel.routes[index].start.stopName,
                                second: routeProv.routesModel.routes[index].end.stopName,
                                third: "",
                                details: RouteDetails(index: index),
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
                                      body:RouteForm()
                                    ),
                                  ),
                                );
                              }
                          );

                        },
                        label: Text("Create Route")
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
