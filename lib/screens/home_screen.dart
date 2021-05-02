import 'package:flutter/material.dart';
import 'package:goa_bus/components/navbar/navbar.dart';
import 'package:goa_bus/components/sidebar/sidebar.dart';
import 'package:goa_bus/providers/sidebar_provider.dart';
import 'package:goa_bus/screens/sidebar_pages/buses.dart';
import 'package:goa_bus/screens/sidebar_pages/dashboard.dart';
import 'package:goa_bus/screens/sidebar_pages/drivers.dart';
import 'package:goa_bus/screens/sidebar_pages/settings.dart';
import 'package:goa_bus/screens/sidebar_pages/timetable.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool firstLoad = false;

  @override
  void initState() {
    firstLoad = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var sideBarProv = Provider.of<SideBarProvider>(context, listen: true);
    if(firstLoad) {
      firstLoad = false;
      sideBarProv.init();
    }
    return Scaffold(
      body: Row(
        children: [
          SideBar(),
          Expanded(
            child: Column(
              children: [
                NavBar(),
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8, left: 10),
                          child: Text(sideBarProv.activeHeading,
                            style: TextStyle(
                              fontSize: 80,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(thickness: 2),
                    sideBarProv.currentPage == DisplayedPage.DASHBOARD ?
                    Dashboard()
                        : sideBarProv.currentPage == DisplayedPage.BUSES ?
                    Buses()
                        : sideBarProv.currentPage == DisplayedPage.DRIVERS ?
                    Drivers()
                        : sideBarProv.currentPage == DisplayedPage.BUSSTOPS ?
                    BusStops()
                        : Settings()
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
