import 'package:flutter/material.dart';
import 'package:goa_bus/constants/color_palette.dart';
import 'package:smooth_scroll_web/smooth_scroll_web.dart';

class BusDetails extends StatefulWidget {
  @override
  _BusDetailsState createState() => _BusDetailsState();
}

class _BusDetailsState extends State<BusDetails> {
  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    return Column(
      children: [
        Table(
          children: [
            TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15, left: 50),
                      child: Text(
                        "Bus Number:",
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
                        "Display bus Number",
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
                        "Display driver",
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
        Container(
          height: MediaQuery.of(context).copyWith().size.height / 3,
          width: MediaQuery.of(context).copyWith().size.width,
          child: SmoothScrollWeb(
            controller: _scrollController,
            child: Scrollbar(
              child:
              // busesProv.busData.trips.length == 0?
              // Center(
              //   child: Text(
              //     "Select Routes And Save",
              //     style: TextStyle(fontSize: 20.0),
              //   ),
              // ) :
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  controller: _scrollController,
                  scrollDirection: Axis.vertical,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                "Route name",
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                            Text("Start Time"),
                            Text("End time"),
                            Padding(
                              padding: const EdgeInsets.only(right:10.0),
                              child: IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: (){}
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
}
