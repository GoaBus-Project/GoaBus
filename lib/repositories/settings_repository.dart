import 'package:firebase_auth/firebase_auth.dart';
import 'package:goa_bus/repositories/login_repository.dart';

class SettingsRepository {
  Future<String> changePassword(String currentPassword, String newPassword) async {
    String message = '';

    /// Check current password
    UserCredential userCredentials = await LoginRepository()
        .localSignIn(FirebaseAuth.instance.currentUser.email, currentPassword)
    .whenComplete(() => message = 'verified')
    .onError((error, stackTrace) {
      message = 'not verified';
      return;
    });

    /// Reset password if current password is correct
    if(userCredentials != null && message == 'verified') {
      await FirebaseAuth.instance.currentUser.updatePassword(newPassword)
          .whenComplete(() => message = 'Password changed')
          .onError((error, stackTrace) {
        message = 'There was some problem, please try again';
        print(error);
      });
    } else message = 'Current password incorrect';
    return message;
  }
}