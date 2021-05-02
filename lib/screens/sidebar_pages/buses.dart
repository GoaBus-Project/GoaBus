import 'package:flutter/material.dart';
import 'package:goa_bus/providers/sidebar_providers/buses_provider.dart';
import 'package:provider/provider.dart';

class Buses extends StatefulWidget {
  @override
  _BusesState createState() => _BusesState();
}

class _BusesState extends State<Buses> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BusesProvider>(
      builder: (context, busProv, _){
        return Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // busProv.tableHeaders.
                  // Text("Name",
                  //     style: TextStyle(color: Colors.black, fontSize: 36.0)
                  // )
                  // Text("Number", style: TextStyle(color: Colors.black, fontSize: 36.0),),
                  // Text("Current Location", style: TextStyle(color: Colors.black, fontSize: 36.0),),
                  // SizedBox(),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 24.0),
              height: 500,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Card(
                        color: Colors.blue,
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("busname", style: TextStyle(color: Colors.white, fontSize: 36.0),),
                              Text("busnumber", style: TextStyle(color: Colors.white, fontSize: 36.0),),
                              Text("loaction", style: TextStyle(color: Colors.white, fontSize: 36.0),),
                              IconButton(icon: Icon(Icons.more_outlined), onPressed: (){})
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        );
      },
    );
  }
}
