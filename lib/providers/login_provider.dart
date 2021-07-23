import 'package:flutter/material.dart';
import 'package:goabus_users/repositories/login_repository.dart';

class LoginProvider with ChangeNotifier {
  bool loading = false, authenticated = false;
  String email = '', password = '', confirmPassword = '';

  Future<void> checkAuthenticated() async {
    authenticated = await LoginRepository().userAuthenticated();
  }
  
  Future<String> registerUser() async {
    String message = '';
    loading = true;
    notifyListeners();

    if(email.isEmpty) {
      loading = false;
      notifyListeners();
      return 'Please enter email';
    } else if (!email.contains('@') ||
        (!email.contains('.com') && !email.contains('.in'))) {
      loading = false;
      notifyListeners();
      return 'Incorrect email format';
    } else if(password.isEmpty) {
      loading = false;
      notifyListeners();
      return 'Please enter password';
    } else if (password.length < 8) {
      loading = false;
      notifyListeners();
      return 'Password must be 8 characters long';
    } else if(confirmPassword.isEmpty) {
      loading = false;
      notifyListeners();
      return 'Please confirm password';
    }

    if(password.compareTo(confirmPassword) == 0) {
      message = await LoginRepository()
          .createUserProfile(email, password)
          .whenComplete(() {
        loading = false;
        notifyListeners();
      });
    } else {
      loading = false;
      notifyListeners();
      return 'Password mismatch';
    }
    return message;
  }

  Future<String> signInUser() async {
    loading = true;
    notifyListeners();
    if(email.isEmpty) {
      loading = false;
      notifyListeners();
      return 'Please enter email';
    } else if (!email.contains('@') ||
        (!email.contains('.com') && !email.contains('.in'))) {
      loading = false;
      notifyListeners();
      return 'Incorrect email format';
    } else if(password.isEmpty) {
      loading = false;
      notifyListeners();
      return 'Please enter password';
    } else if (password.length < 8) {
      loading = false;
      notifyListeners();
      return 'Incorrect password';
    } else return await LoginRepository()
          .localSignIn(email, password)
          .whenComplete(() {
        loading = false;
        notifyListeners();
      });
  }

  Future<void> signOut() async {
    await LoginRepository().signOut();
  }
}
