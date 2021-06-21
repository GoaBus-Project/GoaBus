import 'package:flutter/material.dart';
import 'package:goa_bus/common/alert_dialog_screen.dart';
import 'package:goa_bus/components/details/bus_location_details.dart';
import 'package:goa_bus/components/table.dart';
import 'package:goa_bus/constants/color_palette.dart';
import 'package:goa_bus/providers/sidebar_providers/bus_providers/buses_provider.dart';
import 'package:provider/provider.dart';
import 'package:smooth_scroll_web/smooth_scroll_web.dart';

class BusDetails extends StatefulWidget {
  final int index;

  const BusDetails({Key key, @required this.index}) : assert(index != null);
  @override
  _BusDetailsState createState() => _BusDetailsState();
}

class _BusDetailsState extends State<BusDetails> {
  void showConfirmationDialog(BusesProvider prov) {
    /// set up Yes button
    Widget yesButton = MaterialButton(
        child: Text(
          'Yes'.toUpperCase(),
          style: TextStyle(color: Colors.white),
        ),
        splashColor: Colors.redAccent,
        color: Colors.red,
        onPressed: () async {
          Navigator.pop(context);
          Navigator.pop(context);
          if(!await prov.delete(widget.index)) {
            return showAlertDialog(
              context: context,
              title: 'Error',
              message: 'Deletion failed, please try again',
            );
          }
        }
    );
    /// set up No button
    Widget noButton = MaterialButton(
        child: Text(
          'No'.toUpperCase(),
          style: TextStyle(
              color: Colors.white
          ),
        ),
        splashColor: Palette.primary,
        color: Palette.secondary,
        onPressed: () {Navigator.pop(context);}
    );
    /// show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete'),
          content: Text('Are you sure?'),
          actions: [
            yesButton,
            noButton
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    return Consumer<BusesProvider>(
      builder: (context, prov, _ ) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: IconButton(
                          tooltip: "Show Live Location",
                          icon: Icon(Icons.location_on_outlined),
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
                                      width: MediaQuery.of(context).size.width - 800,
                                      height: MediaQuery.of(context).size.height - 100,
                                      padding: EdgeInsets.all(20),
                                      color: Colors.white,
                                      child: Scaffold(
                                        body: BusLocationDetails(index: widget.index),
                                      ),
                                    ),
                                  );
                                }
                            );
                          }
                      ),
                    )
                ),
                SizedBox(width: 30),
                Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: IconButton(
                          tooltip: "Delete",
                          iconSize: 30,
                          icon: Icon(Icons.delete_outline),
                          onPressed: () {
                            showConfirmationDialog(prov);
                          }
                      ),
                    )
                ),
              ],
            ),
            SizedBox(height: 30,),
            Table(
              columnWidths: {
                0: FlexColumnWidth(3),
                1: FlexColumnWidth(6),
              },
              children: [
                TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15, left: 50),
                          child: Text(
                            "Number:",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Palette.fontColor
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15, left: 50),
                          child: Text(
                            prov.busesModel.buses[widget.index].busNo,
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Palette.fontColor.withOpacity(0.6)
                            ),
                          ),
                        ),
                      )
                    ]
                ),
                TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15, left: 50),
                          child: Text(
                            "Driver:",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Palette.fontColor
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15, left: 50),
                          child: Text(
                            prov.busesModel.buses[widget.index].driver,
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Palette.fontColor.withOpacity(0.6)
                            ),
                          ),
                        ),
                      )
                    ]
                ),
              ],
            ),
            SizedBox(height: 30),
            TableHeaderTile(
              first: "",
              second: "TRIPS",
              third: "",
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 15, left: 50),
            //   child: Text(
            //     "Trips:",
            //     style: TextStyle(
            //         fontSize: 25,
            //         fontWeight: FontWeight.bold,
            //         color: Palette.fontColor
            //     ),
            //   ),
            // ),
            SizedBox(height: 10),
            Container(
              height: MediaQuery
                  .of(context)
                  .copyWith()
                  .size
                  .height / 3,
              width: MediaQuery
                  .of(context)
                  .copyWith()
                  .size
                  .width,
              child: SmoothScrollWeb(
                controller: _scrollController,
                child: Scrollbar(
                  child:
                  prov.busesModel.buses[widget.index].trips.length==0?
                  Center(
                    child: Text(
                      "Select Routes And Save",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ) :
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      controller: _scrollController,
                      scrollDirection: Axis.vertical,
                      itemCount: prov.busesModel.buses[widget.index].trips.length??0,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Card(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                      prov.busesModel.buses[widget.index].trips[index].routeName,
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                ),
                                Text(prov.busesModel.buses[widget.index].trips[index].startTime.format(context).toString()),
                                Text(prov.busesModel.buses[widget.index].trips[index].endTime.format(context).toString()),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {}
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
        );
      }
    );
  }
}
