import 'package:flutter/material.dart';
import 'package:goa_bus/constants/color_palette.dart';
class NavBar extends StatelessWidget {
  const NavBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Palette.primary,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: Image.asset(
                'logo.png',
                fit: BoxFit.contain
            ),
            onPressed: () { Scaffold.of(context).openDrawer(); },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),

      title: Center(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('GoaBus Admin Panel',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w100,
                  color: Colors.white
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.power_settings_new),
          color: Colors.white,
          onPressed: () {},
        ),
      ],
    );
  }
}
