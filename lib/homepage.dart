import 'package:drivers_app/providers/homepage_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(child: Text("DRIVER APP")),
          backgroundColor: Color(0xFF0061A8),
        ),
        body: Consumer<HomePageProvider>(
          builder: (context, prov, _){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: prov.clicked?
                  RawMaterialButton(
                    onPressed: () {
                      prov.stopSendingLocation();
                    },
                    elevation: 2.0,
                    fillColor: Color(0xFF0061A8),
                    child: Icon(
                      Icons.stop,
                      size: 200.0,
                      color: Color(0xFFFBE0C4),
                    ),
                    padding: EdgeInsets.all(15.0),
                    shape: CircleBorder(),
                  )
                  :RawMaterialButton(
                    onPressed: () {
                        prov.startSendingLocation();
                    },
                    elevation: 2.0,
                    fillColor: Color(0xFF0061A8),
                    child: Icon(
                      Icons.location_on_outlined,
                      size: 200.0,
                      color: Color(0xFFFBE0C4),
                    ),
                    padding: EdgeInsets.all(15.0),
                    shape: CircleBorder(),
                  ),
                ),
              ],
            );
          }
        ),
      );
  }
}
