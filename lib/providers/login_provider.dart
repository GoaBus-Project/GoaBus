import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goabus_users/repositories/login_repository.dart';

class LoginProvider with ChangeNotifier {
  bool loading = false, authenticated = false;

  void checkAuthenticated() async {
    authenticated =
    await LoginRepository().userAuthenticated();
  }

  Future<bool> login(int signInMethod) async {
    loading = true;
    notifyListeners();
    UserCredential userCredential;
    switch (signInMethod) {
      case 0:
        userCredential = await LoginRepository().localSignIn("", "");
        loading = false;
        notifyListeners();
        return userCredential != null
            ? true
            : false;
      case 1:
        userCredential = await LoginRepository().signInWithGoogle();
        loading = false;
        notifyListeners();
        return userCredential != null
            ? true
            : false;
      // case 2:
      //   userCredential.user = await LoginRepository().signInWithFacebook();
      //   return userCredential != null
      //       ? true
      //       : false;
    }
    loading = false;
    notifyListeners();
    return false;
  }

  Future<void> signOut() async {
    await LoginRepository().signOut();
  }
}
