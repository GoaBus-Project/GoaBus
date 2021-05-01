import 'package:flutter/material.dart';
import 'package:goa_bus/constants/color_palette.dart';
class NavBar extends StatelessWidget {
  const NavBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Palette.navbarColor,
      title: Center(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('GoaBus Admin Panel',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w100,
                  color: Palette.fontColor
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.power_settings_new),
          color: Palette.fontColor,
          onPressed: () {},
        ),
      ],
    );
  }
}
