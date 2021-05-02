import 'package:flutter/material.dart';
import 'package:goa_bus/components/navbar/navbar.dart';
import 'package:goa_bus/components/sidebar/sidebar.dart';
import 'package:goa_bus/constants/color_palette.dart';
import 'package:goa_bus/providers/sidebar_provider.dart';
import 'package:goa_bus/screens/sidebar_pages/buses.dart';
import 'package:goa_bus/screens/sidebar_pages/dashboard.dart';
import 'package:goa_bus/screens/sidebar_pages/drivers.dart';
import 'package:goa_bus/screens/sidebar_pages/settings.dart';
import 'package:goa_bus/screens/sidebar_pages/bus_stops.dart';
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
                          padding: const EdgeInsets.only(top: 15, left: 50),
                          child: Text(
                            sideBarProv.activeHeading,
                            style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              color: Palette.fontColor.withOpacity(0.6)
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
