import 'package:firebase_auth/firebase_auth.dart';

class LoginRepository {
  Future<String> login(String email, String password) async {
    String message = '';
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if(user.user!.email != '')
        message = 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') message = 'User not found';
      if(e.code == 'wrong-password') message = 'Incorrect Password';
      print(e.code);
    } catch (e) {
      message = 'There was some problem during registration, please retry';
    }
    return message;
  }

  Future<String> changePassword(String password) async {
    String message = '';
    try {
      await FirebaseAuth.instance.currentUser!
          .updatePassword(password)
          .whenComplete(() => message = 'Success');
    } on FirebaseAuthException catch (_) {
      message = 'There was some problem, please try again';
    }
    return message;
  }
}
