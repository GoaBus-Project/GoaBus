import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    return Consumer<BusesProvider>(
      builder: (context, prov, _ ) {
        return Column(
          children: [
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
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 50),
                  child: Text(
                    "Trips:",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Palette.fontColor
                    ),
                  ),
                ),
              ],
            ),
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
