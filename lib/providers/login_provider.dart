import 'package:flutter/material.dart';
import 'package:goabus_users/repositories/login_repository.dart';

class LoginProvider with ChangeNotifier {
  bool loading = false, authenticated = false;

  void checkAuthenticated() async {
    authenticated =
    await LoginRepository().signInWithGoogle()!=null?true:false;
  }

  Future<bool> login(int signInMethod) async {
    loading = true;
    notifyListeners();
    switch (signInMethod) {
      case 0:
        return await LoginRepository().localSignIn("", "") != null
            ? true
            : false;
      case 1:
        return await LoginRepository().signInWithGoogle() != null
            ? true
            : false;
      // case 2:
      //   return await LoginRepository().signInWithFacebook() != null
      //       ? true
      //       : false;
    }
    loading = false;
    notifyListeners();
    return false;
  }
}
