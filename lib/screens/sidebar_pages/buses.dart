import 'package:flutter/material.dart';

class Buses extends StatefulWidget {
  @override
  _BusesState createState() => _BusesState();
}

class _BusesState extends State<Buses> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text('This contains buses'),
      ),
    );
  }
}
