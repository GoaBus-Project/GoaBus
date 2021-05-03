import 'package:flutter/material.dart';
import 'package:goa_bus/constants/color_palette.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400.0,
      child: Padding(
        padding: const EdgeInsets.only(top: 30,left: 50.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FloatingActionButton.extended(
                  onPressed: () {},
                  label: Text("Change Password",style: TextStyle(color: Colors.white),),
                  backgroundColor: Palette.buttonColor,
                ),
              ],
            ),
            SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FloatingActionButton.extended(
                  onPressed: () {},
                  label: Text("Organisation Settings",style: TextStyle(color: Colors.white),),
                  backgroundColor: Palette.buttonColor,
                ),
              ],
            ),
            SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FloatingActionButton.extended(
                  onPressed: () {},
                  label: Text("About",style: TextStyle(color: Colors.white),),
                  backgroundColor: Palette.buttonColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
