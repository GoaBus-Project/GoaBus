import 'package:flutter/material.dart';
import 'package:goa_bus/constants/color_palette.dart';
import 'package:goa_bus/constants/constants.dart';
import 'package:goa_bus/providers/login_provider.dart';
import 'package:provider/provider.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var loginProv = Provider.of<LoginProvider>(context);
    return AppBar(
      leading: Container(),
      backgroundColor: Palette.primary,
      title: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            Constants.MAIN_LOGO,
            height: 57.0,
            width: 57.0,
          ),
          Text('Admin Panel',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w100,
                color: Palette.fontColor
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.power_settings_new),
          color: Palette.fontColor,
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Sign out!"),
                  content: Text("Are you sure you want to sign out?"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("No"),
                    ),
                    TextButton(
                        onPressed: () {
                          loginProv.logout();
                          Navigator.popUntil(context, (route) =>
                            route.isFirst
                          );
                        },
                        child: Text("Sign out"),
                    ),
                  ],
                );
              }
            );
          },
        ),
      ],
    );
  }
}
