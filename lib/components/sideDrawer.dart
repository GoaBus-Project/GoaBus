import 'package:flutter/material.dart';
import 'package:goabus_users/constants/color_palette.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({Key? key}) : super(key: key);

  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        DrawerHeader(
          decoration: BoxDecoration(color: Palette.secondary),
          child: SizedBox(
            width: 300.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ClipOval(child: FlutterLogo(size: 42.0)),
                Column(
                  children: [
                    SizedBox(height: 40.0),
                    SizedBox(
                      width: 110.0,
                      child: Center(
                        child: Text(
                          "Name from DB",
                          style: TextStyle(
                              fontSize: 14.0,
                              color: Palette.fontColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 110.0,
                      child: Center(
                        child: Text(
                          "Email from DB",
                          style: TextStyle(
                              fontSize: 14.0,
                              color: Palette.fontColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        ListTile(
          title: Row(
            children: [
              Icon(Icons.location_on_outlined),
              SizedBox(width: 20,),
              Text(
                'Bus Stops',
                style: TextStyle(fontSize: 20, color: Palette.fontColor),
              ),
            ],
          ),
          onTap: () => Navigator.of(context).push(_NewPage(1)),
        ),
        ListTile(
          title: Row(
            children: [
              Icon(Icons.favorite_border),
              SizedBox(width: 20,),
              Text(
                'Favorites',
                style: TextStyle(fontSize: 20, color: Palette.fontColor),
              ),
            ],
          ),
          onTap: () => Navigator.of(context).push(_NewPage(2)),
        ),
      ],
    );
  }
}

class _NewPage extends MaterialPageRoute<void> {
  _NewPage(int id)
      : super(builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Page $id'),
              elevation: 1.0,
            ),
            body: Center(
              child: Text('Page $id'),
            ),
          );
        });
}
