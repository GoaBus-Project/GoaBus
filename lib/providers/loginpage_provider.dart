import 'package:drivers_app/repositories/login_repository.dart';
import 'package:flutter/material.dart';

class LoginPageProvider with ChangeNotifier{
  String id = '', password = '';

  Future<bool> login() async {
    return await LoginRepository().login(id,password);
  }
}