import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool clicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DRIVER APP"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            clicked?
            RawMaterialButton(
              onPressed: () {
                setState(() {
                  clicked=false;
                });
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
                setState(() {
                  clicked=true;
                });
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
            )
          ],
        ),
      ),
    );
  }
}
