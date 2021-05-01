import 'package:flutter/material.dart';

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
        tileColor: active ? Color(0xffCAF0F8).withOpacity(.3) : Color(0xff0077B6),
        leading: Icon(icon, color: Colors.white),
        title: Text(text)
    );
  }
}
