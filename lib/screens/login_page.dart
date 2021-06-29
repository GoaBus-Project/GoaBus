import 'package:drivers_app/common/color_pallete.dart';
import 'package:drivers_app/providers/login_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Palette.primary,
        body: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: BoxDecoration(
                  color: Palette.secondary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: const Radius.circular(80),
                    bottomRight: const Radius.circular(80),
                  ),
                ),
              ),
            ),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Consumer<LoginPageProvider>(
                      builder: (BuildContext context, prov, _) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/logo5.png',
                          width: 100,
                          height: 100,
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.perm_identity_outlined,
                                color: Palette.secondary,
                              ),
                              labelText: 'Driver ID',
                            ),
                            onChanged: (value) {
                              prov.email = value;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            onChanged: (value) {
                              prov.password = value;
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.lock_outlined,
                                color: Palette.secondary,
                              ),
                              labelText: 'Bus Number',
                            ),
                          ),
                        ),
                        SizedBox(height: 50),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Palette.secondary,
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              padding: EdgeInsets.all(20)),
                          child: Text("Login",
                              style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 1.5,
                                fontSize: 20,
                              )),
                          onPressed: () async {
                            String msg = prov.checkFields();
                            if(msg != '') {
                              Fluttertoast.showToast(
                                  msg: msg,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Palette.primary,
                                  textColor: Palette.fontColor,
                                  fontSize: 16.0
                              );
                            } else {
                              if (await prov.login()) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()),
                                );
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Incorrect details",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Palette.primary,
                                    textColor: Palette.fontColor,
                                    fontSize: 16.0
                                );
                              }
                            }
                          },
                        ),
                        SizedBox(height: 20,),
                        Visibility(
                          visible: prov.loading,
                          child: SizedBox(
                              width: 20,
                              height: 20,
                              child: Center(
                                  child: CircularProgressIndicator(
                                color: Palette.secondary,
                              ))),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}