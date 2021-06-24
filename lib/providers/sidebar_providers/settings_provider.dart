import 'package:flutter/material.dart';
import 'package:goa_bus/repositories/settings_repository.dart';

class SettingsProvider with ChangeNotifier {
  String currentPassword = '', newPassword = '';
  bool loading = false;

  Future<String> savePassword(BuildContext context) async {
    loading = true;
    notifyListeners();
    String message = '';
    if (currentPassword == '')
      message = 'Please enter current password';
    else if (newPassword == '')
      message = 'Please enter new password';
    else if (currentPassword == newPassword)
      message = 'Please enter different password';
    else if (newPassword.length < 8)
      message = 'Minimum 8 characters required in new password';
    else {
      message = await SettingsRepository()
          .changePassword(currentPassword, newPassword)
          .whenComplete(() {
        loading = false;
        notifyListeners();
      });
      Navigator.pop(context);
    }
    return message;
  }
}
