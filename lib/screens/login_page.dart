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
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final prov = Provider.of<LoginProvider>(context, listen: false);
      await prov.checkAuthenticated();
      if (prov.authenticated) {
        Future(() {
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, prov, _) {
        return Scaffold(
          body: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
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
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width,
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
                                  prov.email = value;
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
                                  prov.password = value;
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
                            child: prov.loading
                                ? CircularProgressIndicator(color: Colors.white)
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
                              // }
                              String loginMessage = await prov.signInUser();
                              if (loginMessage == 'success') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()
                                    ));
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text('$loginMessage',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white)),
                                  backgroundColor: Palette.secondary,
                                ));
                              }
                            },
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Palette.secondary,
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                padding: EdgeInsets.all(20)),
                            child: prov.loading
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text("Register",
                                    style: TextStyle(
                                      color: Colors.white,
                                      letterSpacing: 1.5,
                                      fontSize: 20,
                                    )),
                            onPressed: () async {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      scrollable: true,
                                      title: Text('Login'),
                                      content: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Form(
                                          child: Column(
                                            children: <Widget>[
                                              TextFormField(
                                                  decoration: InputDecoration(
                                                    labelText: 'Email',
                                                    icon: Icon(Icons.email),
                                                  ),
                                                  onChanged: (email) {
                                                    prov.email = email;
                                                  }),
                                              TextFormField(
                                                  decoration: InputDecoration(
                                                    labelText: 'Password',
                                                    icon: Icon(Icons.lock),
                                                  ),
                                                  onChanged: (password) {
                                                    prov.password = password;
                                                  }),
                                              TextFormField(
                                                decoration: InputDecoration(
                                                  labelText: 'Confirm Password',
                                                  icon: Icon(Icons.lock),
                                                ),
                                                onChanged: (confirmPassword) {
                                                  prov.confirmPassword =
                                                      confirmPassword;
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      actions: [
                                        Center(
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: Palette.secondary,
                                                elevation: 3,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                                padding: EdgeInsets.all(20)),
                                            child: prov.loading
                                                ? CircularProgressIndicator(
                                                    color: Colors.white)
                                                : Text("Register",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      letterSpacing: 1.5,
                                                      fontSize: 20,
                                                    )),
                                            onPressed: () async {
                                              String registerMessage =
                                                  await prov.registerUser();
                                              if (registerMessage ==
                                                  'success') {
                                                Navigator.pop(context);
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'Success, you can now login using registered credentials',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  backgroundColor:
                                                      Palette.secondary,
                                                ));
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                      '$registerMessage',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  backgroundColor:
                                                      Palette.secondary,
                                                ));
                                              }
                                            },
                                          ),
                                        )
                                      ],
                                    );
                                  });

                              // showModalBottomSheet(
                              //   isScrollControlled: true,
                              //   context: context,
                              //   builder: (_) {
                              //     return Container(
                              //         height: MediaQuery.of(context).size.height * 0.5,
                              //         decoration: new BoxDecoration(
                              //           color: Palette.primary,
                              //           borderRadius: new BorderRadius.only(
                              //             topLeft: const Radius.circular(25.0),
                              //             topRight: const Radius.circular(25.0),
                              //           ),
                              //         ),
                              //         child: Column(
                              //           mainAxisAlignment: MainAxisAlignment.center,
                              //           children: [
                              //             SizedBox(
                              //               height: 50,
                              //             ),
                              //             TextField(
                              //               decoration: new InputDecoration(
                              //                   border: new OutlineInputBorder(
                              //                     borderRadius: const BorderRadius.all(
                              //                       const Radius.circular(50.0),
                              //                     ),
                              //                   ),
                              //                   hintStyle: new TextStyle(
                              //                       color: Colors.grey[800]),
                              //                   hintText: "Enter Email",
                              //                   fillColor: Colors.white70),
                              //               autofocus: false,
                              //               onChanged: (value) {
                              //                 // prov.source = value;
                              //               },
                              //             ),
                              //             SizedBox(
                              //               height: 20,
                              //             ),
                              //             TextField(
                              //               decoration: new InputDecoration(
                              //                   border: new OutlineInputBorder(
                              //                     borderRadius: const BorderRadius.all(
                              //                       const Radius.circular(50.0),
                              //                     ),
                              //                   ),
                              //                   hintStyle: new TextStyle(
                              //                       color: Colors.grey[800]),
                              //                   hintText: 'Enter Password',
                              //                   fillColor: Colors.white70),
                              //               autofocus: false,
                              //             ),
                              //             SizedBox(
                              //               height: 20,
                              //             ),
                              //             TextField(
                              //               decoration: new InputDecoration(
                              //                   border: new OutlineInputBorder(
                              //                     borderRadius: const BorderRadius.all(
                              //                       const Radius.circular(50.0),
                              //                     ),
                              //                   ),
                              //                   hintStyle: new TextStyle(
                              //                       color: Colors.grey[800]),
                              //                   hintText: 'Confirm Password',
                              //                   fillColor: Colors.white70),
                              //               autofocus: false,
                              //             ),
                              //             SizedBox(height: 20,),
                              //             ElevatedButton(
                              //               style: ElevatedButton.styleFrom(
                              //                   primary: Palette.secondary,
                              //                   elevation: 3,
                              //                   shape: RoundedRectangleBorder(
                              //                       borderRadius: BorderRadius.circular(30)),
                              //                   padding: EdgeInsets.all(20)),
                              //               child: prov.loading ?
                              //               CircularProgressIndicator(color: Colors.white)
                              //                   : Text("Register",
                              //                   style: TextStyle(
                              //                     color: Colors.white,
                              //                     letterSpacing: 1.5,
                              //                     fontSize: 20,
                              //                   )),
                              //               onPressed: () {},
                              //             ),
                              //           ],
                              //         ));
                              //   },
                              // );
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
