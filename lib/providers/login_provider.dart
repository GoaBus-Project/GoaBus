import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
  List<String> greetings = ['Good Morning', 'Good Afternoon', 'Good Evening', 'Welcome'];
  String greet = '';
  String email = '';
  String password = '';
  bool loading = false;
  bool showAuthenciationAlert = false;
  bool authenticated = false;
  bool emailAuth = false;
  bool passwordAuth = false;

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

  login() async {
    loading = true;
    notifyListeners();
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: email,
          password: password
      );
      if (userCredential == null) {
        loading = false;
        showAuthenciationAlert = true;
        authenticated = false;
        notifyListeners();
        print('User is currently signed out!');
      } else {
        loading = false;
        authenticated = true;
        notifyListeners();
        print('User is signed in!');
      }
    } on FirebaseAuthException catch (e) {
      loading = false;
      if (e.code == 'user-not-found') {
        emailAuth = false;
        notifyListeners();
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        passwordAuth = false;
        notifyListeners();
        print('Wrong password provided for that user.');
      }
    }

   /* FirebaseAuth.instance
        .authStateChanges()
        .listen((User user) {
      if (user == null) {
        authenticated = false;
        print('User is currently signed out!');
      } else {
        authenticated = true;
        print('User is signed in!');
      }
    });*/
  }

}