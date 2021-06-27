import 'package:drivers_app/repositories/login_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPageProvider with ChangeNotifier {
  String email = '', password = '';
  bool loading = false;

  Future<bool> login() async {
    bool authenticated = false;
    loading = true;
    notifyListeners();

    if (email == "")
      return false;
    else if (!email.contains("@") ||
        (!email.contains(".com") && !email.contains(".in")))
      return false;
    else if (password == "") return false;

    try {
      UserCredential userCredential =
          await LoginRepository().login(email, password);
      if (userCredential == null) {
        loading = false;
        authenticated = false;
        print('User is currently signed out!');
        notifyListeners();
      } else {
        loading = false;
        authenticated = true;
        print('User is signed in!');
        notifyListeners();
      }
    } on FirebaseAuthException catch (e) {
      loading = false;
      authenticated = false;
      notifyListeners();
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else {
        print('Incorrect details');
      }
    }
    return authenticated;
  }
}
