import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goa_bus/components/sidebar/sidebar_items/sidebar_items.dart';
import 'package:goa_bus/constants/color_palette.dart';
import 'package:goa_bus/constants/constants.dart';
import 'package:goa_bus/providers/sidebar_provider.dart';

import 'package:provider/provider.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    final SideBarProvider sideBarProvider =
        Provider.of<SideBarProvider>(context, listen: true);
    return Container(
      decoration: BoxDecoration(color: Palette.primary, boxShadow: [
        BoxShadow(color: Colors.grey[200], offset: Offset(3, 5), blurRadius: 17)
      ]),
      width: 250,
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  Constants.MAIN_LOGO,
                  height: 57.0,
                  width: 57.0,
                ),
                Text(
                  'Goa Bus',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Palette.fontColor),
                ),
              ],
            ),
            SideBarItems(
              icon: Icons.dashboard,
              text: 'Dashboard',
              active: sideBarProvider.currentPage == DisplayedPage.DASHBOARD,
              onTap: () {
                sideBarProvider.changeCurrentPage(DisplayedPage.DASHBOARD);
              },
            ),
            SideBarItems(
              icon: Icons.directions_bus,
              text: 'Buses',
              active: sideBarProvider.currentPage == DisplayedPage.BUSES,
              onTap: () {
                sideBarProvider.changeCurrentPage(DisplayedPage.BUSES);
              },
            ),
            SideBarItems(
              icon: Icons.person,
              text: 'Drivers',
              active: sideBarProvider.currentPage == DisplayedPage.DRIVERS,
              onTap: () {
                sideBarProvider.changeCurrentPage(DisplayedPage.DRIVERS);
              },
            ),
            SideBarItems(
              icon: Icons.alt_route,
              text: 'Routes',
              active: sideBarProvider.currentPage == DisplayedPage.ROUTES,
              onTap: () {
                sideBarProvider.changeCurrentPage(DisplayedPage.ROUTES);
              },
            ),
            SideBarItems(
              icon: Icons.stop_circle_outlined,
              text: 'Bus Stops',
              active: sideBarProvider.currentPage == DisplayedPage.BUSSTOPS,
              onTap: () {
                sideBarProvider.changeCurrentPage(DisplayedPage.BUSSTOPS);
              },
            ),
            SideBarItems(
              icon: Icons.settings,
              text: 'Settings',
              active: sideBarProvider.currentPage == DisplayedPage.SETTINGS,
              onTap: () {
                sideBarProvider.changeCurrentPage(DisplayedPage.SETTINGS);
              },
            ),
          ],
        ),
      ),
    );
  }
}
