import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goabus_users/constants/color_palette.dart';
import 'package:goabus_users/providers/login_provider.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    final prov = Provider.of<LoginProvider>(context, listen: false);
    prov.checkAuthenticated();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, prov, _) {
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          if (prov.authenticated)
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage()),
            );
        });

        return Scaffold(
          body: Stack(
            children: [
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                decoration: BoxDecoration(color: Palette.secondary),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 100),
                    Text(
                      "GoaBus",
                      style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Palette.fontColor),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.7,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: Container(
                      decoration: BoxDecoration(
                        color: Palette.primary,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(80),
                          topRight: const Radius.circular(80),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'assets/main-logo.png',
                            width: 100,
                            height: 100,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Container(
                              width: 250,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  prefixIcon: Icon(
                                    Icons.perm_identity_outlined,
                                    color: Palette.secondary,
                                  ),
                                  labelText: 'Email',
                                ),
                                onChanged: (value) {
                                  // prov.email = value;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Container(
                              width: 250,
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                onChanged: (value) {
                                  // prov.password = value;
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.lock_outlined,
                                    color: Palette.secondary,
                                  ),
                                  labelText: 'Password',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Palette.secondary,
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                padding: EdgeInsets.all(20)),
                            child: prov.loading ?
                            CircularProgressIndicator(color: Colors.white)
                                : Text("Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 1.5,
                                  fontSize: 20,
                                )),
                            onPressed: () async {
                              // String msg = prov.checkFields();
                              // if(msg != '') {
                              //   Fluttertoast.showToast(
                              //       msg: msg,
                              //       toastLength: Toast.LENGTH_SHORT,
                              //       gravity: ToastGravity.CENTER,
                              //       timeInSecForIosWeb: 1,
                              //       backgroundColor: Palette.primary,
                              //       textColor: Palette.fontColor,
                              //       fontSize: 16.0
                              //   );
                              // } else {
                              //   if (await prov.login()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()),
                              );
                            },
                          ),

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Palette.secondary,
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                padding: EdgeInsets.all(20)),
                            child: prov.loading ?
                            CircularProgressIndicator(color: Colors.white)
                                : Text("Register",
                                style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 1.5,
                                  fontSize: 20,
                                )),
                            onPressed: () async {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (_) {
                                  return Container(
                                      height: MediaQuery.of(context).size.height * 0.75,
                                      decoration: new BoxDecoration(
                                        color: Palette.primary,
                                        borderRadius: new BorderRadius.only(
                                          topLeft: const Radius.circular(25.0),
                                          topRight: const Radius.circular(25.0),
                                        ),
                                      ),
                                      child: Center(
                                        child: Column(
                                          children: [
                                            // SizedBox(
                                            //   height: 20,
                                            // ),
                                            TextField(
                                              decoration: new InputDecoration(
                                                  border: new OutlineInputBorder(
                                                    borderRadius: const BorderRadius.all(
                                                      const Radius.circular(50.0),
                                                    ),
                                                  ),
                                                  hintStyle: new TextStyle(
                                                      color: Colors.grey[800]),
                                                  hintText: "Enter Email",
                                                  fillColor: Colors.white70),
                                              autofocus: false,
                                              onChanged: (value) {
                                                // prov.source = value;
                                              },
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            TextField(
                                              decoration: new InputDecoration(
                                                  border: new OutlineInputBorder(
                                                    borderRadius: const BorderRadius.all(
                                                      const Radius.circular(50.0),
                                                    ),
                                                  ),
                                                  hintStyle: new TextStyle(
                                                      color: Colors.grey[800]),
                                                  hintText: 'Enter Password',
                                                  fillColor: Colors.white70),
                                              autofocus: false,
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            ElevatedButton(
                                                onPressed: () {
                                                  // prov.enableDisableBusList();
                                                },
                                                child: Text("Register")),
                                          ],
                                        ),
                                      ));
                                },
                              );
                            },
                          ),

                          // SizedBox(height: 20,),
                          // Visibility(
                          //   visible: prov.loading,
                          //   child: SizedBox(
                          //       width: 20,
                          //       height: 20,
                          //       child: Center(
                          //           child: CircularProgressIndicator(
                          //             color: Palette.secondary,
                          //           ))),
                          // ),
                          SizedBox(height: 50),
                          /*Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              OutlinedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                                onPressed: () async {
                                  if (await prov.login(1)) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()),
                                    );
                                  } else {
                                    Scaffold.of(context).showBottomSheet(
                                            (context) =>
                                            SnackBar(
                                                content: Text('Login failed')));
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        'assets/google-logo.png',
                                        width: 30,
                                        height: 30,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10),
                                        child: Text(
                                          'Google',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              OutlinedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                                onPressed: () async {
                                  if (await prov.login(2)) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()),
                                    );
                                  } else {
                                    Scaffold.of(context).showBottomSheet(
                                            (context) =>
                                            SnackBar(
                                                content: Text('Login failed')));
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        'assets/facebook-logo.png',
                                        width: 30,
                                        height: 30,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10),
                                        child: Text(
                                          'Facebook',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )*/
                        ],
                      )),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
