import 'package:flutter/material.dart';
import 'package:goa_bus/constants/color_pallete.dart';

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
          Container(
            color: Pallete.primary,
            child: Column(
              children: [
              ],
            )
          ),
          Column()
        ],
      ),
    );
  }
}
