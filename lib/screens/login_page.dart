import 'package:drivers_app/constants/color_pallete.dart';

import 'home_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String id='', password='';
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
                  child: Column(
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
                            setState(() {
                              id = value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
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
                                  borderRadius: BorderRadius.circular(30)
                              ),
                              padding: EdgeInsets.all(20)
                          ),
                          child: Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 1.5,
                                fontSize: 20,
                              )
                          ),
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomePage()),
                            );
                          },
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}




// Scaffold(
// body: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Padding(
// padding: const EdgeInsets.all(10.0),
// child: TextFormField(
// autofocus: true,
// decoration: InputDecoration(
// border: UnderlineInputBorder(),
// labelText: 'Enter your email'
// ),
// onChanged: (email){},
// ),
// ),
// SizedBox(height: 15),
// Padding(
// padding: const EdgeInsets.all(10.0),
// child: TextFormField(
// decoration: InputDecoration(
// border: UnderlineInputBorder(),
// labelText: 'Enter your password',
// suffixIcon: IconButton(
// icon: Icon(
// // Based on passwordVisible state choose the icon
// // _obscureText?
// Icons.visibility,
// // : Icons.visibility_off,
// color: Theme.of(context).primaryColorDark,
// ),
// onPressed: () {
// },
// ),
// ),
// // obscureText: _obscureText,
// onChanged: (password){},
// ),
// ),
// ElevatedButton(
// style: ButtonStyle(
// backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
// ),
// onPressed: () {
// Navigator.push(
// context,
// MaterialPageRoute(builder: (context) => HomePage()),
// );
// },
// child: Padding(
// padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
// child: Text(
// "Login".toUpperCase(),
// textAlign: TextAlign.center,
// style: TextStyle(
// color: Colors.blue,
// fontWeight: FontWeight.bold,
// ),
// ),
// ),
// ),
// ]
// ),
// );