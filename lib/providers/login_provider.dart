import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
  List<String> greetings = ['Good Morning', 'Good Afternoon', 'Good Evening', 'Welcome'];
  String greet = '';

  setGreeting() {
    var hour = DateTime.now().hour;
    if (hour <= 12)
      greet = greetings[0];
    else if (hour <= 17 && hour > 12)
      greet = greetings[1];
    else if (hour > 17 && hour < 20)
      greet = greetings[2];
    else
      greet = greetings[3];
  }

}