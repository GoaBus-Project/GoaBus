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
                          return AlertDialog(
                            content: Stack(
                              clipBehavior: Clip.none,
                              children: <Widget>[
                                Positioned(
                                  right: -40.0,
                                  top: -40.0,
                                  child: InkResponse(
                                    splashColor: Palette.primary,
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: CircleAvatar(
                                      child: Icon(Icons.close),
                                      backgroundColor: Palette.buttonColor,
                                    ),
                                  ),
                                ),
                              Form(
                              key: _formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  // TextFormField(
                                  //   validator: (value) {
                                  //     if (value == null || value.isEmpty) {
                                  //       return 'Please enter some text';
                                  //     }
                                  //     return null;
                                  //   },
                                  //   decoration: InputDecoration(
                                  //     labelText: 'Current Password',
                                  //     icon: Icon(Icons.vpn_key_outlined),
                                  //   ),
                                  // ),
                                  TextFormField(
                                    decoration: const InputDecoration(
                                      icon: const Icon(Icons.vpn_key_outlined),
                                      labelText: 'Current Password',
                                    ),
                                    controller: textEditingController,
                                  ),
                                  TextFormField(
                                    decoration: const InputDecoration(
                                      icon: const Icon(Icons.vpn_key_outlined),
                                      labelText: 'New Password',
                                    ),
                                    controller: textEditingController,
                                  ),
                                  TextFormField(
                                    decoration: const InputDecoration(
                                      icon: const Icon(Icons.vpn_key_outlined),
                                      labelText: 'Confirm new Password',
                                    ),
                                    controller: textEditingController,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState.validate()) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(content: Text('Password changed')));
                                        }
                                      },
                                      child: Text('Submit'),
                                    ),
                                  ),
                                ],
                              ),
                            )
                              ],
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
                  onPressed: () {},
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
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
