import 'package:drivers_app/repositories/login_repository.dart';
import 'package:flutter/material.dart';

class LoginPageProvider with ChangeNotifier {
  String email = '', password = '';
  bool loading = false;

  String checkFields() {
    String message = '';
    if (email == '') {
      return 'Enter email';
    } else if (!email.contains("@") ||
        (!email.contains(".com") && !email.contains(".in"))) {
      return 'Incorrect email format';
    } else if (password == "") {
      return 'Enter password';
    }
    return message;
  }

  Future<String> login() async {
    loading = true;
    notifyListeners();
    return await LoginRepository().login(email, password).whenComplete(() {
      loading = false;
      notifyListeners();
    });
  }
}
