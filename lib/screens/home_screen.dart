import 'package:flutter/material.dart';
import 'package:goa_bus/components/navbar/navbar.dart';
import 'package:goa_bus/components/sidebar/sidebar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Row(
        children: [
          SideBar(),
          Expanded(
            child: Column(
              children: [
                NavBar(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
