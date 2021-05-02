import 'package:flutter/material.dart';
import 'package:goa_bus/constants/color_palette.dart';

class SideBarItems extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool active;
  final Function onTap;
  const SideBarItems({Key key, this.icon, this.text, this.active, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: onTap,
        tileColor: active ? Color(0xff0077B6).withOpacity(.3) : Palette.navbarColor,
        leading: Icon(icon, color: Palette.fontColor),
        title: Text(text)
    );
  }
}
