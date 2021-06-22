import 'package:drivers_app/providers/homepage_provider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Driver App",
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("DRIVER APP")),
          backgroundColor: Color(0xFF0061A8),
        ),
        body: SingleChildScrollView(
          child: Consumer<HomepageProvider>(
            builder: (context, prov, _){
              return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Center(
                          child: Text(
                            "Select A Bus",
                            style: TextStyle(
                                fontSize: 25,
                                color: Color(0xFF0061A8),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        DropDownField(
                          onValueChanged: (dynamic value) {
                            setState(() {
                              prov.selected = value.toString();
                            });
                          },
                          itemsVisibleInDropdown: 3,
                          controller: textController,
                          enabled: true,
                          value: prov.selected,
                          required: false,
                          hintText: 'Choose a country',
                          labelText: 'Country',
                          items: prov.items,
                        ),
                      ]
                  ),
                ),
                SizedBox(height: 10,),
                Center(
                    child: Text(
                        prov.selected,
                        style:TextStyle(
                            fontSize: 40,
                            color: Color(0xFF0061A8)
                        )
                    )
                ),
                SizedBox(height: 50),
                prov.clicked?
                RawMaterialButton(
                  onPressed: () {
                    prov.stopSendingLocation();
                  },
                  elevation: 2.0,
                  fillColor: Color(0xFF0061A8),
                  child: Icon(
                    Icons.stop,
                    size: 200.0,
                    color: Color(0xFFFBE0C4),
                  ),
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(),
                )
                :RawMaterialButton(
                  onPressed: () {
                      prov.startSendingLocation();
                  },
                  elevation: 2.0,
                  fillColor: Color(0xFF0061A8),
                  child: Icon(
                    Icons.location_on_outlined,
                    size: 200.0,
                    color: Color(0xFFFBE0C4),
                  ),
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(),
                )
              ],
              );
            }
          ),
        ),
      ),
    );
  }
}
