import 'package:drivers_app/common/color_pallete.dart';
import 'package:drivers_app/providers/homepage_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final textController = TextEditingController();
  String _newPassword = '', _confirmPassword = '', _sosMessage = '';

  void _sosResponse(String _message) {
    if (_message == 'success') {
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: "SOS Sent",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Palette.primary,
          textColor: Palette.fontColor,
          fontSize: 16.0);
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: "$_message",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Palette.primary,
          textColor: Palette.fontColor,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text("GoaBus Driver".toUpperCase())),
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
                      msg: "There was some problem",
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
            SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton.extended(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 600,
                              child: Center(
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text("Enter Custom Message"),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 200,
                                          margin:
                                              const EdgeInsets.only(right: 50),
                                          child: TextField(
                                            maxLines: 4,
                                            decoration: InputDecoration(
                                              labelText: "Enter Message",
                                              fillColor: Colors.white,
                                              border: new OutlineInputBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        25.0),
                                                borderSide: new BorderSide(),
                                              ),
                                            ),
                                            onChanged: (message) {
                                              _sosMessage = message;
                                            },
                                          ),
                                        ),
                                        ElevatedButton(
                                            onPressed: () async {
                                              if(!prov.loading) {
                                                _sosResponse(await prov
                                                    .sendSOS(_sosMessage));
                                              } else return;
                                            },
                                            child: prov.loading
                                                ? SizedBox(
                                                  height: 12,
                                                  width: 12,
                                                  child: CircularProgressIndicator(
                                                      color: Colors.white),
                                                )
                                                : Icon(Icons.send)),
                                      ],
                                    ),
                                    Container(
                                        margin: const EdgeInsets.only(
                                            top: 30, bottom: 30),
                                        child: Divider(
                                          thickness: 8,
                                          color: Palette.secondary,
                                        )),
                                    ListTile(
                                        title: Text("Breakdown"),
                                        onTap: () async {
                                          if(!prov.loading) {
                                            _sosResponse(
                                                await prov.sendSOS(
                                                    'Breakdown'));
                                          } else return;
                                        }),
                                    ListTile(
                                        title: Text("Hijacked"),
                                        onTap: () async {
                                          if(!prov.loading) {
                                            _sosResponse(await prov
                                                .sendSOS('Bus Hijacked'));
                                          } else return;
                                        }),
                                    ListTile(
                                        title: Text("Accident"),
                                        onTap: () async {
                                          if(!prov.loading) {
                                            _sosResponse(await prov
                                                .sendSOS('Bus Accident'));
                                          } else return;
                                        }),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    label: Row(
                      children: [
                        Icon(Icons.dangerous_rounded),
                        SizedBox(
                          width: 10,
                        ),
                        Text("SOS")
                      ],
                    )),
                SizedBox(
                  width: 50,
                ),
                FloatingActionButton.extended(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 250,
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text("Change Password"),
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: Palette.secondary,
                                      ),
                                      labelText: 'New Password',
                                    ),
                                    onChanged: (value) {
                                      _newPassword = value;
                                    },
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: Palette.secondary,
                                      ),
                                      labelText: 'Confirm New Password',
                                    ),
                                    onChanged: (value) {
                                      _confirmPassword = value;
                                    },
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () async {
                                            String message =
                                                await prov.changePassword(
                                                    _newPassword,
                                                    _confirmPassword);
                                            if (message == 'Success') {
                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  backgroundColor:
                                                      Palette.secondary,
                                                  content: const Text(
                                                      'Success, you can now sign in with your new password',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  action: SnackBarAction(
                                                    label: 'Ok',
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ),
                                              );
                                            } else {
                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  backgroundColor:
                                                      Palette.secondary,
                                                  duration:
                                                      Duration(seconds: 2),
                                                  content: Text('$message',
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                ),
                                              );
                                            }
                                          },
                                          child: prov.loading
                                              ? CircularProgressIndicator(
                                                  color: Palette.secondary)
                                              : Text("Submit")),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    label: Row(
                      children: [
                        Icon(Icons.settings),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Settings")
                      ],
                    ))
              ],
            )
          ],
        );
      }),
    );
  }
}
