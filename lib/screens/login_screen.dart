import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goa_bus/constants/color_palette.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: Palette.primary,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'logo.png',
                          height: 200,
                          width: 200,
                        ),
                        Text(
                          'Goa Bus'.toUpperCase(),
                          style: TextStyle(
                            color: Palette.fontColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 50,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ),
          ),
          Expanded(
              flex: 2,
              child: Column(
              children: [],
            )
          )
        ],
      ),
    );
  }
}
