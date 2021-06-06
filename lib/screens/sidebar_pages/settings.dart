import 'package:flutter/material.dart';
import 'package:goa_bus/constants/color_palette.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _formKey = GlobalKey<FormState>();
  final textEditingController = TextEditingController();
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
                  label: Text("Change Password",style: TextStyle(color: Colors.white),),
                  backgroundColor: Palette.buttonColor,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width - 1000,
                              height: MediaQuery.of(context).size.height - 500,
                              padding: EdgeInsets.all(20),
                              color: Colors.white,
                              child: Scaffold(
                                  body: Column(
                                    children: [
                                      TextFormField(
                                        decoration: InputDecoration(
                                          border: UnderlineInputBorder(),
                                          labelText: "Current Password",
                                        ),
                                        onChanged: (value) {

                                        },
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          border: UnderlineInputBorder(),
                                          labelText: "New Password",
                                        ),
                                        onChanged: (value) {

                                        },
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          border: UnderlineInputBorder(),
                                          labelText: "Confirm New Password",
                                        ),
                                        onChanged: (value) {

                                        },
                                      ),
                                      SizedBox(height: 10),
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all<Color>(Palette.secondary),
                                        ),
                                        onPressed: (){},
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
                                          child: Text(
                                            "Save".toUpperCase(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Palette.fontColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                              )
                            ),
                          );
                        });
                  },
                ),
              ],
            ),
            SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FloatingActionButton.extended(
                  label: Text("Organisation Settings",style: TextStyle(color: Colors.white),),
                  backgroundColor: Palette.buttonColor,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Center(
                            child: Container(
                                width: MediaQuery.of(context).size.width - 1000,
                                height: MediaQuery.of(context).size.height - 500,
                                padding: EdgeInsets.all(20),
                                color: Colors.white,
                                child: Scaffold(
                                    body: Column(
                                      children: [
                                        TextFormField(
                                          decoration: InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelText: "New Name",
                                          ),
                                          onChanged: (value) {

                                          },
                                        ),
                                        TextFormField(
                                          decoration: InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelText: "New Logo",
                                          ),
                                          onChanged: (value) {

                                          },
                                        ),
                                        SizedBox(height: 30),
                                        ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all<Color>(Palette.secondary),
                                          ),
                                          onPressed: (){},
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
                                            child: Text(
                                              "Save".toUpperCase(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Palette.fontColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                )
                            ),
                          );
                        });
                  },
                ),
              ],
            ),
            SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FloatingActionButton.extended(
                  label: Text("About",style: TextStyle(color: Colors.white),),
                  backgroundColor: Palette.buttonColor,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Center(
                            child: Container(
                                width: MediaQuery.of(context).size.width - 1000,
                                height: MediaQuery.of(context).size.height - 500,
                                padding: EdgeInsets.all(20),
                                color: Colors.white,
                                child: Scaffold()
                            ),
                          );
                        });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
