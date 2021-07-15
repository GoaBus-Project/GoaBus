import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goabus_users/repositories/login_repository.dart';

class LoginProvider with ChangeNotifier {
  bool loading = false, authenticated = false;

  void checkAuthenticated() async {
    authenticated = await LoginRepository().userAuthenticated();
  }

  Future<bool> login(int signInMethod) async {
    loading = true;
    notifyListeners();
    switch (signInMethod) {
      case 0:
        return await LoginRepository().localSignIn("", "").whenComplete(() {
                  loading = false;
                  notifyListeners();
                }) == 'success'
            ? true
            : false;
      case 1:
        return await LoginRepository().signInWithGoogle().whenComplete(() {
                  loading = false;
                  notifyListeners();
                }) == 'success'
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
