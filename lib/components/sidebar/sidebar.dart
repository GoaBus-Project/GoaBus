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
      decoration: BoxDecoration(
          color: Palette.primary,
          boxShadow: [
            BoxShadow(
                color: Colors.grey[200], offset: Offset(3, 5), blurRadius: 17)
          ]),
      width: 250,
      child: Container(
        child: Column(
          children: [
            Image.asset(
              Constants.NAMED_MAIN_LOGO,
              height: 57.0,
              width: 57.0,
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
              icon: Icons.people,
              text: 'Buses',
              active: sideBarProvider.currentPage == DisplayedPage.BUSES,
              onTap: () {
                sideBarProvider.changeCurrentPage(DisplayedPage.BUSES);
              },
            ),

            SideBarItems(
              icon: Icons.shopping_cart,
              text: 'Drivers',
              active: sideBarProvider.currentPage == DisplayedPage.DRIVERS,
              onTap: () {
                sideBarProvider.changeCurrentPage(DisplayedPage.DRIVERS);
              },
            ),

            SideBarItems(
              icon: Icons.category,
              text: 'Bus Stops',
              active: sideBarProvider.currentPage == DisplayedPage.BUSSTOPS,
              onTap: () {
                sideBarProvider.changeCurrentPage(DisplayedPage.BUSSTOPS);
              },
            ),

            SideBarItems(
              icon: Icons.category,
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
