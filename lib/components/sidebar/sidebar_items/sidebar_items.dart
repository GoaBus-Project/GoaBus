import 'package:flutter/material.dart';
import 'package:goa_bus/constants/color_palette.dart';

class SideBarItems extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool active;
  final Function onTap;

  const SideBarItems({Key key, this.icon, this.text, this.active, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 80,
      splashColor: Palette.secondary,
      onPressed: onTap,
      color: active ? Color(0xff0077B6).withOpacity(.3) : Palette.primary,
      child: Row(
        children: [
          SizedBox(width: 10),
          Icon(icon, color: Palette.fontColor),
          SizedBox(width: 20),
          Text(
            text,
            style: TextStyle(fontSize: 20),
          )
        ],
      ),
    );
  }
}
