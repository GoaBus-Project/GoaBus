import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:goa_bus/constants/color_palette.dart';
import 'package:goa_bus/constants/constants.dart';
import 'package:goa_bus/providers/login_provider.dart';
import 'package:goa_bus/screens/home_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  /// Initially password is obscure
  bool _obscureText = true;

  /// Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Widget _validationMessage(String message, bool visibility) {
    return Visibility(
      child: Text(message,
        style: TextStyle(
            color: message == "Signed in" ? Colors.green : Colors.red
        ),
      ),
      visible: visibility,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                  color: Palette.secondary,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              Constants.MAIN_LOGO,
                              height: 200,
                              width: 200,
                            ),
                            Text(
                              "Goa Bus".toUpperCase(),
                              style: TextStyle(
                                color: Palette.fontColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 60,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
              ),
            ),
            Consumer<LoginProvider>(
              builder: (context, loginProv, _) {
                if(loginProv.authenticated) {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    Navigator.push(
                        context, MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ));
                  });
                  loginProv.showAuthenciationAlert = false;
                }
                return Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 180,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      width: 3, color: Palette.secondary),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  "Login".toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Palette.secondary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 60),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${loginProv.setGreeting()},",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 35,
                                  ),
                                ),
                                Text(
                                  "Admin",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 35,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 60),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                              ),
                              onPressed: () {
                                loginProv.googleAuthentication = true;
                                loginProv.login();
                              },
                              child: SizedBox(
                                height: 40,
                                width: 300,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset(
                                      Constants.GOOGLE_LOGO,
                                      height: 40,
                                      width: 40,
                                    ),
                                    Text(
                                      "Sign in with Google",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 60),
                            Text(
                              "or",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 300,
                          child: Column(
                            children: [
                              _validationMessage(
                                  loginProv.authenticationMessage,
                                  loginProv.showAuthenciationAlert
                              ),
                              SizedBox(height: 15),
                              TextFormField(
                                decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'Enter your email'
                                ),
                                onChanged: (email){
                                  loginProv.setEmail(email);
                                },
                              ),
                              SizedBox(height: 15),
                              TextFormField(
                                decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'Enter your password',
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      // Based on passwordVisible state choose the icon
                                      _obscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                    onPressed: () {
                                     _toggle();
                                    },
                                  ),
                                ),
                                obscureText: _obscureText,
                                onChanged: (password){
                                  loginProv.setPassword(password);
                                },
                              ),
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Palette.secondary),
                                    ),
                                    onPressed: () {
                                      loginProv.googleAuthentication = false;
                                      loginProv.login();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
                                      child: Text(
                                        "Login".toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Palette.fontColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      loginProv.forgotPassword();
                                    },
                                    child: Text(
                                      "Forgot Password",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Visibility(
                                child: CircularProgressIndicator(
                                  backgroundColor: Palette.primary,
                                ),
                                visible: loginProv.loading,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                );
              }
            )
          ],
        ),
    );
  }
}
