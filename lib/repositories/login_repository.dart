import 'package:firebase_auth/firebase_auth.dart';

class LoginRepository {
  Future<UserCredential> getUserCredentials(String email, String password) {
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}