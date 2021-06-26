import 'package:drivers_app/common/color_pallete.dart';
import 'package:drivers_app/providers/homepage_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text("DRIVER APP")),
        backgroundColor: Palette.secondary,
      ),
      body: Consumer<HomePageProvider>(builder: (context, prov, _) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: RawMaterialButton(
              onPressed: () async {
                prov
                    .startStopSendingLocation(context)
                    .catchError((error, stackTrace) {
                  Fluttertoast.showToast(
                      msg: "This is Center Short Toast",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Palette.primary,
                      textColor: Palette.fontColor,
                      fontSize: 16.0);
                });
              },
              elevation: 2.0,
              fillColor: Palette.secondary,
              child: Icon(
                prov.start ? Icons.stop : Icons.location_on_outlined,
                size: 200.0,
                color: Palette.primary,
              ),
              padding: EdgeInsets.all(15.0),
              shape: CircleBorder(),
            )),
          ],
        );
      }),
    );
  }
}
